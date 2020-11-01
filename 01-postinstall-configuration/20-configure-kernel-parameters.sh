#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configure kernel parameters at runtime ####"

####################################################################

check_root

####################################################################

install -Dm 644 "$(aux_dir)/99-sysctl.conf" /etc/sysctl.d/
sysctl vm.swappiness=10

####################################################################

finish

