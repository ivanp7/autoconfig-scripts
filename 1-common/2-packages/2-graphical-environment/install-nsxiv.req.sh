#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install sxiv"
. "./.init.sh"

####################################################################

git_clone_and_cd nsxiv https://aur.archlinux.org/nsxiv.git
download_and_extract_source

cd src/nsxiv-$(grep "pkgver=" PKGBUILD | cut -d'=' -f2)/
install -m 644 "$(aux_dir)/nsxiv.1" ./
install -m 644 "$(aux_dir)/config.h" ./
install -m 644 "$(aux_dir)/nsxiv-keycodes.patch" ./
patch < nsxiv-keycodes.patch
cd ../..

build_and_install_package
