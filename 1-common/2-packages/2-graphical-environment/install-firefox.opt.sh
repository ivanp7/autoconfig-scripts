#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install Firefox and addons"
. "./.init.sh"

####################################################################

install_packages firefox
install_packages firefox-extension-https-everywhere firefox-ublock-origin firefox-decentraleyes

