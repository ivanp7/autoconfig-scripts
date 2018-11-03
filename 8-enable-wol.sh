#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
source $SCRIPT_DIR/functions.sh

####################################################################

print_message "#### Enabling Wake-on-Lan ####"

####################################################################

initialize

####################################################################

NETWORK_INTERFACE=$(grep 'Interface=' /etc/netctl/network | cut -d'=' -f2)
cat $SCRIPT_DIR/aux/network | sed "s/\$NETWORK_INTERFACE/$NETWORK_INTERFACE/g" | \
    sudo tee -a /etc/netctl/network
sudo netctl reenable network

sudo cp $SCRIPT_DIR/aux/50-reset-wol.sh /usr/lib/systemd/system-sleep/

####################################################################

finish

