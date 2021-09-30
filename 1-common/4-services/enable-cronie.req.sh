#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable cronie service"
. "./.init.sh"

####################################################################

install_service up "$(aux_dir)/cronie"
enable_service cronie

