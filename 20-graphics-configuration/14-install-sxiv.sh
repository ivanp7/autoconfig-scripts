#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing sxiv ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd sxiv-git https://aur.archlinux.org/sxiv-git.git

makepkg --noconfirm -o
cd src/sxiv/
install -Dm 644 "$(aux_dir)/sxiv.1" ./
install -Dm 644 "$(aux_dir)/config.h" ./
install -Dm 644 "$(aux_dir)/sxiv-keycodes.patch" "$(aux_dir)/sxiv-wincolors.patch" ./
patch < sxiv-keycodes.patch
patch < sxiv-wincolors.patch
cd ../..

makepkg --noconfirm -esi

print_message "Setting sxiv as default image opener..."
xdg-mime default sxiv.desktop $(sed '/^MimeType=/!d; s/.*=//; s/;/ /g' /usr/share/applications/sxiv.desktop)

####################################################################

finish

