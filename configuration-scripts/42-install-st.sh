#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing st ####"

####################################################################

check_user

####################################################################

DIR=st-luke-git

cd /tmp
if [ -d "$DIR" ]
then rm -rf $DIR/*.pkg.tar.xz
else git clone https://aur.archlinux.org/st-luke-git.git
fi
cd $DIR

makepkg --noconfirm -o

cd src/st-luke/
install -Dm 644 $(aux_dir)/config.h ./
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

