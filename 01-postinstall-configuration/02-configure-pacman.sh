#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring pacman ####"

####################################################################

check_root

####################################################################

sed -i "s/^#Color/Color/" /etc/pacman.conf
cat "$(aux_dir)/arch_repos" | tee -a /etc/pacman.conf
install -Dm 644 -t "/etc/pacman.d/" "$(aux_dir)/mirrorlist-arch"

####################################################################

finish

