#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Making /tmp a mountpoint for tmpfs ####"

####################################################################

check_root

####################################################################

cat $(aux_dir)/fstab_tmp | tee -a /etc/fstab
rm -rf /tmp/*
mount -a

####################################################################

finish

