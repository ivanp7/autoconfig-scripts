#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set login issue"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$VT_WIDTH" -o -z "$VT_HEIGHT" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --form "Input virtual terminal size" 9 22 2 \
        "width" 1 2 "${VT_WIDTH:-$(tput cols)}" 1 10 4 3 \
        "height" 2 2 "${VT_HEIGHT:-$(tput lines)}" 2 10 4 3 \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    VT_WIDTH="$(head -1 "$DIALOG_FILE")"
    VT_HEIGHT="$(tail -1 "$DIALOG_FILE")"

    echo "$VT_WIDTH" | grep -q "^[1-9][0-9]*\$" && [ "$VT_WIDTH" -ge 40 ] || VT_WIDTH=
    echo "$VT_HEIGHT" | grep -qE "^[1-9][0-9]*\$" && [ "$VT_HEIGHT" -ge 30 ] || VT_HEIGHT=

    [ -z "$VT_WIDTH" -o -z "$VT_HEIGHT" ] && continue

    export VT_WIDTH VT_HEIGHT
    self_logging
done

install -m 644 "$(aux_dir)/issue" /etc/
LOGO_HALFWIDTH=18
LOGO_HALFHEIGHT=11
PROMPT_HEIGHT=5
sed -i "s/<HORIZONTAL>/$(($VT_WIDTH / 2 - $LOGO_HALFWIDTH))/;
    s/<VERTICAL>/$(($VT_HEIGHT / 2 - $LOGO_HALFHEIGHT - $PROMPT_HEIGHT))/" /etc/issue

