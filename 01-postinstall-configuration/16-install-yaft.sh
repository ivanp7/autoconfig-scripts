#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Installing yaft ####"

####################################################################

check_user

####################################################################

YAFT_ACTIVE_CURSOR_COLOR=7
YAFT_TABSTOP=4
YAFT_TERMINUS_FONT_VARIATION=u12n

clone_git_repo_and_cd yaft https://aur.archlinux.org/yaft.git

makepkg --noconfirm -o
YAFT_VER=$(cat PKGBUILD | grep ^pkgver= | cut -d'=' -f2)

cd src/yaft-$YAFT_VER/

# change ACTIVE_CURSOR_COLOR
sed -i "/^[[:blank:]]*ACTIVE_CURSOR_COLOR[[:blank:]]*=/ s/2/$YAFT_ACTIVE_CURSOR_COLOR/" conf.h
# change TABSTOP
sed -i "/^[[:blank:]]*TABSTOP[[:blank:]]*=/ s/8/$YAFT_TABSTOP/" conf.h
# enable FORCE_TEXT_MODE
sed -i "/^[[:blank:]]*FORCE_TEXT_MODE[[:blank:]]*=/ s/false/true/" conf.h
# do not build default font
sed -i '/^[[:blank:]]*.\/mkfont_bdf/ s/.\/mkfont_bdf/# .\/mkfont_bdf/' makefile
# build Terminus font instead
make mkfont_bdf
install -Dm 755 "$(aux_dir)/glyph_builder.sh" ./
sh glyph_builder.sh terminus $YAFT_TERMINUS_FONT_VARIATION

cd ../..
makepkg --noconfirm -ei

####################################################################

finish

