#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling middle mouse click emulation ####"

####################################################################

check_root

####################################################################

mkdir -p /etc/X11/xorg.conf.d
install -Dm 644 "$(aux_dir)/10-evdev.conf" /etc/X11/xorg.conf.d/

####################################################################

finish

