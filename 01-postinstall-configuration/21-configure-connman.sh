#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring connman ####"

####################################################################

check_root

####################################################################

sed -i "s/^# AllowHostnameUpdates =.*/AllowHostnameUpdates = false/" /etc/connman/main.conf
sed -i "s/^# PreferredTechnologies =.*/PreferredTechnologies = ethernet,wifi/" /etc/connman/main.conf
sed -i "s/^# SingleConnectedTechnology =.*/SingleConnectedTechnology = true/" /etc/connman/main.conf

sv restart connmand

####################################################################

finish

