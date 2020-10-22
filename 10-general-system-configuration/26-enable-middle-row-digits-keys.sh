#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Alt+<middle row key> typing digits ####"

####################################################################

check_root

####################################################################

install_keymap $(aux_dir)/alt-digits.map

####################################################################

finish

