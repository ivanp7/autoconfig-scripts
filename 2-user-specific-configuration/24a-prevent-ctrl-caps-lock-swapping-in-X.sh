#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Preventing Ctrl/CapsLock key swapping in X ####"

####################################################################

check_user

####################################################################

mkdir -p $HOME/.config/X11
touch $HOME/.config/X11/xmodmap

####################################################################

finish

