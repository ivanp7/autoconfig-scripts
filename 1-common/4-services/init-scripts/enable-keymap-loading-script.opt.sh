#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install script for keymap loading at startup"
. "./.init.sh"

####################################################################

if ! install_init_script "$(aux_dir)/console-keymap.sh"
then
    print_error "startup-init service is not available"
    exit 1
fi

mkdir -p /usr/local/share/kbd/keymaps

grep -q '^HOOKS=([^#]*keymap.*' /etc/mkinitcpio.conf || {
    sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
    mkinitcpio -P
}

