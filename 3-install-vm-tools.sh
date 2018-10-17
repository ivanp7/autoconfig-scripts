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

print_message "Setting default graphics mode: 1920x1080, 60 Hz, 24 bits depth..."
echo $'
Section "Monitor"
    Identifier "Virtual1"
    ModeLine "1920x1080_60.00" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
    Option "PreferredMode" "1920x1080_60.00"
EndSection

Section "Screen"
    Identifier "Screen0"
    Monitor "Virtual1"
    DefaultDepth 24
    SubSection "Display"
        Modes "1920x1080_60.00"
    EndSubSection
EndSection

Section "Device"
    Identifier "Device0"
    Driver "vmware"
EndSection
' | sudo tee /etc/X11/xorg.conf.d/90-resolution.conf

####################################################################

print_message "Adding kernel modules..."
sudo sed -i "s/MODULES=()/MODULES=(vmw_balloon vmw_pvscsi vmw_vmci vmwgfx vmxnet3 vsock vmw_vsock_vmci_transport)/" /etc/mkinitcpio.conf
sudo mkinitcpio -p linux

####################################################################

finish

