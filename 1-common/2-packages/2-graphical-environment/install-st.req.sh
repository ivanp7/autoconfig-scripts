#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install st"
. "./.init.sh"

####################################################################

git_clone_and_cd st-luke-git https://aur.archlinux.org/st-luke-git.git
download_and_extract_source

cd src/st-luke/
install -m 644 -t . "$(aux_dir)/config.h" "$(aux_dir)/st.1"

[ -z "$DEFAULT_FONT" ] && DEFAULT_FONT="xos4 Terminus:size=12"

FONT=${DEFAULT_FONT%%:*}
FONT_SIZE=$(echo ${DEFAULT_FONT#*:} | sed -E 's/.*:?size=([0-9]*):?.*/\1/')
sed -i "s/FONT_NAME/$FONT/; s/FONT_SIZE/$FONT_SIZE/" config.h
sed -i -E 's/^(\s*)it#8,/\1it#4,/' st.info

install -m 644 "$(aux_dir)/st-keycodes.patch" ./
patch < st-keycodes.patch
cd ../..

build_and_install_package

