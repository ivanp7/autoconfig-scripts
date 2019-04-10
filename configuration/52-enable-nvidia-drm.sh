#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Nvidia Direct Rendering Manager ####"

####################################################################

check_user

####################################################################

MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
sudo sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
sudo mkinitcpio -P

sudo sed -i "@^GRUB_CMDLINE_LINUX_DEFAULT=@ s@\"@\"nvidia-drm.modeset=1 @" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo install -Dm 644 $(aux_dir)/nvidia.hook /etc/pacman.d/hooks/

####################################################################

finish

