#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable swap file"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$SWAP_MEMORY_SIZE" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --inputbox "Input swap file size in KiB" \
        9 25 "$(($(awk '/MemTotal/ {print $2}' /proc/meminfo) + 4))" \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    SWAP_MEMORY_SIZE="$(cat "$DIALOG_FILE")"

    echo "$SWAP_MEMORY_SIZE" | grep -qE "^[1-9][0-9]*\$" || SWAP_MEMORY_SIZE=

    [ -z "$SWAP_MEMORY_SIZE" ] && continue

    export SWAP_MEMORY_SIZE
    self_logging
done

fallocate -l "${SWAP_MEMORY_SIZE}k" /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile

! grep -q "^\s*/swapfile\s*" /etc/fstab &&
    cat "$(aux_dir)/fstab_swap" | tee -a /etc/fstab

