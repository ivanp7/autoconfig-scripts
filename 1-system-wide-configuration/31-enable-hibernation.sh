#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling hibernation ####"

####################################################################

check_root

####################################################################

sed -i "/^HOOKS=/ s/fsck/resume fsck/" /etc/mkinitcpio.conf
mkinitcpio -P

SWAP_DEVICE="$(df / | sed '2q;d' | awk '{print $1}')"
SWAP_OFFSET="$(filefrag -v /swapfile | sed '4q;d' | awk '{print $4}' | cut -d'.' -f1)"
SWAP_PARAMETERS="resume=${SWAP_DEVICE} resume_offset=${SWAP_OFFSET}"
sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"${SWAP_PARAMETERS} @" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

