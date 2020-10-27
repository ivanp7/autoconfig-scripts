#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Setting Xorg custom resolution 1920x1080x24 60 Hz ####"

####################################################################

check_root

####################################################################

mkdir -p /etc/X11/xorg.conf.d
install -Dm 644 "$(aux_dir)/90-resolution.conf" /etc/X11/xorg.conf.d/

####################################################################

finish

