// Generated by gencpp from file pedestrian/pedestrian.msg
// DO NOT EDIT!


#ifndef PEDESTRIAN_MESSAGE_PEDESTRIAN_H
#define PEDESTRIAN_MESSAGE_PEDESTRIAN_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace pedestrian
{
template <class ContainerAllocator>
struct pedestrian_
{
  typedef pedestrian_<ContainerAllocator> Type;

  pedestrian_()
    : header()
    , stop_signal(0)
    , min_dist(0.0)  {
    }
  pedestrian_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , stop_signal(0)
    , min_dist(0.0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef int8_t _stop_signal_type;
  _stop_signal_type stop_signal;

   typedef double _min_dist_type;
  _min_dist_type min_dist;




  typedef boost::shared_ptr< ::pedestrian::pedestrian_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::pedestrian::pedestrian_<ContainerAllocator> const> ConstPtr;

}; // struct pedestrian_

typedef ::pedestrian::pedestrian_<std::allocator<void> > pedestrian;

typedef boost::shared_ptr< ::pedestrian::pedestrian > pedestrianPtr;
typedef boost::shared_ptr< ::pedestrian::pedestrian const> pedestrianConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::pedestrian::pedestrian_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::pedestrian::pedestrian_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace pedestrian

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'pedestrian': ['/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg'], 'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::pedestrian::pedestrian_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::pedestrian::pedestrian_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedestrian::pedestrian_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::pedestrian::pedestrian_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedestrian::pedestrian_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::pedestrian::pedestrian_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::pedestrian::pedestrian_<ContainerAllocator> >
{
  static const char* value()
  {
    return "99ebc65ada5fa753b6a8360661335b91";
  }

  static const char* value(const ::pedestrian::pedestrian_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x99ebc65ada5fa753ULL;
  static const uint64_t static_value2 = 0xb6a8360661335b91ULL;
};

template<class ContainerAllocator>
struct DataType< ::pedestrian::pedestrian_<ContainerAllocator> >
{
  static const char* value()
  {
    return "pedestrian/pedestrian";
  }

  static const char* value(const ::pedestrian::pedestrian_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::pedestrian::pedestrian_<ContainerAllocator> >
{
  static const char* value()
  {
    return "std_msgs/Header header\n\
int8 stop_signal\n\
float64 min_dist\n\
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

  static const char* value(const ::pedestrian::pedestrian_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::pedestrian::pedestrian_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.stop_signal);
      stream.next(m.min_dist);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct pedestrian_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::pedestrian::pedestrian_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::pedestrian::pedestrian_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "stop_signal: ";
    Printer<int8_t>::stream(s, indent + "  ", v.stop_signal);
    s << indent << "min_dist: ";
    Printer<double>::stream(s, indent + "  ", v.min_dist);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PEDESTRIAN_MESSAGE_PEDESTRIAN_H
