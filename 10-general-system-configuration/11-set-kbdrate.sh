#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Setting console keyboard repeat rate/delay ####"

####################################################################

check_root

####################################################################

install_init_script "$(aux_dir)/set-kbdrate.sh"

####################################################################

finish

