#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Enabling autosuspending on inactivity ####"

####################################################################

initialize

####################################################################

mkdir -p tmp
cd tmp
git clone $GIT_URL_PREFIX/server-autosuspend.git
cd server-autosuspend

sh install.sh

cd ../..
rm -rf tmp/server-autosuspend

####################################################################

finish

