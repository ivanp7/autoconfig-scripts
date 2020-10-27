#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Installing Firefox and addons ####"

####################################################################

check_user

####################################################################

install_official_packages firefox firefox-extension-https-everywhere 
install_official_packages firefox-ublock-origin firefox-decentraleyes

####################################################################

finish

