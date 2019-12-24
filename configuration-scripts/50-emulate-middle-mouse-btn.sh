#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling middle mouse click emulation ####"

####################################################################

check_user

####################################################################

sudo install -Dm 644 $(aux_dir)/10-evdev.conf /etc/X11/xorg.conf.d/

####################################################################

finish

