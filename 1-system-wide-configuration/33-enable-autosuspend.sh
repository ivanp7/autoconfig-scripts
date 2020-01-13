#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_root

####################################################################

install -Dm 755 -t /usr/local/bin/autosuspend/ $(aux_dir)/autosuspend.sh $(aux_dir)/autosuspend_op.sh
install -Dm 644 -t /etc/systemd/system/ $(aux_dir)/autosuspend.service 

systemctl enable --now autosuspend.service

####################################################################

finish

