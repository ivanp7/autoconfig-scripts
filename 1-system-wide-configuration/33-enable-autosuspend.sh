#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_root

####################################################################

install -Dm 755 $(aux_dir)/autosuspend.sh /usr/local/bin/autosuspend/
install -Dm 755 $(aux_dir)/autosuspend_op.sh /usr/local/bin/
install -Dm 644 $(aux_dir)/autosuspend.service /etc/systemd/system/

systemctl enable --now autosuspend.service

####################################################################

finish

