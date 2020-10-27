#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Setting best framebuffer resolution for VMWare virtual machine ####"

####################################################################

check_root

####################################################################

grep -q '^GRUB_GFXMODE=1152x864' /etc/default/grub || {
    # Mode 0x0342: 1152x864 (+4608), 24 bits
    sed -i 's/^GRUB_GFXMODE=auto$/GRUB_GFXMODE=1152x864x24/' /etc/default/grub
    sed -i 's/^GRUB_GFXPAYLOAD_LINUX=keep$/GRUB_GFXPAYLOAD_LINUX=1152x864/' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

####################################################################

finish

