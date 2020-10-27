#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Enabling AMD IOMMU ####"

####################################################################

check_root

####################################################################

grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=[^#]*iommu' /etc/default/grub || {
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"amd_iommu=on iommu=pt @" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

####################################################################

finish

