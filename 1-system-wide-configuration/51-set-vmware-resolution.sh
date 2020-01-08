#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting VMWare graphics driver custom resolution 1920x1080x24 60 Hz ####"

####################################################################

check_root

####################################################################

install -Dm 644 $(aux_dir)/90-resolution.conf /etc/X11/xorg.conf.d/

####################################################################

finish

