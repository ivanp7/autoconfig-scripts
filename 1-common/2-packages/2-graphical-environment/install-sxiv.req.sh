#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install sxiv"
. "./.init.sh"

####################################################################

git_clone_and_cd sxiv-git https://aur.archlinux.org/sxiv-git.git
download_and_extract_source

cd src/sxiv/
install -m 644 "$(aux_dir)/sxiv.1" ./
install -m 644 "$(aux_dir)/config.h" ./
install -m 644 "$(aux_dir)/sxiv-keycodes.patch" "$(aux_dir)/sxiv-xresources.patch" ./
patch < sxiv-keycodes.patch
patch < sxiv-xresources.patch
cd ../..

build_and_install_package

