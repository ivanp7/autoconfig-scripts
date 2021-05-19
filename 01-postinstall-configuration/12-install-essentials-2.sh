#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing essentials from AUR ####"

####################################################################

check_user

####################################################################

print_message "#### Installing file manager ####"

install_packages lf

print_message "#### Installing archives management tools ####"

install_packages archivemount

print_message "#### Installing editor functionality extension tools ####"

install_packages nvimpager-git xxd-standalone

print_message "#### Installing framebuffer terminal ####"

install_packages fbterm

print_message "#### Installing miscellaneous stuff ####"

install_packages fortune-mod-ru
install_packages tty-clock

####################################################################

finish

