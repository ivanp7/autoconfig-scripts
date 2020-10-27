#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

check_root

####################################################################

install -m 755 $(aux_dir)/set-kbdrate.sh /usr/local/bin/startup-init/

####################################################################

finish

