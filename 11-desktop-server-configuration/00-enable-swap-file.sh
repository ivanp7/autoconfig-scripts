#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Enabling swap file ####"

####################################################################

check_root

####################################################################

fallocate -l $(($(awk '/MemTotal/ {print $2}' /proc/meminfo) + 4))k /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
cat "$(aux_dir)/fstab_swap" | tee -a /etc/fstab

####################################################################

finish

