#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

check_root

####################################################################

install_and_enable_service set-kbdrate

####################################################################

finish

