#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure connman"
. "./.init.sh"

####################################################################

sed -i "s/^# PreferredTechnologies =.*/PreferredTechnologies = ethernet,wifi/" /etc/connman/main.conf
sed -i "s/^# NetworkInterfaceBlacklist =.*/NetworkInterfaceBlacklist = vnet,vmnet,vboxnet,virbr,ifb,ve-,vb-/" /etc/connman/main.conf
sed -i "s/^# AllowHostnameUpdates =.*/AllowHostnameUpdates = false/" /etc/connman/main.conf
sed -i "s/^# SingleConnectedTechnology =.*/SingleConnectedTechnology = true/" /etc/connman/main.conf

if ! grep -q "^TimeUpdates=" /var/lib/connman/settings
then
    sed -i "s/^\[global\]$/[global]\nTimeUpdates=manual/" /var/lib/connman/settings
fi

sv restart connmand

