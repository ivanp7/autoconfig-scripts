#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable atd service"
. "./.init.sh"

####################################################################

install_service up "$(aux_dir)/atd"
enable_service atd

