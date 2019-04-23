#!/usr/bin/env python
# coding: utf-8


# rospy for the subscriber
import rospy
# ROS Image message
from sensor_msgs.msg import CompressedImage
# ROS Image message -> OpenCV2 image converter
from cv_bridge import CvBridge, CvBridgeError
# OpenCV2 for saving an image
import cv2
import numpy as np

from tiggo_msgs.msg import pedestrian
from tiggo_msgs.msg import CrossLine
from tiggo_msgs.msg import RealCurb
from laneline import laneline

# Instantiate CvBridge
bridge = CvBridge()

pedestrian_pub = 1
global imshape
imshape = [360, 640]

import os
import math
import random
import time
import numpy as np
import tensorflow as tf
import cv2

slim = tf.contrib.slim
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

import sys
sys.path.append('../')
from nets import ssd_vgg_300, ssd_common, np_methods, ssd_vgg_512
from preprocessing import ssd_vgg_preprocessing

import visualization

tf.reset_default_graph()

gpu_options = tf.GPUOptions(allow_growth=True)
config = tf.ConfigProto(log_device_placement=False, gpu_options=gpu_options)
isess = tf.InteractiveSession(config=config)

filter_valid = [0]*15
filter_distance = [-1]*15
filter_bbox = [0]*15

filter_valid_front = [0]*15
filter_distance_front = [-1]*15
filter_bbox_front = [0]*15

# Input placeholder.
net_shape = (300, 300)
#net_shape = (512, 512)
data_format = 'NHWC'
img_input = tf.placeholder(tf.uint8, shape=(None, None, 3))
# Evaluation pre-processing: resize to SSD net shape.
image_pre, labels_pre, bboxes_pre, bbox_img = ssd_vgg_preprocessing.preprocess_for_eval(
    img_input, None, None, net_shape, data_format, resize=ssd_vgg_preprocessing.Resize.WARP_RESIZE)
image_4d = tf.expand_dims(image_pre, 0)

# Define the SSD model.
reuse = True if 'ssd_net' in locals() else None

ssd_net = ssd_vgg_300.SSDNet()
#ssd_net = ssd_vgg_512.SSDNet()

with slim.arg_scope(ssd_net.arg_scope(data_format=data_format)):
    predictions, localisations, _, _ = ssd_net.net(image_4d, is_training=False, reuse=reuse)

# Restore SSD model.
#ckpt_filename = '../checkpoints/ssd_300_vgg.ckpt'
ckpt_filename = '../checkpoints/VGG_VOC0712_SSD_300x300_ft_iter_120000.ckpt'
#ckpt_filename = '../checkpoints/VGG_VOC0712_SSD_512x512_ft_iter_120000.ckpt'
isess.run(tf.global_variables_initializer())
saver = tf.train.Saver()
saver.restore(isess, ckpt_filename)

# SSD default anchor boxes.
ssd_anchors = ssd_net.anchors(net_shape)

'''
global crossline_valid
global crossline_distance
global right_curb_valid
global right_curb_top_x
global right_curb_top_y
global right_curb_down_x
global right_curb_down_y
global left_curb_valid
global left_curb_top_x
global left_curb_top_y
global left_curb_down_x
global left_curb_down_y
'''
crossline_valid = 0
right_curb_valid = 0
left_curb_valid = 0

left_curb_top_x = -3
left_curb_top_y = 7.43684
left_curb_down_x = -3
left_curb_down_y = 17.89295

right_curb_top_x = 3.4
right_curb_top_y = 0
right_curb_down_x = 3.4
right_curb_down_y= 30

crossline_distance = 20

# # Main image processing routine.
def process_image(img, select_threshold=0.15 , nms_threshold=.45, net_shape=(300, 300)):
    # Run SSD network.
    rimg, rpredictions, rlocalisations, rbbox_img = isess.run([image_4d, predictions, localisations, bbox_img],
                                                              feed_dict={img_input: img})

    # Get classes and bboxes from the net outputs.
    rclasses, rscores, rbboxes = np_methods.ssd_bboxes_select(
        rpredictions, rlocalisations, ssd_anchors,
        select_threshold=select_threshold, img_shape=net_shape, num_classes=21, decode=True)

    rbboxes = np_methods.bboxes_clip(rbbox_img, rbboxes)
    rclasses, rscores, rbboxes = np_methods.bboxes_sort(rclasses, rscores, rbboxes, top_k=400)
    rclasses, rscores, rbboxes = np_methods.bboxes_nms(rclasses, rscores, rbboxes, nms_threshold=nms_threshold)
    # Resize bboxes to original image shape. Note: useless for Resize.WARP!
    rbboxes = np_methods.bboxes_resize(rbbox_img, rbboxes)
    return rclasses, rscores, rbboxes


