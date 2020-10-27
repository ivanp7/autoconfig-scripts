#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing slock ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd slock-git https://aur.archlinux.org/slock-git.git

makepkg --noconfirm -o
cd src/slock/

install -Dm 644 "$(aux_dir)/extra-keycodes.patch" ./
patch < extra-keycodes.patch
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

