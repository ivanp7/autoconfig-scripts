#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install dotfiles installer"
. "./.init.sh"

####################################################################

git_clone_and_cd dotfiles $GIT_URL_PREFIX/dotfiles.git
./install.sh

