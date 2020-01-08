#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Unmuting sound  ####"

####################################################################

check_user

####################################################################

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

####################################################################

finish

