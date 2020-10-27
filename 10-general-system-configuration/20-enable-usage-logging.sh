#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling computer usage time logging ####"

####################################################################

check_root

####################################################################

install -Dm 755 $(aux_dir)/log.sh /usr/local/bin/usage-logging/
mkdir -p /var/log/usage-log
add_cronjob '* * * * * /usr/local/bin/usage-logging/log.sh'

####################################################################

finish

