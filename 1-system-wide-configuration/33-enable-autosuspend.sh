#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_root

####################################################################

install -Dm 755 -o root -g root -t /usr/local/bin/autosuspend/ \
    $(aux_dir)/activity-check.sh $(aux_dir)/suspend.sh
install_and_enable_service autosuspend

####################################################################

finish

