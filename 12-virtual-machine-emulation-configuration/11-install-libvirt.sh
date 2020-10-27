#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing libvirt ####"

####################################################################

check_root

####################################################################

install_official_packages libvirt
install_and_enable_service virtlogd
install_and_enable_service libvirtd log

####################################################################

finish

