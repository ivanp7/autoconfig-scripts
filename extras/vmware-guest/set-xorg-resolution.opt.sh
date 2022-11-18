#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set Xorg resolution to 1920x1080x24 60 Hz"
. "./.init.sh"

####################################################################

install -Dm 644 -t /etc/X11/xorg.conf.d/ "$(aux_dir)/90-resolution.conf"

