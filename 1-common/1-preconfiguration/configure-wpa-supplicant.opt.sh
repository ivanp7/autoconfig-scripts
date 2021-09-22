#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure WPA supplicant"
. "./.init.sh"

####################################################################

install -Dm 644 -t /etc/wpa_supplicant/ "$(aux_dir)/wpa_supplicant.conf"

DBUS_FILE="/usr/share/dbus-1/system-services/fi.w1.wpa_supplicant1.service"
grep -q '^Exec=.*\s-f\s' "$DBUS_FILE" ||
    sed -i '/^Exec=/ s@$@ -f /var/log/wpa_supplicant.log@' "$DBUS_FILE"

