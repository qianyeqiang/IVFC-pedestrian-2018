# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "tiggo_msgs: 4 messages, 0 services")

set(MSG_I_FLAGS "-Itiggo_msgs:/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/indigo/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(tiggo_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg" NAME_WE)
add_custom_target(_tiggo_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tiggo_msgs" "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg" NAME_WE)
add_custom_target(_tiggo_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tiggo_msgs" "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg" ""
)

get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg" NAME_WE)
add_custom_target(_tiggo_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tiggo_msgs" "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg" NAME_WE)
add_custom_target(_tiggo_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tiggo_msgs" "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_cpp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_cpp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_cpp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(tiggo_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(tiggo_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(tiggo_msgs_generate_messages tiggo_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_cpp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_cpp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_cpp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_cpp _tiggo_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tiggo_msgs_gencpp)
add_dependencies(tiggo_msgs_gencpp tiggo_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tiggo_msgs_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_lisp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_lisp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_lisp(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(tiggo_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(tiggo_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(tiggo_msgs_generate_messages tiggo_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_lisp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_lisp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_lisp _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_lisp _tiggo_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tiggo_msgs_genlisp)
add_dependencies(tiggo_msgs_genlisp tiggo_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tiggo_msgs_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_py(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_py(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
)
_generate_msg_py(tiggo_msgs
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(tiggo_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(tiggo_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(tiggo_msgs_generate_messages tiggo_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/pedestrian.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_py _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/MapTarget.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_py _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/CrossLine.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_py _tiggo_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/tiggo_msgs/msg/RealCurb.msg" NAME_WE)
add_dependencies(tiggo_msgs_generate_messages_py _tiggo_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tiggo_msgs_genpy)
add_dependencies(tiggo_msgs_genpy tiggo_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tiggo_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tiggo_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(tiggo_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(tiggo_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(tiggo_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tiggo_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(tiggo_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(tiggo_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(tiggo_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tiggo_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(tiggo_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(tiggo_msgs_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(tiggo_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
