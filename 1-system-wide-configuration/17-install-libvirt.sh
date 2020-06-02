#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing libvirt ####"

####################################################################

check_root

####################################################################

install_official_packages libvirt dnsmasq firewalld
install_and_enable_service firewalld
install_and_enable_service virtlogd
install_and_enable_service libvirtd log

####################################################################

finish

