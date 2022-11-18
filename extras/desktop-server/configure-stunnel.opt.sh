#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure stunnel"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$PATH_TO_KEYS" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --dselect "/etc/letsencrypt/live" \
        $(($(tput lines)-3)) $(($(tput cols)-9)) \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    PATH_TO_KEYS="$(cat "$DIALOG_FILE")"

    [ -z "$PATH_TO_KEYS" ] && continue

    export PATH_TO_KEYS
    self_logging
done

install -Dm 644 -t /etc/stunnel/ "$(aux_dir)/stunnel.conf"
sed -i "s,PATH_TO_KEYS,$PATH_TO_KEYS,g" "/etc/stunnel/stunnel.conf"

