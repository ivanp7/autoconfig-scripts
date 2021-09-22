#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install patched Terminus font"
. "./.init.sh"

####################################################################

mktemp_dir_and_cd terminus-font-patched

uninstall_packages $(find_package terminus-font) # to avoid conflict in pacman

install -m 644 -t . "$(aux_dir)/PKGBUILD"
install -m 644 -t . "$(aux_dir)/fix-75-yes-terminus.patch"

build_and_install_package

