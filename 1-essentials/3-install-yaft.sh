#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing yaft ####"

####################################################################

initialize

####################################################################

YAFT_TABSTOP=4
YAFT_TERMINUS_FONT_VARIATION=u12n

print_message "Installing yaft..."

cd /tmp
git clone https://aur.archlinux.org/yaft.git
cd yaft
makepkg --noconfirm -o
YAFT_VER=$(cat PKGBUILD | grep ^pkgver= | cut -d'=' -f2)
cd src/yaft-$YAFT_VER/

# change TABSTOP
sed -i "/^[[:blank:]]*TABSTOP[[:blank:]]*=/ s/8/$YAFT_TABSTOP/" conf.h
# do not build default font
sed -i '/^[[:blank:]]*.\/mkfont_bdf/ s/.\/mkfont_bdf/# .\/mkfont_bdf/' makefile
# build Terminus font instead
make mkfont_bdf
cp $SCRIPT_DIR/aux/3/glyph_builder.sh ./
sh glyph_builder.sh terminus $YAFT_TERMINUS_FONT_VARIATION

cd ../..
makepkg --noconfirm -ei

sudo gpasswd -a $(whoami) video

####################################################################

finish

