#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Fix suspend when Nvidia driver is installed"
. "./.init.sh"

####################################################################

install -Dm 644 -t /usr/lib/elogind/system-sleep/ "$(aux_dir)/nvidia_copy"
install -Dm 755 -T "$(aux_dir)/nvidia_copy" /usr/lib/elogind/system-sleep/nvidia

install_pacman_hook nvidia-utils

