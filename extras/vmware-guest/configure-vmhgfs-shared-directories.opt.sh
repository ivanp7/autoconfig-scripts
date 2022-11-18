#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure vmhgfs shared directories"
. "./.init.sh"

####################################################################

groupadd vmhgfs

MOUNT_LOCATION=/mnt/vmhgfs
MOUNT_OPTIONS="rw,allow_other,uid=root,gid=vmhgfs,umask=0113,auto_unmount,defaults"

mkdir -p -- "$MOUNT_LOCATION"

echo >> /etc/fstab
echo "# VMWare Workstation shared directories" >> /etc/fstab
for dir in $(vmware-hgfsclient)
do
    mkdir -p -- "$MOUNT_LOCATION/$dir"
    echo ".host:/$dir $MOUNT_LOCATION/$dir fuse.vmhgfs-fuse $MOUNT_OPTIONS 0 0" | tee -a /etc/fstab
    mount --target "$MOUNT_LOCATION/$dir"
done
echo >> /etc/fstab

