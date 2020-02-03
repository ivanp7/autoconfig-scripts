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
then rm -rf $DIR/*.pkg.tar.*
else git clone https://aur.archlinux.org/st-luke-git.git
fi
cd $DIR

makepkg --noconfirm -o
cd src/st-luke/
install -Dm 644 $(aux_dir)/config.h $(aux_dir)/st.info $(aux_dir)/st.1 ./
FONT=$(echo $DEFAULT_FONT | sed -E 's/^(.*):.*/\1/')
FONT_SIZE=$(echo $DEFAULT_FONT | sed -E 's/.*:size=([[:digit:]]*):?.*/\1/')
sed -i "s/FONT_NAME/$FONT/; s/FONT_SIZE/$FONT_SIZE/" config.h
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

