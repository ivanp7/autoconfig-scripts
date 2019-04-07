#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

check_user

####################################################################

sudo sed -i "/^HOOKS=(/ s/keyboard/keyboard keymap/" /etc/mkinitcpio.conf
sudo sed -i "/^HOOKS=(/ s/keymap keymap/keymap/" /etc/mkinitcpio.conf
sudo mkinitcpio -p $(initcpio_preset)

sudo mkdir -p /usr/local/share/kbd/keymaps
sudo dumpkeys | head -1 | sudo tee /usr/local/share/kbd/keymaps/ctrl-caps-swap.map
cat $(aux_dir)/ctrl-caps-swap.map | sudo tee -a /usr/local/share/kbd/keymaps/ctrl-caps-swap.map
sudo chmod 644 /usr/local/share/kbd/keymaps/ctrl-caps-swap.map

sudo install -Dm 644 $(aux_dir)/ctrl-caps-swap.service /etc/systemd/system/
sudo systemctl enable ctrl-caps-swap.service
sudo systemctl start ctrl-caps-swap.service

install -Dm 644 $(aux_dir)/.Xmodmap ./
ln -sf $(realpath .Xmodmap) $HOME/

sudo install -Dm 755 $(aux_dir)/90-reset-ctrl-caps-swap.sh /usr/lib/systemd/system-sleep/

####################################################################

finish

