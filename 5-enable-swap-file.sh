#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Enabling swap file ####"

####################################################################

initialize

####################################################################

sudo fallocate -l $(awk '/MemTotal/ {print $2}' /proc/meminfo)k /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '# swap file
/swapfile none swap defaults 0 0
' | sudo tee -a /etc/fstab

####################################################################

finish

