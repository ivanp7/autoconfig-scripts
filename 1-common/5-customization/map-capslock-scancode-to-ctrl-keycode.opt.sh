#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Map CapsLock scancode to Ctrl keycode"
. "./.init.sh"

####################################################################

install -m 644 "$(aux_dir)/99-map-capslock-to-ctrl.hwdb" /usr/lib/udev/hwdb.d/
udevadm --debug hwdb --update

