#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Install patched Terminus font ####"

####################################################################

check_user

####################################################################

uninstall_packages terminus-font
install_packages terminus-font-ll2-td1-dv1-ij1

####################################################################

finish

