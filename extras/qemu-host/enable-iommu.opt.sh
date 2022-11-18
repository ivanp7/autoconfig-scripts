#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Enable IOMMU"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

if [ -z "$PROCESSOR_TYPE" ]
then
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --radiolist "Select type of the processor" 9 32 2 \
        amd "AMD processor" off \
        intel "Intel processor" on \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    export PROCESSOR_TYPE="$(cat "$DIALOG_FILE")"
    self_logging
fi

grep -q '^GRUB_CMDLINE_LINUX_DEFAULT=[^#]*iommu' /etc/default/grub || {
    sed -i "/^GRUB_CMDLINE_LINUX_DEFAULT=/ s@\"@\"${PROCESSOR_TYPE}_iommu=on iommu=pt @" /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
}

