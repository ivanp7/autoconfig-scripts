#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing patched Terminus font ####"

####################################################################

check_user

####################################################################

uninstall_packages terminus-font
install_packages terminus-font-ll2-td1-dv1-ij1

####################################################################

finish

