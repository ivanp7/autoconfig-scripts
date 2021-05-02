#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring startup-init service ####"

####################################################################

check_root

####################################################################

mkdir -p /usr/local/bin/startup-init

install_and_enable_service startup-init

####################################################################

finish

