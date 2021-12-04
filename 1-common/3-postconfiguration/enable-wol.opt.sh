#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable Wake-on-Lan"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$INTERFACE" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --inputbox "Input name of network interface" \
        9 25 "eth0" \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    INTERFACE="$(cat "$DIALOG_FILE")"

    [ "$INTERFACE" ] && ip link show "$INTERFACE" > /dev/null 2>&1 || continue

    export INTERFACE
    self_logging
done

ethtool -s $INTERFACE wol g
add_cronjob "@reboot /usr/bin/ethtool -s $INTERFACE wol g" "ethtool -s"

