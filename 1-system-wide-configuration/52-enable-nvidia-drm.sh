#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Nvidia Direct Rendering Manager ####"

####################################################################

check_root

####################################################################

if pacman -Qi linux-lts > /dev/null 2>&1 
then
    install_official_packages linux-lts-headers
    HOOK=nvidia-lts 
else 
    install_official_packages linux-headers
    HOOK=nvidia
fi
install -Dm 644 $(aux_dir)/${HOOK}.hook /etc/pacman.d/hooks/
install_official_packages nvidia-dkms

grep -q '^MODULES=[^#]*nvidia' /etc/mkinitcpio.conf || {
    MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
    mkinitcpio -P
}

grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=[^#]*nvidia' /etc/default/grub || {
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"nvidia-drm.modeset=1 @" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

####################################################################

finish

