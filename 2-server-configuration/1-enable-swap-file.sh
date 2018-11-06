#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling swap file ####"

####################################################################

initialize

####################################################################

sudo fallocate -l $(($(awk '/MemTotal/ {print $2}' /proc/meminfo) + 4))k /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
cat $SCRIPT_DIR/aux/1/fstab_swap | sudo tee -a /etc/fstab

####################################################################

finish

