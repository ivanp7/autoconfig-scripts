#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Ctrl/CapsLock keys swapping ####"

####################################################################

check_root

####################################################################

install_keymap $(aux_dir)/ctrl-caps-swap.map

####################################################################

finish

