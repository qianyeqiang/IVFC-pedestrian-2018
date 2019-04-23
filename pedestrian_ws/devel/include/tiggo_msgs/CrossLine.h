// Generated by gencpp from file tiggo_msgs/CrossLine.msg
// DO NOT EDIT!


#ifndef TIGGO_MSGS_MESSAGE_CROSSLINE_H
#define TIGGO_MSGS_MESSAGE_CROSSLINE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace tiggo_msgs
{
template <class ContainerAllocator>
struct CrossLine_
{
  typedef CrossLine_<ContainerAllocator> Type;

  CrossLine_()
    : header()
    , valid(0)
    , angle(0.0)
    , distance(0.0)  {
    }
  CrossLine_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , valid(0)
    , angle(0.0)
    , distance(0.0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int8_t _valid_type;
  _valid_type valid;

   typedef double _angle_type;
  _angle_type angle;

   typedef double _distance_type;
  _distance_type distance;




  typedef boost::shared_ptr< ::tiggo_msgs::CrossLine_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::tiggo_msgs::CrossLine_<ContainerAllocator> const> ConstPtr;

}; // struct CrossLine_

typedef ::tiggo_msgs::CrossLine_<std::allocator<void> > CrossLine;

typedef boost::shared_ptr< ::tiggo_msgs::CrossLine > CrossLinePtr;
typedef boost::shared_ptr< ::tiggo_msgs::CrossLine const> CrossLineConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::tiggo_msgs::CrossLine_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::tiggo_msgs::CrossLine_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace tiggo_msgs

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'sensor_msgs': ['/opt/ros/indigo/share/sensor_msgs/cmake/../msg'], 'geometry_msgs': ['/opt/ros/indigo/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg'], 'tiggo_msgs': ['/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::tiggo_msgs::CrossLine_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::tiggo_msgs::CrossLine_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::tiggo_msgs::CrossLine_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
{
  static const char* value()
  {
    return "fa06da410fbd87ab70af7ced639b8b89";
  }

  static const char* value(const ::tiggo_msgs::CrossLine_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xfa06da410fbd87abULL;
  static const uint64_t static_value2 = 0x70af7ced639b8b89ULL;
};

template<class ContainerAllocator>
struct DataType< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
{
  static const char* value()
  {
    return "tiggo_msgs/CrossLine";
  }

  static const char* value(const ::tiggo_msgs::CrossLine_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
{
  static const char* value()
  {
    return "std_msgs/Header header\n\
int8 valid\n\
float64 angle\n\
float64 distance\n\
\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::tiggo_msgs::CrossLine_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.valid);
      stream.next(m.angle);
      stream.next(m.distance);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct CrossLine_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::tiggo_msgs::CrossLine_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::tiggo_msgs::CrossLine_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "valid: ";
    Printer<int8_t>::stream(s, indent + "  ", v.valid);
    s << indent << "angle: ";
    Printer<double>::stream(s, indent + "  ", v.angle);
    s << indent << "distance: ";
    Printer<double>::stream(s, indent + "  ", v.distance);
  }
};

} // namespace message_operations
} // namespace ros

#endif // TIGGO_MSGS_MESSAGE_CROSSLINE_H
