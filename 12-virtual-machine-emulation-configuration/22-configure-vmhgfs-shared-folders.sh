#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Configuring VMWare shared folders ####"

####################################################################

check_root

####################################################################

groupadd vmhgfs

MOUNT_LOCATION=/mnt/vmhgfs
MOUNT_OPTIONS="rw,allow_other,uid=root,gid=vmhgfs,umask=0113,auto_unmount,defaults"

mkdir -p "$MOUNT_LOCATION"

echo >> /etc/fstab
echo "# VMWare Workstation shared folders" >> /etc/fstab
for dir in $(vmware-hgfsclient)
do
    mkdir "$MOUNT_LOCATION/$dir"
    echo ".host:/$dir $MOUNT_LOCATION/$dir fuse.vmhgfs-fuse $MOUNT_OPTIONS 0 0" >> /etc/fstab
done
echo >> /etc/fstab
mount -a

####################################################################

finish

