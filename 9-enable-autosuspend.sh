#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

initialize

####################################################################

cd /tmp
git clone $GIT_URL_PREFIX/server-autosuspend.git
sh server-autosuspend/install.sh
cd /home/shared

####################################################################

finish

