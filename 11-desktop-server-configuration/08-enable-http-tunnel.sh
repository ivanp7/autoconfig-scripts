#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling HTTP tunnel service ####"

####################################################################

check_root

####################################################################

install_and_enable_service http-tunnel log

####################################################################

finish
