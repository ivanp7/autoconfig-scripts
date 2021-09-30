#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install surf"
. "./.init.sh"

####################################################################

git_clone_and_cd surf-ivanp7 $GIT_URL_PREFIX/surf-ivanp7.git
download_and_extract_source
build_and_install_package

