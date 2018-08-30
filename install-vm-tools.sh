#!/bin/bash

if [[ $EUID == 0 ]]; then
    echo This script must be run under non-priviledged user. Terminating...
    exit 1
fi

USERNAME=$(whoami)

####################################################################

echo
echo "Installing Open VM Tools..."
echo "---------------------------"
echo
sudo pacman --noconfirm -S open-vm-tools
sudo systemctl enable vmtoolsd.service vmware-vmblock-fuse.service
sudo systemctl start vmtoolsd.service vmware-vmblock-fuse.service

echo
echo "Configuring automount of host-shared folder"
echo "-------------------------------------------"
echo
mkdir -p ~/HostShared
echo | sudo tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | sudo tee -a /etc/fstab
echo ".host:/VMShared /home/$USERNAME/HostShared fuse.vmhgfs-fuse rw,allow_other,uid=$USERNAME,gid=$USERNAME,umask=0033,auto_unmount,defaults 0 0" | sudo tee -a /etc/fstab
echo | sudo tee -a /etc/fstab
sudo mount -a

####################################################################

