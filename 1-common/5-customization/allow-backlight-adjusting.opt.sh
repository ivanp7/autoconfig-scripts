#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Allow backlight adjusting for non-privileged users"
. "./.init.sh"

####################################################################

mkdir -p /etc/udev/rules.d
install -Dm 644 -t /etc/udev/rules.d/ "$(aux_dir)/90-backlight.rules"

