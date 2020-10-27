#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing libvirt networking utilities ####"

####################################################################

check_root

####################################################################

install_official_packages ebtables dnsmasq

####################################################################

finish

