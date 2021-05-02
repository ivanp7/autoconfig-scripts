#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Enabling computer usage time logging ####"

####################################################################

check_root

####################################################################

install -Dm 755 -t /usr/local/bin/usage-logging/ "$(aux_dir)/log.sh"
mkdir -p /var/log/usage-log
add_cronjob '* * * * * /usr/local/bin/usage-logging/log.sh'

####################################################################

finish

