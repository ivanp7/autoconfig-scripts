#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing Open VM Tools ####"

####################################################################

check_user

####################################################################

install_official_packages open-vm-tools
sudo systemctl enable vmtoolsd.service vmware-vmblock-fuse.service
sudo systemctl start vmtoolsd.service vmware-vmblock-fuse.service

####################################################################

print_message "Adding kernel modules..."
VMW_MODULES="vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport"
sudo sed -i "s/^MODULES=(/MODULES=($VMW_MODULES /" /etc/mkinitcpio.conf
sudo sed -i "s/^MODULES=($VMW_MODULES $VMW_MODULES /MODULES=($VMW_MODULES /" /etc/mkinitcpio.conf
sudo mkinitcpio -p $(initcpio_preset)

####################################################################

print_message "Setting framebuffer resolution..."

# Mode 0x0342: 1152x864 (+4608), 24 bits
sudo sed -i 's/^GRUB_GFXMODE=auto$/GRUB_GFXMODE=1152x864x24/' /etc/default/grub
sudo sed -i 's/^GRUB_GFXPAYLOAD_LINUX=keep$/GRUB_GFXPAYLOAD_LINUX=1152x864/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

