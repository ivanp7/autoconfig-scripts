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

SHARED_DIRECTORY_VMWARE_NAME=VMShared
SHARED_DIRECTORY=$HOME/HostShared

print_message "Configuring automount of the host-shared folders..."
mkdir HostShared
echo | sudo tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | sudo tee -a /etc/fstab
echo ".host:/$SHARED_DIRECTORY_VMWARE_NAME $SHARED_DIRECTORY fuse.vmhgfs-fuse rw,allow_other,uid=$(whoami),gid=$(whoami),umask=0033,auto_unmount,defaults 0 0" | sudo tee -a /etc/fstab
echo | sudo tee -a /etc/fstab
sudo mount -a

####################################################################

finish

