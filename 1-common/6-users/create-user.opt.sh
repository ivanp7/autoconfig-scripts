#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Create a user"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$USERNAME" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --inputbox "Input name of a new user" 8 39 \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    USERNAME="$(cat "$DIALOG_FILE")"

    [ "${#USERNAME}" -le 32 ] && echo "$USERNAME" | grep -q "^[a-z_][a-z0-9_-]*\$" || USERNAME=

    [ -z "$USERNAME" ] && continue

    export USERNAME
    self_logging
done

useradd -m -U -s /usr/bin/zsh "$USERNAME" && {
    mkdir -p "$HOME/.cache/zsh"

    until passwd "$USERNAME"
    do echo "Try again"; sleep 2; done
}

