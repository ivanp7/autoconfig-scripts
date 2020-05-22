#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

check_root

####################################################################

install -Dm 754 -o root -g root -T $(aux_dir)/set-kbdrate.service $SERVICES_DIRECTORY/set-kbdrate/run
enable_service set-kbdrate

####################################################################

finish

