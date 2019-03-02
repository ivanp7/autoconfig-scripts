#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting VMWare graphics driver custom resolution 1920x1080x24 60 Hz ####"

####################################################################

initialize

####################################################################

print_message "Setting graphics resolution..."
sudo install -Dm 644 $SCRIPT_DIR/aux/5.1/90-resolution.conf /etc/X11/xorg.conf.d/

####################################################################

finish

