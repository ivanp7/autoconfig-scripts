#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring connman ####"

####################################################################

check_root

####################################################################

# sed -i "s/^# PreferredTechnologies =.*/PreferredTechnologies = ethernet,wifi/" /etc/connman/main.conf
# sed -i "s/^# NetworkInterfaceBlacklist =.*/NetworkInterfaceBlacklist = vnet,vmnet,vboxnet,virbr,ifb,ve-,vb-/" /etc/connman/main.conf
# sed -i "s/^# AllowHostnameUpdates =.*/AllowHostnameUpdates = false/" /etc/connman/main.conf
# sed -i "s/^# SingleConnectedTechnology =.*/SingleConnectedTechnology = true/" /etc/connman/main.conf

if ! grep -q "^TimeUpdates=" /var/lib/connman/settings
then
    sed -i "s/^\[global\]$/[global]\nTimeUpdates=manual/" /var/lib/connman/settings
fi

sv restart connmand

####################################################################

finish

