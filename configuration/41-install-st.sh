#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing st ####"

####################################################################

check_user

####################################################################

cd /tmp
[ -d "st-luke-git" ] && rm -rf st-luke-git
git clone https://aur.archlinux.org/st-luke-git.git
cd st-luke-git

makepkg --noconfirm -o

cd src/st-luke/
install -Dm 644 $(aux_dir)/config.h ./
cd ../..

makepkg --noconfirm -ei

####################################################################

finish

