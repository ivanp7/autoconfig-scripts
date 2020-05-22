#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

check_root

####################################################################

grep -q '^HOOKS=([^#]*keymap.*' /etc/mkinitcpio.conf || { 
    sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
    mkinitcpio -P
}

MAP_FILE=/usr/local/share/kbd/keymaps/ctrl-caps-swap.map
mkdir -p $(dirname $MAP_FILE)
{ dumpkeys | head -n 1; cat $(aux_dir)/ctrl-caps-swap.map; } > $MAP_FILE
chmod 644 $MAP_FILE

install -Dm 754 -o root -g root -T $(aux_dir)/ctrl-caps-swap.service $SERVICES_DIRECTORY/ctrl-caps-swap/run
enable_service ctrl-caps-swap

####################################################################

finish

