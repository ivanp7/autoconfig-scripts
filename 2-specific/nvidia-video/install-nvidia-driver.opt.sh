#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install NVIDIA graphics driver"
. "./.init.sh"

####################################################################

install_packages linux-lts-headers nvidia-lts \
    nvidia-settings libvdpau-va-gl nvtop

install_pacman_hook nvidia-lts

