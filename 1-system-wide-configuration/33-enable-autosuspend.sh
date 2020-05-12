#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_root

####################################################################

cd /tmp
git clone $GIT_URL_PREFIX/server-autosuspend.git

server-autosuspend/install.sh

####################################################################

finish

