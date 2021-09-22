#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set grub wallpaper"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

DEFAULT_WALLPAPER="tiles.jpg"

while [ ! -f "$GRUB_WALLPAPER" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --fselect "${GRUB_WALLPAPER:-"$(aux_dir)/$DEFAULT_WALLPAPER"}" $(($(tput lines)-13)) $(($(tput cols)-6)) \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    GRUB_WALLPAPER="$(cat "$DIALOG_FILE")"

    [ -f "$GRUB_WALLPAPER" ] || continue

    export GRUB_WALLPAPER
    self_logging
done

install -m 644 -t /boot/grub/ "$GRUB_WALLPAPER"
sed -i "s@^#\?GRUB_BACKGROUND=.*\$@GRUB_BACKGROUND=\"/boot/grub/$(basename "$GRUB_WALLPAPER")\"@" /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

