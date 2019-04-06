#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Decrease swappiness ####"

####################################################################

check_user

####################################################################

echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-sysctl.conf
sudo sysctl vm.swappiness=10

####################################################################

finish

