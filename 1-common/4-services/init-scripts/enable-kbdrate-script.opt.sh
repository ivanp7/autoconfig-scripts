#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install script for setting of keyboard rate/delay in console"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

RATE_VALUES="2.0, 2.1, 2.3, 2.5, 2.7, 3.0, 3.3, 3.7, 4.0, 4.3, 4.6, 5.0, 5.5, 6.0, 6.7, 7.5, 8.0, 8.6, 9.2, 10.0, 10.9, 12.0, 13.3, 15.0, 16.0, 17.1, 18.5, 20.0, 21.8, 24.0, 26.7, 30.0"
DELAY_VALUES="250, 500, 750, 1000"

while [ -z "$KBD_RATE" -o -z "$KBD_DELAY" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit \
        --keep-window --begin 1 1 --infobox "$(echo \
        "Allowed values for rate (cps): $RATE_VALUES" \
        "\nAllowed values for delay (ms): $DELAY_VALUES")" \
        7 56 \
        --and-widget --form "Input kbdrate values" 9 25 2 \
        "rate (cps)" 1 2 "${KBD_RATE:-10.0}" 1 13 5 4 \
        "delay (ms)" 2 2 "${KBD_DELAY:-250}" 2 13 5 4 \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    KBD_RATE="$(head -1 "$DIALOG_FILE")"
    KBD_DELAY="$(tail -1 "$DIALOG_FILE")"

    echo "$KBD_RATE" | grep -qE "^($(echo "$RATE_VALUES" | sed "s/, /|/g; s/\./\\\\./g"))\$" || KBD_RATE=
    echo "$KBD_DELAY" | grep -qE "^($(echo "$DELAY_VALUES" | sed "s/, /|/g"))\$" || KBD_DELAY=

    [ -z "$KBD_RATE" -o -z "$KBD_DELAY" ] && continue

    export KBD_RATE KBD_DELAY
    self_logging
done

install_init_script "$(aux_dir)/set-kbdrate.sh"
sed -i "s/RATE/$KBD_RATE/; s/DELAY/$KBD_DELAY/" "$INIT_SCRIPTS_DIRECTORY/set-kbdrate.sh"

