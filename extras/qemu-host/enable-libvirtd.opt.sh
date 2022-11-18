#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable libvirtd service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/libvirtd"
enable-service libvirtd

