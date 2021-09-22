#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install packages for virtual machines"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
    qemu "A generic and open source machine emulator and virtualizer" on \
    edk2-ovmf "Firmware for Virtual Machines (x86_64, i686)" on \
    libvirt "API for controlling virtualization engines (openvz,kvm,qemu,virtualbox,xen,etc)" on \
    ebtables "Ethernet bridge filtering utilities" on \
    dnsmasq "Lightweight, easy to configure DNS forwarder and DHCP server" on \
    virt-manager "Desktop user interface for managing virtual machines" on

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

