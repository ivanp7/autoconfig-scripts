#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable VMWare kernel modules"
. "./.init.sh"

####################################################################

! grep -q '^MODULES=[^#]*vmw_' /etc/mkinitcpio.conf && {
    MODULES="vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport"
    sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
    mkinitcpio -P
}

