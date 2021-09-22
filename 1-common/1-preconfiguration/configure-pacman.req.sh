#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure pacman"
. "./.init.sh"

####################################################################

pacman --needed --noconfirm -S archlinux-mirrorlist artix-archlinux-support
grep -q "^# ARCHLINUX" /etc/pacman.conf || cat "$(aux_dir)/arch_repos" | tee -a /etc/pacman.conf

sed -i "s/^#Color/Color/" /etc/pacman.conf

