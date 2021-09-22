#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable hibernation"
. "./.init.sh"

####################################################################

[ ! -f "/swapfile" ] && {
    print_error "Swap file is not available"
    exit 1
}

! grep -q '^HOOKS=[^#]*resume.*' /etc/mkinitcpio.conf && {
    sed -i "/^HOOKS=/ s/fsck/resume fsck/" /etc/mkinitcpio.conf
    mkinitcpio -P
}

! grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=[^#]*resume' /etc/default/grub && {
    SWAP_DEVICE="$(df / | sed '2q;d' | awk '{print $1}')"
    SWAP_DEVICE_UUID="$(blkid | grep -F "$SWAP_DEVICE" | sed -E 's/.*UUID="(.*)".*/\1/')"
    SWAP_OFFSET="$(filefrag -v /swapfile | sed '4q;d' | awk '{print $4}' | cut -d'.' -f1)"
    SWAP_PARAMETERS="resume=UUID=${SWAP_DEVICE_UUID} resume_offset=${SWAP_OFFSET}"
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"${SWAP_PARAMETERS} @" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

