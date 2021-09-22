#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable vmtoolsd service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/vmtoolsd"
enable-service vmtoolsd

