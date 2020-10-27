#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Configure kernel parameters at runtime ####"

####################################################################

check_root

####################################################################

mkdir -p /etc/sysctl.d
echo "vm.swappiness=10" | tee -a /etc/sysctl.d/99-sysctl.conf
sysctl vm.swappiness=10

####################################################################

finish

