#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable Alt+<key> mappings to type alternative characters"
. "./.init.sh"

####################################################################

install_keymap "$(aux_dir)/alt-keys.map"

