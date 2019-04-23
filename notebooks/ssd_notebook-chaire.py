#!/usr/bin/env python
# coding: utf-8


# rospy for the subscriber
import rospy
# ROS Image message
from sensor_msgs.msg import CompressedImage
from tiggo_msgs.msg import MapTarget

# ROS Image message -> OpenCV2 image converter
from cv_bridge import CvBridge, CvBridgeError
# OpenCV2 for saving an image
import cv2
import numpy as np

from std_msgs.msg import Bool
from std_msgs.msg import Int16MultiArray



from laneline import laneline

# Instantiate CvBridge
bridge = CvBridge()

pedestrian_pub = 1
global imshape
imshape = [360, 640]

current_line = 1

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

tf.reset_default_graph()



def define_twolines():
     
    '''
    setline_green = np.array([[0,imshape[0]-30],
                        [260, 200],
                        [400, 200],
                        [imshape[1],imshape[0]-50]])
                        
    setline_red = np.array([[0,imshape[0]-30],
                    [260, 200],
                    [370-20, 200],
                    [imshape[1]-50,imshape[0]]])
    '''
           
    setline_green = np.array([[0,imshape[0]-30],
                    [210, 220],
                    [440, 220],
                    [imshape[1],imshape[0]-50]])
                        
    setline_red = np.array([[0,imshape[0]-30],
                    [210, 220],
                    [390, 220],
                    [imshape[1]-50,imshape[0]]])
                    
    return setline_green, setline_red
                    

# # Main image processing routine.
def process_image(img, select_threshold=0.3, nms_threshold=.45, net_shape=(300, 300)):
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



def process_multipersons(classes, scores, bboxes):
    #select the pedestrians inside two curbs
    
    valid = 0
    distance = -1
    ymax = -1
    bbox = []
    
    #fit_left_large = np.polyfit((0,260),(imshape[0]-30, 200), 1)    
    #fit_right_large = np.polyfit((400,imshape[1]), (200,imshape[0]-50), 1)
    
    setline_green, setline_red = define_twolines()
    
    fit_left_large = np.polyfit((setline_green[0][0], setline_green[1][0]),(setline_green[0][1], setline_green[1][1]), 1)    
    fit_right_large = np.polyfit((setline_green[2][0], setline_green[3][0]), (setline_green[2][1], setline_green[3][1]), 1)

    for i in range(classes.shape[0]):
        cls_id = int(classes[i])
        if cls_id == 15 : #15行人 7车辆

            X = (bboxes[i,1] + bboxes[i,3])/2 * imshape[1]
            Y = bboxes[i,2]*imshape[0]

            left = X*fit_left_large[0]+fit_left_large[1]
            right = X*fit_right_large[0]+fit_right_large[1]
                
            if left < Y and right < Y and Y > setline_green[1][1]:
                
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
    
    #fit_left = np.polyfit((50+20,290),(imshape[0], 200), 1)    
    #fit_right = np.polyfit((370-20,imshape[1]-50), (200,imshape[0]), 1)
    
    setline_green, setline_red = define_twolines()
    
    fit_left = np.polyfit((setline_red[0][0], setline_red[1][0]),(setline_red[0][1], setline_red[1][1]), 1)    
    fit_right = np.polyfit((setline_red[2][0], setline_red[3][0]), (setline_red[2][1], setline_red[3][1]), 1)
    
    valid_front = 0
    distance = -1
    ymax = 0
    bbox = []
    
    for i in range(classes.shape[0]):
        cls_id = int(classes[i])
        if cls_id == 15:

            X = (bboxes[i,1] + bboxes[i,3])/2 * imshape[1]
            Y = bboxes[i,2]*imshape[0]
            
            if X*fit_left[0]+fit_left[1] < Y and X*fit_right[0]+fit_right[1] < Y and Y > setline_red[1][1]:
                
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



        # cv2_img = cv2.resize(cv2_img, (cv2_img.shape[1]/2, cv2_img.shape[0]/2))
        # cv2_img = cv2.resize(cv2_img, (342, 274))

        #cv2.imwrite("test.jpg", cv2_img)
        
           
        image_process(cv2_img)
    detection_time = time.time() - time_start
    #print "Detection time: ", detection_time
    

def image_process(cv2_img):
 
    img = cv2_img
    
    #print(current_line)
    
    rclasses, rscores, rbboxes =  process_image(img)
    visualization.cv2_bboxes_chaire(img, rclasses, rscores, rbboxes)
    
    '''
    valid, distance, bbox = process_multipersons(rclasses, rscores, rbboxes)
    valid_front, distance_front, bbox_front = letsgo(rclasses, rscores, rbboxes)
    
    valid, distance,bbox = filter_pn(valid, distance,bbox)
    distance_front,bbox_front,valid_front = filter_pn_front(distance_front,bbox_front ,valid_front)
    
    if distance == -1:
        distance = distance_front
     
    #visualization.ivfc_pedestrian(img, bbox)
    #visualization.ivfc_pedestrian(img, bbox_front)

    #valid_front = 0

    global pedestrian_pub


    if current_line == 1:
        stop = valid_front
            
    else:
        stop = valid
        
    pedestrian_pub.publish(stop)
    
    #output.header.stamp = rospy.get_rostime()
    #output.stop_signal = valid
    #output.front_pedestrian = valid_front
    #output.min_dist = distance
    #output.front_pedestrian = valid_front
    #output.front_pedestrian = 0
    #print(output)
    #pedestrian_pub.publish(output)
    
    print stop, valid, valid_front, distance, current_line
    '''

def current_line_callback(data):
    
    ###print(current_line)    
    
    global current_line
    current_line = data.targetWay
    
    
def main():
    global pedestrian_pub
    rospy.init_node('ped_detection')
    # Define your image topic
    image_topic = "/axis/image_rect_color/compressed"
    current_line_topic = "/map_target"
    
    # Set up your subscriber and define its callback
    rospy.Subscriber(image_topic, CompressedImage, image_callback)
    rospy.Subscriber(current_line_topic, MapTarget, current_line_callback)

    # publish results
    pedestrian_pub = rospy.Publisher("/pedestrian", Bool, queue_size=1)
    # Spin until ctrl + c
    rospy.spin()


if __name__ == '__main__':
    main()
