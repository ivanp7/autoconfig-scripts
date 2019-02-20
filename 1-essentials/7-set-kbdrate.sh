#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

initialize

####################################################################

sudo cp $SCRIPT_DIR/aux/7/set-kbdrate.service /etc/systemd/system/
sudo systemctl enable set-kbdrate.service
sudo systemctl start set-kbdrate.service

####################################################################

finish

