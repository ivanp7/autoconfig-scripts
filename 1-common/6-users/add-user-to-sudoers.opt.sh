#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Add a user to sudoers"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$USERNAME" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --inputbox "Input name of the user" 8 39 \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    USERNAME="$(cat "$DIALOG_FILE")"

    [ "${#USERNAME}" -le 32 ] && echo "$USERNAME" | grep -q "^[a-z_][a-z0-9_-]*\$" &&
        id -u "$USERNAME" > /dev/null 2>&1 || USERNAME=

    [ -z "$USERNAME" ] && continue

    export USERNAME
    self_logging
done

install -m 440 "$(aux_dir)/user_sudoers" "/etc/sudoers.d/${USERNAME}_sudoers"
sed -i "s/USERNAME/$USERNAME/g" "/etc/sudoers.d/${USERNAME}_sudoers"

