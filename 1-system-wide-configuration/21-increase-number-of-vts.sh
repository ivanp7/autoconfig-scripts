#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Increasing number of virtual terminals ####"

####################################################################

check_root

####################################################################

sed -i "s/^#NAutoVTs=.*$/NAutoVTs=12/" /etc/systemd/logind.conf

####################################################################

finish

