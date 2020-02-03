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
then rm -rf $DIR/*.pkg.tar.*
else git clone $GIT_URL_PREFIX/tabbed-ivanp7.git
fi
cd $DIR

HARDCODED_FONT="xos4 Terminus:size=10"
sed -i "s/$HARDCODED_FONT/$DEFAULT_FONT/" config.h

makepkg --noconfirm -si

####################################################################

finish

