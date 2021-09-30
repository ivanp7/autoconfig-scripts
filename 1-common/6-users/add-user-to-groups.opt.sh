#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Add a user to groups"
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

    HEIGHT=$(tput lines)
    dialog --erase-on-exit --checklist "Select groups to add user to" $(($HEIGHT-3)) $(($(tput cols)-6)) $(($HEIGHT-9)) \
        video "for fbterm and VT control" on \
        ssh-users "for remote login via SSH (conflicts with sftp-users)" on \
        sftp-users "for remote file access via SSH (conflicts with ssh-users)" off \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    export SELECTED_GROUPS="$(cat "$DIALOG_FILE")"

    self_logging
done

for group in $SELECTED_GROUPS
do gpasswd -a $USERNAME $group
done

