#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_root

####################################################################

install -Dm 754 -o root -g root -T $(aux_dir)/autosuspend.service $SERVICES_DIRECTORY/autosuspend/run
install -Dm 755 -o root -g root -t $SERVICES_DIRECTORY/autosuspend/ \
    $(aux_dir)/activity-check.sh $(aux_dir)/suspend.sh
enable_service autosuspend

####################################################################

finish

