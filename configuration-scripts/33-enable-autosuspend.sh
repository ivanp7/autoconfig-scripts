#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_user

####################################################################

sudo install -Dm 755 $(aux_dir)/autosuspend.sh /usr/local/bin/autosuspend/
sudo install -Dm 755 $(aux_dir)/autosuspend_op.sh /usr/local/bin/
sudo install -Dm 644 $(aux_dir)/autosuspend.service /etc/systemd/system/

sudo systemctl enable --now autosuspend.service

####################################################################

finish

