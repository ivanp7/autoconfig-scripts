#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable Nvidia Direct Rendering Manager"
. "./.init.sh"

####################################################################

install_packages nvidia-dkms nvidia-prime

grep -q '^MODULES=[^#]*nvidia' /etc/mkinitcpio.conf || {
    MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm"
    sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
    mkinitcpio -P
}

grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=[^#]*nvidia' /etc/default/grub || {
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"nvidia-drm.modeset=1 @" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}
