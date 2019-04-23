import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import cv2
#import imageio
#imageio.plugins.ffmpeg.download()
#from moviepy.editor import VideoFileClip
#from IPython.display import HTML

ymin = 200

def laneline(image):
# Read in and grayscale the image
    #image = mpimg.imread('exit-ramp.jpg')
    #image = mpimg.imread('test_images/solidWhiteRight.jpg')
    gray = cv2.cvtColor(image,cv2.COLOR_RGB2GRAY)

    # Define a kernel size and apply Gaussian smoothing
    kernel_size = 5
    blur_gray = cv2.GaussianBlur(gray,(kernel_size, kernel_size),0)

    # Define our parameters for Canny and apply
    low_threshold = 50
    high_threshold = 150
    edges = cv2.Canny(blur_gray, low_threshold, high_threshold)

    # Next we'll create a masked edges image using cv2.fillPoly()
    mask = np.zeros_like(edges)
    ignore_mask_color = 255

    # This time we are defining a four sided polygon to mask
    imshape = image.shape

    vertices = np.array([[(0,imshape[0]),(300, ymin), (340, ymin), (imshape[1],imshape[0])]], dtype=np.int32)
    cv2.fillPoly(mask, vertices, ignore_mask_color)
    masked_edges = cv2.bitwise_and(edges, mask)
    cv2.imshow("mask", masked_edges)
    cv2.waitKey(1)


    # Define the Hough transform parameters
    # Make a blank the same size as our image to draw on
    rho = 2 # distance resolution in pixels of the Hough grid
    theta = np.pi/180 # angular resolution in radians of the Hough grid
    threshold = 15     # minimum number of votes (intersections in Hough grid cell)
    min_line_length = 40 #minimum number of pixels making up a line
    max_line_gap = 20    # maximum gap in pixels between connectable line segments
    line_image = np.copy(image)*0 # creating a blank to draw lines on

    # Run Hough on edge detected image
    # Output "lines" is an array containing endpoints of detected line segments
    lines = cv2.HoughLinesP(masked_edges, rho, theta, threshold, np.array([]),
                                min_line_length, max_line_gap)

    # Iterate over the output "lines" and draw lines on a blank image

    '''
    slopenum = [0]

    for line in lines:
        for x1,y1,x2,y2 in line:
            slope=(y2-y1)/(x2-x1)
            for slope1 in slopenum:
                if (slope-slope1 < 20):
                    cv2.line(line_image, (x1, y1), (x2, y2), (255, 0, 0), 10)

                else:
                    cv2.line(line_image, (x1, y1), (x2, y2), (255, 0, 0), 10)
                    slopenum.append ( (y2-y1)/(x2-x1) )

    '''
    left=np.array([0,0])
    right=np.array([0,0])
    leftnum=0
    rightnum=0
    test_image = np.copy(image)
    
    #print(lines.shape[1])
    for line in lines:
        for x1,y1,x2,y2 in line:
            
            cv2.line(test_image, (x1, y1), (x2, y2), (255, 255, 0), 5)

            cv2.imshow("test",test_image)
            cv2.waitKey(1)
            
            '''
            fit_left = np.polyfit((x1, x2), (y1, y2), 1)
            
            if x1 > imshape[1]/2 and x2 > imshape[1]/2:

            
                if fit_left[0]>0.2 and fit_left[0]<0.9 :
                    left=left+fit_left
                    leftnum=leftnum+1
                    print "left: ",fit_left[0]

            elif x1 < imshape[1]/2 and x2 < imshape[1]/2:
                if fit_left[0]> -0.9 and fit_left[0]< -0.2 :
                    right=right+fit_left
                    rightnum=rightnum+1
                #print "right: ",fit_left[0]
            '''
    left=left/leftnum
    right=right/rightnum

    x1_b=int((imshape[0]-left[1])/left[0])
    x1_t=int((ymin-left[1])/left[0])

    cv2.line(line_image,(x1_b,imshape[0]),(x1_t,ymin),(255,0,0),5)

    #x1_b=int((imshape[0]-right[1])/right[0])
    #x1_t=int((ymin-right[1])/right[0])
    #cv2.line(line_image,(x1_b,imshape[0]),(x1_t,ymin),(255,0,0),5)

    #plt.imshow(line_image)
    #plt.show()

    # Create a "color" binary image to combine with line image

    #color_edges = np.dstack((edges, edges, edges))

    # Draw the lines on the edge image
    '''
    lines_edges = cv2.addWeighted(color_edges, 0.8, line_image, 1, 0)
    plt.imshow(lines_edges)
    plt.show()
    '''
    #cv2.imshow("line",line_image)
    #cv2.waitKey(1)
    
    image_result = cv2.addWeighted(image,0.8,line_image,1,0)
    #cv2.imshow("mask1", image_result)
    #cv2.waitKey(1)

    return image_result

#white_output = 'YellowR.mp4'
#clip1 = VideoFileClip("solidYellowLeft.mp4")
#white_clip = clip1.fl_image(process_image)
#white_clip.write_videofile(white_output, audio=False)
