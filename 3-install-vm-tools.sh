#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Installing Open VM Tools ####"

####################################################################

initialize

####################################################################

install_official_packages open-vm-tools
systemctl enable vmtoolsd.service vmware-vmblock-fuse.service
systemctl start vmtoolsd.service vmware-vmblock-fuse.service

####################################################################

print_message "Configurin automount of the host-shared folder..."
run_as_nonroot mkdir HostShared
echo >> /etc/fstab
echo "# VMWare Workstation shared folders" >> /etc/fstab
echo ".host:/VMShared /home/$USERNAME/HostShared fuse.vmhgfs-fuse rw,allow_other,uid=$USERNAME,gid=$USERNAME,umask=0033,auto_unmount,defaults 0 0" >> /etc/fstab
echo >> /etc/fstab
mount -a

####################################################################

finish

