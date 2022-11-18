#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install Open VM Tools"
. "./.init.sh"

####################################################################

install_packages open-vm-tools

