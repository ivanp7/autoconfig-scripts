#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Making extra keys repeat useful keys ####"

####################################################################

check_root

####################################################################

install_keymap "$(aux_dir)/enhanced-keyboard.map"

####################################################################

finish

