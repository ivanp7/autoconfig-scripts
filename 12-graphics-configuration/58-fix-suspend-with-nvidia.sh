#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Fix computer suspend with Nvidia driver ####"

####################################################################

check_root

####################################################################

install -Dm 755 $(aux_dir)/nvidia /usr/lib/elogind/system-sleep/

####################################################################

finish

