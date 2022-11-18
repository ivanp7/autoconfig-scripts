#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable tls-tunnel service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/tls-tunnel"
enable-service tls-tunnel

