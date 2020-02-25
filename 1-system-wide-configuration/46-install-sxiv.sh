#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing sxiv ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd sxiv-git https://aur.archlinux.org/sxiv-git.git

makepkg --noconfirm -o
cd src/sxiv/
install -Dm 644 $(aux_dir)/config.h ./
install -Dm 644 $(aux_dir)/sxiv-keycodes.patch ./
patch < sxiv-keycodes.patch
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

