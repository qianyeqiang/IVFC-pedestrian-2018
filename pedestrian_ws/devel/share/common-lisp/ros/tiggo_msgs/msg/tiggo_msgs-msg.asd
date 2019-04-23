
(cl:in-package :asdf)

(defsystem "tiggo_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "MapTarget" :depends-on ("_package_MapTarget"))
    (:file "_package_MapTarget" :depends-on ("_package"))
    (:file "pedestrian" :depends-on ("_package_pedestrian"))
    (:file "_package_pedestrian" :depends-on ("_package"))
    (:file "RealCurb" :depends-on ("_package_RealCurb"))
    (:file "_package_RealCurb" :depends-on ("_package"))
    (:file "CrossLine" :depends-on ("_package_CrossLine"))
    (:file "_package_CrossLine" :depends-on ("_package"))
  ))