#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Preventing Ctrl/CapsLock key swapping in X ####"

####################################################################

check_user

####################################################################

mkdir -p $HOME/.config/X11
touch $HOME/.config/X11/xmodmap

####################################################################

finish

