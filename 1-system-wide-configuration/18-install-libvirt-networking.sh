#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing libvirt networking utilities ####"

####################################################################

check_root

####################################################################

print_message "Installing libvirt networking utilities..."
install_official_packages ebtables dnsmasq

####################################################################

finish

