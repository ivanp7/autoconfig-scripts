#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Performing basic system configuration ####"

####################################################################

check_root

####################################################################

print_message "Preparing services..."

mkdir -p /usr/local/bin/startup-init

grep -q '^HOOKS=([^#]*keymap.*' /etc/mkinitcpio.conf || {
    sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
    mkinitcpio -P
}
mkdir -p /usr/local/share/kbd/keymaps
install_init_script $(aux_dir)/console-keymap.sh

####################################################################

print_message "Enabling services..."

enable_service tlp
install_and_enable_service startup-init
install_and_enable_service cronie
install_and_enable_service atd
install_and_enable_service ntp

####################################################################

print_message "Adding cronjobs..."

add_cronjob '@daily /usr/bin/pkgfile --update'
add_cronjob '@daily /usr/bin/mandb'

####################################################################

print_message "Initializing databases..."

pkgfile --update
mandb

####################################################################

print_message "Making dash the default script interpreter..."

ln -sfT dash /usr/bin/sh
mkdir -p /etc/pacman.d/hooks/
install -Dm 644 "$(aux_dir)/dash.hook" /etc/pacman.d/hooks/

print_message "Changing shell to zsh for root..."

chsh -s /usr/bin/zsh

print_message "Adding pacman hook for zsh..."

mkdir -p /var/cache/zsh/
install -Dm 644 "$(aux_dir)/zsh.hook" /etc/pacman.d/hooks/

####################################################################

print_message "Installing configuration files..."

install -Dm 644 "$(aux_dir)/sbclrc" /etc/

####################################################################

finish

