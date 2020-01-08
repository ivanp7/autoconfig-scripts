#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

check_root

####################################################################

sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
mkinitcpio -P

mkdir -p /usr/local/share/kbd/keymaps
dumpkeys | head -1 | tee /usr/local/share/kbd/keymaps/ctrl-caps-swap.map
cat $(aux_dir)/ctrl-caps-swap.map | tee -a /usr/local/share/kbd/keymaps/ctrl-caps-swap.map
chmod 644 /usr/local/share/kbd/keymaps/ctrl-caps-swap.map

install -Dm 644 $(aux_dir)/ctrl-caps-swap.service /etc/systemd/system/
systemctl enable --now ctrl-caps-swap.service

install -Dm 755 $(aux_dir)/90-reset-ctrl-caps-swap.sh /usr/lib/systemd/system-sleep/

####################################################################

finish

