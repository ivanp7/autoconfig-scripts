#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing patched Terminus font ####"

####################################################################

check_user

####################################################################

DIR=terminus-font-ll2-td1-dv1-ij1

cd /tmp
if [ -d "$DIR" ]
then
    cd -- "$DIR"
    rm -f *.pkg.tar.*
    rm -rf pkg
else
    mkdir -p -- "$DIR"
    cd -- "$DIR"
fi

install -m 644 -t ./ "$(aux_dir)/PKGBUILD"
install -m 644 -t ./ "$(aux_dir)/fix-75-yes-terminus.patch"

TERMINUS_FONT_PACKAGE=$(pacman -Qi terminus-font | grep '^Name\s*:' | sed -E 's/.*:\s*//')
[ -z "$TERMINUS_FONT_PACKAGE" ] || uninstall_packages $TERMINUS_FONT_PACKAGE

makepkg --noconfirm -si

####################################################################

finish

