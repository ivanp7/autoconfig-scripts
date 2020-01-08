#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring network ####"

####################################################################

check_root

####################################################################

WIRED_INTERFACE="$(ip link | grep -E '^[[:digit:]]*: *en.*:' | sed -E 's/^(.*): *(.*): (.*)/\2/' | head -n1)"
if [ -n "$WIRED_INTERFACE" ]
then
    sed -i "/^INTERFACES=/ s/\".*\"/\"${WIRED_INTERFACE}\"/" /etc/ifplugd/ifplugd.conf
    systemctl enable --now netctl-ifplugd@${WIRED_INTERFACE}.service
fi

WIRELESS_INTERFACE="$(ip link | grep -E '^[[:digit:]]*: *wl.*:' | sed -E 's/^(.*): *(.*): (.*)/\2/' | head -n1)"
if [ -n "$WIRELESS_INTERFACE" ]
then
    systemctl enable --now netctl-auto@${WIRELESS_INTERFACE}.service
fi

####################################################################

finish

