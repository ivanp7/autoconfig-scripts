#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling Ctrl/CapsLock keys swapping ####"

####################################################################

check_root

####################################################################

install -m 644 "$(aux_dir)/99-map-capslock-to-ctrl.hwdb" /usr/lib/udev/hwdb.d/
udevadm --debug hwdb --update

####################################################################

finish