def lidar_cnr_to_img_single(corners):

    #rewrite by jackqian
    
    P2 = np.array([[1714.673702, 0, 588.860101],[0, 1764.248025, 316.554376],[0,0,1]])
    Tr = np.array([[1,0,0,-0.071],[0,0,-1,-0.454],[0,1,0,0.856]])
    
    P2 = P2.reshape((3, 3))
    Tr = Tr.reshape((3, 4))


    assert P2.shape == (3, 3)
    assert Tr.shape == (3, 4)
    assert corners.shape == (3,2)

    corners = np.vstack((corners, np.ones(2)))

    mat2 = np.dot(P2, Tr)
    img_cor = np.dot(mat2, corners)
    img_cor = img_cor / img_cor[2]

    return img_cor

def process_multipersons(classes, scores, bboxes):
    #select the pedestrians inside two curbs and crossline

    global crossline_valid, crossline_distance
    global left_curb_valid, left_curb_top_x, left_curb_top_y, left_curb_down_x, left_curb_down_y
    global right_curb_valid, right_curb_top_x, right_curb_top_y, right_curb_down_x, right_curb_down_y 
    
    valid = 0
    distance = -1
    ymax = -1
    bbox = []
    
    fit_left = np.zeros(2)
    fit_right = np.zeros(2)
    
    fit_left_large = np.polyfit((0,260),(imshape[0]-30, 200), 1)    
    fit_right_large = np.polyfit((400,imshape[1]), (200,imshape[0]-50), 1)
    
    '''
    if crossline_valid == 1:
    
        distance_min = crossline_distance-3
        distance_max = crossline_distance+6
        
        y_max = calculate_pixels(distance_min)*imshape[0]
        y_min = calculate_pixels(distance_max)*imshape[0]
           
    
    if left_curb_valid == 1:
        left_curb_lidar_corner = np.array([[left_curb_top_x+1, left_curb_down_x+1], [left_curb_top_y, left_curb_down_y], [-1.9, -1.9]])
        left_curb_image = lidar_cnr_to_img_single(left_curb_lidar_corner)
        left_curb_image = left_curb_image/2
    '''    
    


    for i in range(classes.shape[0]):
        cls_id = int(classes[i])
        if cls_id == 15:

            X = (bboxes[i,1] + bboxes[i,3])/2 * imshape[1]
            Y = bboxes[i,2]*imshape[0]
            
            if left_curb_valid == 1:
                left_curb_lidar_corner = np.array([[left_curb_top_x, left_curb_down_x], [left_curb_top_y, left_curb_down_y], [-1.9, -1.9]])
                left_curb_image = lidar_cnr_to_img_single(left_curb_lidar_corner)
                left_curb_image = left_curb_image/2
                
                fit_left = np.polyfit((left_curb_image[0,0], left_curb_image[0,1]), (left_curb_image[1,0], left_curb_image[1,1]), 1)    

            if right_curb_valid == 1:
                right_curb_lidar_corner = np.array([[right_curb_top_x, right_curb_down_x], [right_curb_top_y, right_curb_down_y], [-1.9, -1.9]])
                right_curb_image = lidar_cnr_to_img_single(right_curb_lidar_corner)
                right_curb_image = right_curb_image/2
                
                
                fit_right = np.polyfit((right_curb_image[0,0], right_curb_image[0,1]), (right_curb_image[1,0],right_curb_image[1,1]), 1)


            left = max(X*fit_left[0]+fit_left[1], X*fit_left_large[0]+fit_left_large[1])
            right = max(X*fit_right[0]+fit_right[1], X*fit_right_large[0]+fit_right_large[1])
                
            if left < Y and right < Y and Y > 200:
                
                valid = 1
                if bboxes[i, 2] > ymax:
                    bbox = bboxes[i,:]
                    ymax = bboxes[i, 2]
     
    if valid == 1 and ymax < 0.71:
        distance = 81 - ymax*100
        
    elif valid == 1:
        distance = 10 - (ymax - 0.71) * 25
  
    return valid, distance, bbox
    
