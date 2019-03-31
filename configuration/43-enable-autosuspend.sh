#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

check_user

####################################################################

cd /tmp
git clone $GIT_URL_PREFIX/server-autosuspend.git
sh server-autosuspend/install.sh
cd /home/shared

####################################################################

finish

