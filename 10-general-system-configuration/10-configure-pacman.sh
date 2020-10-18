#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring pacman ####"

####################################################################

check_root

####################################################################

sed -i "s/^#Color/Color/" /etc/pacman.conf

print_message "Updating GPG keys..."

pacman -Sy archlinux-keyring artix-keyring
pacman-key --init
pacman-key --populate archlinux artix
pacman --noconfirm -Scc
pacman --noconfirm -Syyu

####################################################################

finish

