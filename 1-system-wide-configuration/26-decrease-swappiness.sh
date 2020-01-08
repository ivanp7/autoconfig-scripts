#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Decrease swappiness ####"

####################################################################

check_root

####################################################################

echo "vm.swappiness=10" | tee -a /etc/sysctl.d/99-sysctl.conf
sysctl vm.swappiness=10

####################################################################

finish

