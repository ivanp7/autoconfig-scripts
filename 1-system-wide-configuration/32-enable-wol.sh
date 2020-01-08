#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Wake-on-Lan ####"

####################################################################

check_root

####################################################################

NETWORK_INTERFACE=$(grep 'Interface=' /etc/netctl/network | cut -d'=' -f2)
cat $(aux_dir)/network | sed "s/\$NETWORK_INTERFACE/$NETWORK_INTERFACE/g" | 
    tee -a /etc/netctl/network
netctl reenable network

install -Dm 755 $(aux_dir)/50-reset-wol.sh /usr/lib/systemd/system-sleep/
sed -i "s/\$NETWORK_INTERFACE/$NETWORK_INTERFACE/g" /usr/lib/systemd/system-sleep/50-reset-wol.sh

####################################################################

finish

