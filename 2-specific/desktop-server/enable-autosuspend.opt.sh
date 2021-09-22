#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install and enable autosuspend service"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$ACTIVITY_CHECK" -o -z "$SUSPEND_ACTION" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --title "Edit computer activity check" --editbox "$(aux_dir)/activity-check.sh" \
        $(($(tput lines)-3)) $(($(tput cols)-9)) \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    ACTIVITY_CHECK="$(cat "$DIALOG_FILE")"

    dialog --erase-on-exit --title "Edit suspend action" --editbox "$(aux_dir)/suspend.sh" \
        $(($(tput lines)-3)) $(($(tput cols)-9)) \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    SUSPEND_ACTION="$(cat "$DIALOG_FILE")"

    [ -z "$ACTIVITY_CHECK" -o -z "$SUSPEND_ACTION" ] && continue

    export ACTIVITY_CHECK SUSPEND_ACTION
    self_logging
done

DIR=/usr/local/bin/autosuspend

mkdir -p -- "$DIR"

echo "$ACTIVITY_CHECK" > "$DIR/activity-check.sh"
chmod 755 "$DIR/activity-check.sh"

echo "$SUSPEND_ACTION" > "$DIR/suspend.sh"
chmod 755 "$DIR/suspend.sh"

install_service up,log "$(aux_dir)/autosuspend"
enable-service autosuspend

