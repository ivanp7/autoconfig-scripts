#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Allow backlight adjusting for non-privileged users ####"

####################################################################

check_root

####################################################################

mkdir -p /etc/udev/rules.d
install -Dm 644 $(aux_dir)/90-backlight.rules /etc/udev/rules.d

####################################################################

finish