def letsgo(classes, scores, bboxes):
    #select pedestrians in front of the vehicle
    
    fit_left = np.polyfit((50+20,290),(imshape[0], 200), 1)    
    fit_right = np.polyfit((370-20,imshape[1]-50), (200,imshape[0]), 1)
    
    valid_front = 0
    distance = -1
    ymax = 0
    bbox = []
    
    for i in range(classes.shape[0]):
        cls_id = int(classes[i])
        if cls_id == 15:

            X = (bboxes[i,1] + bboxes[i,3])/2 * imshape[1]
            Y = bboxes[i,2]*imshape[0]
            
            if X*fit_left[0]+fit_left[1] < Y and X*fit_right[0]+fit_right[1] < Y and Y > 200:
                
                valid_front = 1
                if bboxes[i, 2] > ymax:
                    bbox = bboxes[i,:]
                    ymax = bboxes[i, 2]
                
    if valid_front == 1 and ymax < 0.71:
        distance = 81 - ymax*100
        
    elif valid_front == 1:
        distance = 10 - (ymax - 0.71) * 25
 
    return valid_front, distance, bbox

def filter_pn(valid, distance,bbox):
    #filter the results and record 15 framess
    
    global filter_valid 
    global filter_distance
    global filter_bbox
    
    filter_valid.append(valid)
    filter_valid.pop(0)
    filter_distance.append(distance)
    filter_distance.pop(0)
    filter_bbox.append(bbox)
    filter_bbox.pop(0)
    
    if filter_valid.count(1) > 5:
        for i in range(15):
            if filter_valid[14-i] == 1 :
                valid = filter_valid[14-i]
                distance = filter_distance[14-i]
                bbox = filter_bbox[14-i]
             
                break
                
    else:
        valid = 0
        distance = -1
        bbox = []
 
    return valid, distance, bbox
    
def filter_pn_front(distance,bbox,valid):
    #filter the results and record 15 framess
    global filter_distance_front
    global filter_bbox_front
    global filter_valid_front
    

    filter_distance_front.append(distance)
    filter_distance_front.pop(0)
    filter_bbox_front.append(bbox)
    filter_bbox_front.pop(0)
    filter_valid_front.append(valid)
    filter_valid_front.pop(0)
    
    if filter_valid_front.count(1) > 5:
        for i in range(15):
            if filter_valid_front[14-i] == 1 :
                distance = filter_distance_front[14-i]
                bbox = filter_bbox_front[14-i]
                valid = filter_valid_front[14-i]
                break
                
    else:
       
        distance = -1
        bbox = []
        front_valid = 0
    return distance, bbox, valid

def image_callback(msg):
    time_start = time.time()
    
    
    #print("Received an image!")
    try:
        # Convert your ROS Image message to OpenCV2

        np_arr = np.fromstring(msg.data, np.uint8)
        

        cv2_img = cv2.imdecode(np_arr, cv2.CV_LOAD_IMAGE_COLOR)

    except CvBridgeError, e:
        print(e)
    else:
        # Save your OpenCV2 image as a jpeg



        cv2_img = cv2.resize(cv2_img, (cv2_img.shape[1]/2, cv2_img.shape[0]/2))
        # cv2_img = cv2.resize(cv2_img, (342, 274))

        #cv2.imwrite("test.jpg", cv2_img)
        
           
        image_process(cv2_img)
    detection_time = time.time() - time_start
    #print "Detection time: ", detection_time

def crossline_callback(data):
    global crossline_valid, crossline_distance

    crossline_valid = data.valid
    crossline_distance = data.distance
    
    #print "crosline:", data.valid,data.distance
    
def right_curb_callback(data):

    global right_curb_valid, right_curb_top_x, right_curb_top_y, right_curb_down_x, right_curb_down_y 

    right_curb_valid = data.vaild
    right_curb_top_x = data.top_x
    right_curb_top_y = data.top_y
    right_curb_down_x = data.down_x
    right_curb_down_y = data.down_y
    
    pass
    
    #print "right_curb:", data.vaild,data.top_x,data.top_y,data.down_x,data.down_y
def left_curb_callback(data):
    global left_curb_valid, left_curb_top_x, left_curb_top_y, left_curb_down_x, left_curb_down_y

    left_curb_valid = data.vaild
    left_curb_top_x = data.top_x
    left_curb_top_y = data.top_y
    left_curb_down_x = data.down_x
    left_curb_down_y = data.down_y
    
    pass
    
    #print "left_curb:",data.vaild,data.top_x,data.top_y,data.down_x,data.down_y
    
