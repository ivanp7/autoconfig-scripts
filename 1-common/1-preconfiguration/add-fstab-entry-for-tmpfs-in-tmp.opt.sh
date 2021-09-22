#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Add fstab entry to mount tmpfs in /tmp"
. "./.init.sh"

####################################################################

! grep -q "^\s*tmpfs\s\+/tmp\s\+tmpfs\s\+" /etc/fstab && {
    cat "$(aux_dir)/fstab_tmp" | tee -a /etc/fstab
    rm -rf /tmp/*
    mount /tmp
}

