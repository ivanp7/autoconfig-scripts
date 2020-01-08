#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Nvidia Direct Rendering Manager ####"

####################################################################

check_root

####################################################################

MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
mkinitcpio -P

sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"nvidia-drm.modeset=1 @" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

if pacman -Qs linux-lts > /dev/null && ! pacman -Qs linux > /dev/null
then HOOK=nvidia-lts
else HOOK=nvidia
fi

install -Dm 644 $(aux_dir)/${HOOK}.hook /etc/pacman.d/hooks/

####################################################################

finish

