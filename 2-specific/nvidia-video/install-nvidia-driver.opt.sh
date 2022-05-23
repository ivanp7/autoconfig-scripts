#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install auxilliaries for NVIDIA graphics driver"
. "./.init.sh"

####################################################################

install_packages nvidia-settings libvdpau-va-gl nvtop

