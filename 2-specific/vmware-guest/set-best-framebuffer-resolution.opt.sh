#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set framebuffer resolution to 1152x864, 24 bits"
. "./.init.sh"

####################################################################

! grep -q '^GRUB_GFXMODE=1152x864' /etc/default/grub && {
    # Mode 0x0342: 1152x864 (+4608), 24 bits
    sed -i '/^GRUB_GFXMODE=/ s/=.*$/=1152x864x24/' /etc/default/grub
    sed -i '/^GRUB_GFXPAYLOAD_LINUX=/ s/=.*$/=1152x864/' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

