#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Fix computer suspend with Nvidia driver ####"

####################################################################

check_root

####################################################################

install -Dm 644 -t /usr/lib/elogind/system-sleep/ "$(aux_dir)/nvidia_copy"
install -Dm 755 -T "$(aux_dir)/nvidia_copy" /usr/lib/elogind/system-sleep/nvidia

install -Dm 644 -t /etc/pacman.d/hooks/ "$(aux_dir)/nvidia-utils.hook"

####################################################################

finish

