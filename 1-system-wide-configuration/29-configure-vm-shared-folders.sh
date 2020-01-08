#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring virtual machine shared folders ####"

####################################################################

check_root

####################################################################

MOUNT_LOCATION=/mnt/vmhgfs
MOUNT_OPTIONS="rw,allow_other,uid=root,gid=vmhgfs,umask=0113,auto_unmount,defaults"

mkdir -p $MOUNT_LOCATION

groupadd vmhgfs
gpasswd -a $(whoami) vmhgfs

echo | tee -a /etc/fstab
echo "# VMWare Workstation shared folders" | tee -a /etc/fstab
for dir in $(vmware-hgfsclient)
do
    mkdir $MOUNT_LOCATION/$dir
    echo ".host:/$dir $MOUNT_LOCATION/$dir fuse.vmhgfs-fuse $MOUNT_OPTIONS 0 0" | 
        tee -a /etc/fstab
done
echo | tee -a /etc/fstab
mount -a

####################################################################

finish

