#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing tabbed ####"

####################################################################

check_user

####################################################################

DIR=tabbed-ivanp7

cd /tmp
if [ -d "$DIR" ]
then rm -rf $DIR/*.pkg.tar.xz
else git clone $GIT_URL_PREFIX/tabbed-ivanp7.git
fi
cd $DIR

makepkg --noconfirm -si

####################################################################

finish

