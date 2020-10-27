#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling Wake-on-Lan ####"

####################################################################

check_root

####################################################################

INTERFACE="$(ip link | grep -E '^[[:digit:]]*: *en.*:' | 
    sed -E 's/^(.*): *(.*): (.*)/\2/' | head -n 1)"
[ -n "$INTERFACE" ] && add_cronjob "@reboot /usr/bin/ethtool -s $INTERFACE wol g"

####################################################################

finish

