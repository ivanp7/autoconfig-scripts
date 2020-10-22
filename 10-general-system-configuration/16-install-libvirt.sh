#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing libvirt ####"

####################################################################

check_root

####################################################################

print_message "Installing libvirt and services..."
install_official_packages libvirt
install_and_enable_service virtlogd
install_and_enable_service libvirtd log

####################################################################

finish