def calculate_pixels(distance):
    if distance > 10:
        return (81.0-distance)/100.0
    else:
        return (10.0-distance)/25.0+0.71

def drawlines(img):
    crossline_valid = 0
    if crossline_valid == 1:
        
        distance_min = crossline_distance-3
        distance_max = crossline_distance+6
        
        y_max = calculate_pixels(distance_min)*imshape[0]
        y_min = calculate_pixels(distance_max)*imshape[0]

        cv2.line(img, (0, int(y_min)),(imshape[1], int(y_min)), (255,255,255), 1)
        cv2.line(img, (0, int(y_max)),(imshape[1], int(y_max)), (255,255,255), 1)

    if left_curb_valid == 1:
        
        left_curb_lidar_corner = np.array([[left_curb_top_x, left_curb_down_x], [left_curb_top_y, left_curb_down_y], [-1.9, -1.9]])
        left_curb_image = lidar_cnr_to_img_single(left_curb_lidar_corner)
        left_curb_image = left_curb_image/2

        cv2.line(img, (int(left_curb_image[0,0]), int(left_curb_image[1,0])),(int(left_curb_image[0,1]), int(left_curb_image[1,1])), (255,255,255), 3)
    
    if right_curb_valid == 1:
        right_curb_lidar_corner = np.array([[right_curb_top_x, right_curb_down_x], [right_curb_top_y, right_curb_down_y], [-1.9, -1.9]])
        right_curb_image = lidar_cnr_to_img_single(right_curb_lidar_corner)
        right_curb_image = right_curb_image/2
       
        cv2.line(img, (int(right_curb_image[0,0]), int(right_curb_image[1,0])),(int(right_curb_image[0,1]), int(right_curb_image[1,1])), (255,255,255), 3)
    
    #cv2.line(img, (0,imshape[0]),(260, 200), (255,0,0), 3)
    #print imshape[0]-40
    
    
    return img

def image_process(cv2_img):
 
    img = cv2_img
    
    rclasses, rscores, rbboxes =  process_image(img)
    
    # visualization.bboxes_draw_on_img(img, rclasses, rscores, rbboxes, visualization.colors_plasma)
    #visualization.plt_bboxes_pedestrian(img, rclasses, rscores, rbboxes)
    #visualization.cv2_bboxes_pedestrian(img, rclasses, rscores, rbboxes)
    
    valid, distance, bbox = process_multipersons(rclasses, rscores, rbboxes)
    valid_front, distance_front, bbox_front = letsgo(rclasses, rscores, rbboxes)
    
    img = drawlines(img)
    
    valid, distance,bbox = filter_pn(valid, distance,bbox)
    distance_front,bbox_front,valid_front = filter_pn_front(distance_front,bbox_front ,valid_front)
    
    if distance == -1:
        distance = distance_front
        
    visualization.ivfc_pedestrian(img, bbox)
    visualization.ivfc_pedestrian(img, bbox_front)

    valid_front = 0

    global pedestrian_pub
    output = pedestrian()
    output.header.stamp = rospy.get_rostime()
    output.stop_signal = valid
    output.min_dist = distance
    output.front_pedestrian = valid_front
    #output.front_pedestrian = 0
    #print(output)
    pedestrian_pub.publish(output)
    
    print valid,valid_front, distance



def main():
    global pedestrian_pub
    rospy.init_node('ped_detection')
    # Define your image topic
    image_topic = "/axis/image_rect_color/compressed"
    crossline_topic = "/CrossLine"
    right_curb_topic = "/right_curb_jibo"
    left_curb_topic = "/left_curb_jibo"
    
    # Set up your subscriber and define its callback
    rospy.Subscriber(image_topic, CompressedImage, image_callback)
    rospy.Subscriber(crossline_topic, CrossLine, crossline_callback)
    
    rospy.Subscriber(right_curb_topic, RealCurb, right_curb_callback)
    rospy.Subscriber(left_curb_topic, RealCurb, left_curb_callback)
    
    # publish results
    pedestrian_pub = rospy.Publisher("/pedestrian", pedestrian, queue_size=1)
    # Spin until ctrl + c
    rospy.spin()


if __name__ == '__main__':
    main()
