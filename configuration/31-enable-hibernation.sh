#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling hibernation ####"

####################################################################

check_user

####################################################################

sudo sed -i "/^HOOKS=/ s/fsck/resume fsck/" /etc/mkinitcpio.conf
sudo mkinitcpio -P

SWAP_DEVICE="$(df / | sed '2q;d' | awk '{print $1}')"
SWAP_OFFSET="$(sudo filefrag -v /swapfile | sed '4q;d' | awk '{print $4}' | cut -d'.' -f1)"
SWAP_PARAMETERS="resume=${SWAP_DEVICE} resume_offset=${SWAP_OFFSET}"
sudo sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"${SWAP_PARAMETERS} @" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

