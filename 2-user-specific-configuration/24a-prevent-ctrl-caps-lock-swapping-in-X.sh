#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Preventing Ctrl/CapsLock key swapping ####"

####################################################################

check_user

####################################################################

mkdir -p $XDG_CONFIG_HOME/X11
touch $XDG_CONFIG_HOME/X11/xmodmap

####################################################################

finish

