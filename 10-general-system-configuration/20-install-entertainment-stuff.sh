#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing entertainment stuff ####"

####################################################################

check_user

####################################################################

print_message "#### Installing basic game collection ####"

install_packages cgames bs

print_message "#### Installing other stuff ####"

install_packages lolcat sl cmatrix ponysay nyancat

####################################################################

finish

