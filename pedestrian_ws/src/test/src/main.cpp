#include "ros/ros.h"
#include "tiggo_msgs/CrossLine.h"

int main(int argc, char **argv)
{

  ros::init(argc, argv, "custom_msgs_talker");

  ros::NodeHandle nh;

//-----------define custom messages Publisher--------------
  ros::Publisher pub_can_data = nh.advertise<tiggo_msgs::CrossLine>("CrossLine", 10);

  ros::Rate loop_rate(10);

  int count = 0;
  while (ros::ok())
  {
//----------initialize custom messages and publish---------
    tiggo_msgs::CrossLine output;

    output.header.seq = count;
    output.header.stamp = ros::Time::now();
    output.header.frame_id = "lps";
    output.valid = -2;
    output.distance = -10; 

    pub_can_data.publish(output);


    ros::spinOnce();
    loop_rate.sleep();
    count++;
  }

  return 0;
}
