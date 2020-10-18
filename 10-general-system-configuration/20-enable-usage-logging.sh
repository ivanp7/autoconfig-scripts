#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling computer usage time logging ####"

####################################################################

check_root

####################################################################

install -Dm 755 -o root -g root -t /usr/local/bin/usage-logging/ $(aux_dir)/log.sh
mkdir -p /var/log/usage-log
crontab -l | { cat; echo '* * * * * /usr/local/bin/usage-logging/log.sh'; } | crontab -

####################################################################

finish

