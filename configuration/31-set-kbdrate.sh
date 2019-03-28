#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

initialize

####################################################################

sudo install -Dm 644 $(aux_dir)/set-kbdrate.service /etc/systemd/system/
sudo systemctl enable set-kbdrate.service
sudo systemctl start set-kbdrate.service

####################################################################

finish

