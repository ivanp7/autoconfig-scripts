#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install AUR helper"
. "./.init.sh"

####################################################################

git_clone_and_cd yay https://aur.archlinux.org/yay.git
download_and_extract_source
build_and_install_package

