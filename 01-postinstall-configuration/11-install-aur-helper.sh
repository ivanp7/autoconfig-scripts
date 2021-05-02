#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing AUR helper ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd yay  https://aur.archlinux.org/yay.git

makepkg --noconfirm -si

####################################################################

finish

