#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing entertainment stuff ####"

####################################################################

check_user

####################################################################

print_message "#### Installing basic game collection ####"

install_official_packages gnome-mahjongg
install_packages powdertoy-bin

####################################################################

finish

