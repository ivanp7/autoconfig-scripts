#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure zsh"
. "./.init.sh"

####################################################################

mkdir -p /var/cache/zsh/
install_pacman_hook zsh

