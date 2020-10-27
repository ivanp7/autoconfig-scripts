#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Updating pacman GPG keys ####"

####################################################################

check_root

####################################################################

pacman -Sy archlinux-keyring artix-keyring
pacman-key --init
pacman-key --populate archlinux artix
pacman --noconfirm -Scc
pacman --noconfirm -Syyu

####################################################################

finish

