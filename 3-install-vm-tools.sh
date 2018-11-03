#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
source $SCRIPT_DIR/functions.sh

####################################################################

print_message "#### Installing Open VM Tools ####"

####################################################################

initialize

####################################################################

install_official_packages open-vm-tools
sudo systemctl enable vmtoolsd.service vmware-vmblock-fuse.service
sudo systemctl start vmtoolsd.service vmware-vmblock-fuse.service

####################################################################

print_message "Adding kernel modules..."
sudo sed -i "s/^MODULES=()/MODULES=(vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport)/" /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

####################################################################

print_message "Configuring shared directories..."

SHARED_DIRECTORIES_MOUNT_LOCATION=/mnt/vmhgfs

sudo mkdir -p $SHARED_DIRECTORIES_MOUNT_LOCATION

sudo groupadd vmhgfs
sudo gpasswd -a $(whoami) vmhgfs

echo | sudo tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | sudo tee -a /etc/fstab
for dir in $(vmware-hgfsclient)
do
    sudo mkdir $SHARED_DIRECTORIES_MOUNT_LOCATION/$dir
    echo ".host:/$dir $SHARED_DIRECTORIES_MOUNT_LOCATION/$dir fuse.vmhgfs-fuse rw,allow_other,uid=root,gid=vmhgfs,umask=0003,auto_unmount,defaults 0 0" | sudo tee -a /etc/fstab
done
echo | sudo tee -a /etc/fstab
sudo mount -a

####################################################################

print_message "Configuring framebuffer resolution..."

# Mode 0x0342: 1152x864 (+4608), 24 bits
sudo sed -i 's/^GRUB_GFXMODE=auto$/GRUB_GFXMODE=1152x864x24/' /etc/default/grub
sudo sed -i 's/^GRUB_GFXPAYLOAD_LINUX=auto$/GRUB_GFXPAYLOAD_LINUX=1152x864/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

