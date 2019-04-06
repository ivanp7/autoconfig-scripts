#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling hibernation ####"

####################################################################

check_user

####################################################################

sudo sed -i "/^HOOKS=(/ s/fsck/resume fsck/" /etc/mkinitcpio.conf
sudo sed -i "/^HOOKS=(/ s/resume resume/resume/" /etc/mkinitcpio.conf
sudo mkinitcpio -p $(initcpio_preset)

SWAP_DEVICE=$(df / | sed '2q;d' | awk '{print $1}')
SWAP_OFFSET=$(sudo filefrag -v /swapfile | sed '4q;d' | awk '{print $4}' | cut -d'.' -f1)
sudo sed -i "s@^GRUB_CMDLINE_LINUX_DEFAULT=\"@GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$SWAP_DEVICE resume_offset=$SWAP_OFFSET @" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

