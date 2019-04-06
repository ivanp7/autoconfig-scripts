#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring virtual machine shared folders ####"

####################################################################

check_user

####################################################################

SHARED_DIRECTORIES_MOUNT_LOCATION=/mnt/vmhgfs

sudo mkdir -p $SHARED_DIRECTORIES_MOUNT_LOCATION

sudo groupadd vmhgfs
sudo gpasswd -a $(whoami) vmhgfs

echo | sudo tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | sudo tee -a /etc/fstab
for dir in $(vmware-hgfsclient)
do
    sudo mkdir $SHARED_DIRECTORIES_MOUNT_LOCATION/$dir
    echo ".host:/$dir $SHARED_DIRECTORIES_MOUNT_LOCATION/$dir fuse.vmhgfs-fuse rw,allow_other,uid=root,gid=vmhgfs,umask=0113,auto_unmount,defaults 0 0" | sudo tee -a /etc/fstab
done
echo | sudo tee -a /etc/fstab
sudo mount -a

####################################################################

finish

