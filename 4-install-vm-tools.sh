#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Installing Open VM Tools ####"

####################################################################

initialize

####################################################################

install_official_packages open-vm-tools
sudo systemctl enable vmtoolsd.service vmware-vmblock-fuse.service
sudo systemctl start vmtoolsd.service vmware-vmblock-fuse.service

####################################################################

print_message "Configuring shared directory..."

SHARED_DIRECTORY_LOCATION=/mnt/vmhgfs
SHARED_DIRECTORY_NAME=shared

sudo mkdir -p $SHARED_DIRECTORY_LOCATION/$SHARED_DIRECTORY_NAME

sudo groupadd vmhgfs
sudo gpasswd -a $(whoami) vmhgfs

echo | sudo tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | sudo tee -a /etc/fstab
echo ".host:/$SHARED_DIRECTORY_NAME $SHARED_DIRECTORY_LOCATION/$SHARED_DIRECTORY_NAME fuse.vmhgfs-fuse rw,allow_other,uid=root,gid=vmhgfs,umask=0003,auto_unmount,defaults 0 0" | sudo tee -a /etc/fstab
echo | sudo tee -a /etc/fstab
sudo mount -a

####################################################################

print_message "Adding kernel modules..."

sudo sed -i "s/MODULES=()/MODULES=(vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport)/" /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

####################################################################

finish

