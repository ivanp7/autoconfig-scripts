#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configure kernel parameters at runtime ####"

####################################################################

check_root

####################################################################

mkdir -p /etc/sysctl.d/
install -Dm 644 -t /etc/sysctl.d/ "$(aux_dir)/99-sysctl.conf"

sysctl vm.swappiness=10
sysctl kernel.sysrq=1

####################################################################

finish

