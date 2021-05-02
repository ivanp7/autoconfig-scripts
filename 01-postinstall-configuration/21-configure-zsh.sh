#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring zsh ####"

####################################################################

check_root

####################################################################

mkdir -p /var/cache/zsh/

mkdir -p /etc/pacman.d/hooks/
install -Dm 644 -t /etc/pacman.d/hooks/ "$(aux_dir)/zsh.hook"

####################################################################

finish

