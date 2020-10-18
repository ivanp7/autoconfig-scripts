#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring network ####"

####################################################################

check_root

####################################################################

sed -i "s/^# AllowHostnameUpdates =.*/AllowHostnameUpdates = false/" /etc/connman/main.conf
sed -i "s/^# PreferredTechnologies =.*/PreferredTechnologies = ethernet,wifi/" /etc/connman/main.conf
sed -i "s/^# SingleConnectedTechnology =.*/SingleConnectedTechnology = true/" /etc/connman/main.conf

sv restart connmand

####################################################################

finish

