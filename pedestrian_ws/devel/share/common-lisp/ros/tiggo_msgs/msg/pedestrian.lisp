; Auto-generated. Do not edit!


(cl:in-package tiggo_msgs-msg)


;//! \htmlinclude pedestrian.msg.html

(cl:defclass <pedestrian> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (stop_signal
    :reader stop_signal
    :initarg :stop_signal
    :type cl:fixnum
    :initform 0)
   (front_pedestrian
    :reader front_pedestrian
    :initarg :front_pedestrian
    :type cl:fixnum
    :initform 0)
   (min_dist
    :reader min_dist
    :initarg :min_dist
    :type cl:float
    :initform 0.0))
)

(cl:defclass pedestrian (<pedestrian>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <pedestrian>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'pedestrian)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tiggo_msgs-msg:<pedestrian> is deprecated: use tiggo_msgs-msg:pedestrian instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <pedestrian>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiggo_msgs-msg:header-val is deprecated.  Use tiggo_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'stop_signal-val :lambda-list '(m))
(cl:defmethod stop_signal-val ((m <pedestrian>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiggo_msgs-msg:stop_signal-val is deprecated.  Use tiggo_msgs-msg:stop_signal instead.")
  (stop_signal m))

(cl:ensure-generic-function 'front_pedestrian-val :lambda-list '(m))
(cl:defmethod front_pedestrian-val ((m <pedestrian>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiggo_msgs-msg:front_pedestrian-val is deprecated.  Use tiggo_msgs-msg:front_pedestrian instead.")
  (front_pedestrian m))

(cl:ensure-generic-function 'min_dist-val :lambda-list '(m))
(cl:defmethod min_dist-val ((m <pedestrian>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tiggo_msgs-msg:min_dist-val is deprecated.  Use tiggo_msgs-msg:min_dist instead.")
  (min_dist m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <pedestrian>) ostream)
  "Serializes a message object of type '<pedestrian>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'stop_signal)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'front_pedestrian)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'min_dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <pedestrian>) istream)
  "Deserializes a message object of type '<pedestrian>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stop_signal) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'front_pedestrian) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'min_dist) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<pedestrian>)))
  "Returns string type for a message object of type '<pedestrian>"
  "tiggo_msgs/pedestrian")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'pedestrian)))
  "Returns string type for a message object of type 'pedestrian"
  "tiggo_msgs/pedestrian")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<pedestrian>)))
  "Returns md5sum for a message object of type '<pedestrian>"
  "f1d9d0ceae34daea720d933e25ed64ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'pedestrian)))
  "Returns md5sum for a message object of type 'pedestrian"
  "f1d9d0ceae34daea720d933e25ed64ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<pedestrian>)))
  "Returns full string definition for message of type '<pedestrian>"
  (cl:format cl:nil "std_msgs/Header header~%int8 stop_signal~%int8 front_pedestrian~%float64 min_dist~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'pedestrian)))
  "Returns full string definition for message of type 'pedestrian"
  (cl:format cl:nil "std_msgs/Header header~%int8 stop_signal~%int8 front_pedestrian~%float64 min_dist~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <pedestrian>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <pedestrian>))
  "Converts a ROS message object to a list"
  (cl:list 'pedestrian
    (cl:cons ':header (header msg))
    (cl:cons ':stop_signal (stop_signal msg))
    (cl:cons ':front_pedestrian (front_pedestrian msg))
    (cl:cons ':min_dist (min_dist msg))
))
