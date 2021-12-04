#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install tabbed"
. "./.init.sh"

####################################################################

git_clone_and_cd tabbed-ivanp7 $GIT_URL_PREFIX/tabbed-ivanp7.git
download_and_extract_source

HARDCODED_FONT="xos4 Terminus:size=12"
[ "$DEFAULT_FONT" ] && sed -i "s/$HARDCODED_FONT/$DEFAULT_FONT/" config.h

build_and_install_package

