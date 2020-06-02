#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Adding user to the libvirt group ####"

####################################################################

check_user

####################################################################

sudo gpasswd -a $(whoami) libvirt

####################################################################

finish

