#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling Alt+<key> typing alternative characters ####"

####################################################################

check_root

####################################################################

install_keymap "$(aux_dir)/alt-keys.map"

####################################################################

finish

