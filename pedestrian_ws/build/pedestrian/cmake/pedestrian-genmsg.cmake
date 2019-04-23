# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "pedestrian: 1 messages, 0 services")

set(MSG_I_FLAGS "-Ipedestrian:/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(pedestrian_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg" NAME_WE)
add_custom_target(_pedestrian_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "pedestrian" "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(pedestrian
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/pedestrian
)

### Generating Services

### Generating Module File
_generate_module_cpp(pedestrian
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/pedestrian
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(pedestrian_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(pedestrian_generate_messages pedestrian_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg" NAME_WE)
add_dependencies(pedestrian_generate_messages_cpp _pedestrian_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(pedestrian_gencpp)
add_dependencies(pedestrian_gencpp pedestrian_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS pedestrian_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(pedestrian
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/pedestrian
)

### Generating Services

### Generating Module File
_generate_module_lisp(pedestrian
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/pedestrian
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(pedestrian_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(pedestrian_generate_messages pedestrian_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg" NAME_WE)
add_dependencies(pedestrian_generate_messages_lisp _pedestrian_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(pedestrian_genlisp)
add_dependencies(pedestrian_genlisp pedestrian_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS pedestrian_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(pedestrian
  "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/pedestrian
)

### Generating Services

### Generating Module File
_generate_module_py(pedestrian
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/pedestrian
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(pedestrian_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(pedestrian_generate_messages pedestrian_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/cyberc3/SSD-Tensorflow-master/pedestrian_ws/src/pedestrian/msg/pedestrian.msg" NAME_WE)
add_dependencies(pedestrian_generate_messages_py _pedestrian_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(pedestrian_genpy)
add_dependencies(pedestrian_genpy pedestrian_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS pedestrian_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/pedestrian)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/pedestrian
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(pedestrian_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/pedestrian)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/pedestrian
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(pedestrian_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/pedestrian)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/pedestrian\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/pedestrian
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(pedestrian_generate_messages_py std_msgs_generate_messages_py)
endif()
