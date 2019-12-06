#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing dwm ####"

####################################################################

check_user

####################################################################

DIR=dwm

cd /tmp
if [ -d "$DIR" ]
then rm -rf $DIR/*.pkg.tar.xz
else git clone https://aur.archlinux.org/dwm.git
fi
cd $DIR

makepkg --noconfirm -o

cd $(find src -maxdepth 1 -type d -name "dwm*" -print -quit)
install -Dm 644 $(aux_dir)/config.h ./
cd ../..

makepkg --noconfirm -ei

####################################################################

finish

