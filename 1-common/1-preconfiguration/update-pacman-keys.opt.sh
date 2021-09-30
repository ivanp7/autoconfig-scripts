#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Update pacman's GPG keys"
. "./.init.sh"

####################################################################

pacman --noconfirm -Sy archlinux-keyring artix-keyring
pacman-key --init
pacman-key --populate archlinux artix
pacman --noconfirm -Scc
pacman --noconfirm -Syyu

