#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Installing Open VM Tools ####"

####################################################################

check_root

####################################################################

install_official_packages open-vm-tools

install_and_enable_service vmtoolsd log
install_and_enable_service vmware-vmblock-fuse log

####################################################################

print_message "Adding kernel modules..."

grep -q '^MODULES=[^#]*vmw_' /etc/mkinitcpio.conf || {
    MODULES="vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport"
    sed -i "/^MODULES=/ s/(/($MODULES /" /etc/mkinitcpio.conf
    mkinitcpio -P
}

####################################################################

finish

