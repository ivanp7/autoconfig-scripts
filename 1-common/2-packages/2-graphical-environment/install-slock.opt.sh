#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install slock"
. "./.init.sh"

####################################################################

git_clone_and_cd slock-ivanp7 $GIT_URL_PREFIX/slock-ivanp7.git
build_and_install_package

