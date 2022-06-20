#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable vmware-vmblock-fuse service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/vmware-vmblock-fuse"
enable_service vmware-vmblock-fuse

