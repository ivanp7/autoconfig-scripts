#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Enabling hibernation ####"

####################################################################

initialize

####################################################################

sudo sed -i "s/fsck/resume fsck/" /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

SWAP_DEVICE=$(df / | awk '{print $1}')
SWAP_OFFSET=$(sudo filefrag -v /swapfile | sed '4q;d' | awk '{print $4}' | cut -d'.' -f1)
sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume=$SWAP_DEVICE resume_offset=$SWAP_OFFSET /" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

