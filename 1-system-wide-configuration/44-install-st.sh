#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing st ####"

####################################################################

check_user

####################################################################

clone_git_repo_and_cd st-luke-git https://aur.archlinux.org/st-luke-git.git

makepkg --noconfirm -o
cd src/st-luke/
install -Dm 644 $(aux_dir)/config.h $(aux_dir)/st.info $(aux_dir)/st.1 ./
FONT=$(echo $DEFAULT_FONT | sed -E 's/^(.*):.*/\1/')
FONT_SIZE=$(echo $DEFAULT_FONT | sed -E 's/.*:size=([[:digit:]]*):?.*/\1/')
sed -i "s/FONT_NAME/$FONT/; s/FONT_SIZE/$FONT_SIZE/" config.h
install -Dm 644 $(aux_dir)/st-keycodes.patch ./
patch < st-keycodes.patch
cd ../..

makepkg --noconfirm -esi

####################################################################

finish

