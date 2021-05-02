#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Making dash the default script interpreter ####"

####################################################################

check_root

####################################################################

ln -sfT dash /usr/bin/sh

mkdir -p /etc/pacman.d/hooks/
install -Dm 644 -t /etc/pacman.d/hooks/ "$(aux_dir)/dash.hook"

####################################################################

finish

