#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable middle mouse click emulation"
. "./.init.sh"

####################################################################

install -Dm 644 -t /etc/X11/xorg.conf.d/ "$(aux_dir)/10-evdev.conf"

