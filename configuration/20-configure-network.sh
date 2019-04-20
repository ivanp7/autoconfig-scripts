#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring network ####"

####################################################################

check_user

####################################################################

WIRED_INTERFACE="$(ip link | egrep "^[[:digit:]]*:" | cut -d' ' -f2 | tr -d : | egrep "^en" | head -n1)"
if [ -n "$WIRED_INTERFACE" ]
then
    sudo sed -i "/^INTERFACES=/ s/\".*\"/\"${WIRED_INTERFACE}\"/" /etc/ifplugd/ifplugd.conf
    sudo systemctl enable --now netctl-ifplugd@${WIRED_INTERFACE}.service
fi

WIRELESS_INTERFACE="$(ip link | egrep "^[[:digit:]]*:" | cut -d' ' -f2 | tr -d : | egrep "^wl" | head -n1)"
if [ -n "$WIRELESS_INTERFACE" ]
then
    sudo systemctl enable --now netctl-auto@${WIRELESS_INTERFACE}.service
fi

####################################################################

finish

