#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

check_root

####################################################################

install -Dm 644 $(aux_dir)/set-kbdrate.service /etc/systemd/system/
systemctl enable --now set-kbdrate.service

####################################################################

finish

