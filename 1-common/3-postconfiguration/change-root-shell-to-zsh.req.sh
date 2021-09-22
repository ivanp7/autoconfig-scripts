#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Change root shell to zsh"
. "./.init.sh"

####################################################################

chsh -s /usr/bin/zsh

