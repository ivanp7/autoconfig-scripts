#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable http-server service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/http-server"
enable-service http-server

