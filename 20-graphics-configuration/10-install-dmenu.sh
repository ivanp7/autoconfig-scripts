#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Installing dmenu ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd dmenu-ivanp7 $GIT_URL_PREFIX/dmenu-ivanp7.git

makepkg --noconfirm -si

####################################################################

finish

