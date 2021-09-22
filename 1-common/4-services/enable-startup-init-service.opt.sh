#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable startup-init service"
. "./.init.sh"

####################################################################

mkdir -p /usr/local/bin/startup-init
install_service up,log "$(aux_dir)/startup-init"
enable_service startup-init

