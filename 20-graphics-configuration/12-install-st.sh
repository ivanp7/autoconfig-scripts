#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing st ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd st-luke-git https://aur.archlinux.org/st-luke-git.git

makepkg --noconfirm -o
cd src/st-luke/
install -m 644 "$(aux_dir)/config.h" "$(aux_dir)/st.1" ./

[ -z "$DEFAULT_FONT" ] && DEFAULT_FONT="xos4 Terminus:size=12"

FONT=${DEFAULT_FONT%%:*}
FONT_SIZE=$(echo ${DEFAULT_FONT#*:} | sed -E 's/.*:?size=([0-9]*):?.*/\1/')
sed -i "s/FONT_NAME/$FONT/; s/FONT_SIZE/$FONT_SIZE/" config.h
sed -i -E 's/^(\s*)it#8,/\1it#4,/' st.info

install -m 644 "$(aux_dir)/st-keycodes.patch" ./
patch < st-keycodes.patch
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

