#!/bin/sh

NAME_ROBOT=icub

FRAMEGRABBER_DEV=icubmoddev


NAME_SOURCE_IMAGE_RIGHT=/icub/cam/right
NAME_SOURCE_IMAGE_LEFT=/icub/cam/left
IMAGES_PROTOCOL=mcast

VIEWERS_PORT_LEFT=/icub/view/left
VIEWERS_PORT_RIGHT=/icub/view/right

VIEWERS_X_LEFT=0
VIEWERS_Y_LEFT=0
VIEWERS_X_RIGHT=320
VIEWERS_Y_RIGHT=0

FGGUI_NAME_LEFT=/icub/fggui/left
FGGUI_NAME_RIGHT=/icub/fggui/right

TAG_CAMERA_LEFT=icub_camera_left
TAG_CAMERA_RIGHT=icub_camera_right

TAG_VIEWER_LEFT=icub_viewer_left
TAG_VIEWER_RIGHT=icub_viewer_right

TAG_FGGUI_RIGHT=icub_fggui_right
TAG_FGGUI_LEFT=icub_fggui_left

FGGUI_X_LEFT=0
FGGUI_X_RIGHT=320
FGGUI_Y_LEFT=350
FGGUI_Y_RIGHT=350

FGGUI_HEIGHT=500
FGGUI_WIDTH=200

DRAGONFLY_WIDTH=320
DRAGONFLY_HEIGHT=240

DRAGONFLY_VIDEO_TYPE=1

DRAGONFLY_DEVICE_RIGHT=1
DRAGONFLY_DEVICE_LEFT=0

DRAGONFLY_BRIGTH_LEFT=0
DRAGONFLY_EXP_LEFT=0.4
DRAGONFLY_RED_LEFT=0.54
DRAGONFLY_BLUE_LEFT=0.51
DRAGONFLY_SHUTTER_LEFT=0.61
DRAGONFLY_GAIN_LEFT=0.9
DRAGONFLY_IRIS_LEFT=0.98

DRAGONFLY_BRIGTH_RIGHT=0
DRAGONFLY_EXP_RIGHT=0.4
DRAGONFLY_RED_RIGHT=0.53
DRAGONFLY_BLUE_RIGHT=0.53
DRAGONFLY_SHUTTER_RIGHT=0.61
DRAGONFLY_GAIN_RIGHT=0.9
DRAGONFLY_IRIS_RIGHT=0.98

DRAGONFLY_SATURATION=0.4
DRAGONFLY_GAMMA=0.4
DRAGONFLY_HUE=0.48
DRAGONFLY_SHARPNESS=0.5
DRAGONFLY_FRAMERATE_RIGHT=30
DRAGONFLY_FRAMERATE_LEFT=03

DRAGONFLY_CONFIG_RIGHT="--device grabber --subdevice dragonfly --width $DRAGONFLY_WIDTH --height $DRAGONFLY_HEIGHT --video_type $DRAGONFLY_VIDEO_TYPE --white_balance $DRAGONFLY_RED_RIGHT $DRAGONFLY_BLUE_RIGHT --gain $DRAGONFLY_GAIN_RIGHT --shutter $DRAGONFLY_SHUTTER_RIGHT --iris $DRAGONFLY_IRIS_RIGHT --exposure $DRAGONFLY_EXP_RIGHT --name $NAME_SOURCE_IMAGE_RIGHT --brightness $DRAGONFLY_BRIGHT_RIGHT --DR2 --stamp --d $DRAGONFLY_DEVICE_RIGHT --sharpness $DRAGONFLY_SHARPNESS --hue $DRAGONFLY_HUE --gamma $DRAGONFLY_GAMMA --saturation $DRAGONFLY_SATURATION --framerate $DRAGONFLY_FRAMERATE_RIGHT"

DRAGONFLY_CONFIG_LEFT="--device grabber --subdevice dragonfly --width $DRAGONFLY_WIDTH --height $DRAGONFLY_HEIGHT --video_type $DRAGONFLY_VIDEO_TYPE --white_balance $DRAGONFLY_RED_LEFT $DRAGONFLY_BLUE_LEFT --gain $DRAGONFLY_GAIN_LEFT --shutter $DRAGONFLY_SHUTTER_LEFT --iris $DRAGONFLY_IRIS_LEFT --brightness $DRAGONFLY_BRIGHT_LEFT --exposure $DRAGONFLY_EXP_LEFT --name $NAME_SOURCE_IMAGE_LEFT --DR2 --stamp --d $DRAGONFLY_DEVICE_LEFT --sharpness $DRAGONFLY_SHARPNESS --hue $DRAGONFLY_HUE --gamma $DRAGONFLY_GAMMA --saturation $DRAGONFLY_SATURATION --framerate $DRAGONFLY_FRAMERATE_LEFT"

FGGUI_CONFIG_LEFT="--local $FGGUI_NAME_LEFT --remote $NAME_SOURCE_IMAGE_LEFT --x $FGGUI_X_LEFT --y $FGGUI_Y_LEFT --width $FGGUI_WIDTH --height $FGGUI_HEIGHT"

FGGUI_CONFIG_RIGHT="--local $FGGUI_NAME_RIGHT --remote $NAME_SOURCE_IMAGE_RIGHT --x $FGGUI_X_RIGHT --y $FGGUI_Y_RIGHT --width $FGGUI_WIDTH --height $FGGUI_HEIGHT"

