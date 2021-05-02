#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling keymap loading ####"

####################################################################

check_root

####################################################################

grep -q '^HOOKS=([^#]*keymap.*' /etc/mkinitcpio.conf || {
    sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
    mkinitcpio -P
}
mkdir -p /usr/local/share/kbd/keymaps
install_init_script "$(aux_dir)/console-keymap.sh"

####################################################################

finish

