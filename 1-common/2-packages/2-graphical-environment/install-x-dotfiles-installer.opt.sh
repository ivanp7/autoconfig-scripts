#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install x-dotfiles installer"
. "./.init.sh"

####################################################################

git_clone_and_cd x-dotfiles $GIT_URL_PREFIX/x-dotfiles.git
./install.sh

