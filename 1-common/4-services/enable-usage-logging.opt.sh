#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable computer usage time logging service"
. "./.init.sh"

####################################################################

install_service up,log "$(aux_dir)/usage-logging"
enable_service usage-logging

