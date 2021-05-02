#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring WPA supplicant ####"

####################################################################

check_root

####################################################################

install -Dm 644 -t /etc/wpa_supplicant/ "$(aux_dir)/wpa_supplicant.conf"

DBUS_FILE="/usr/share/dbus-1/system-services/fi.w1.wpa_supplicant1.service"
grep -q '^Exec=.*-f /var/log/wpa_supplicant\.log' "$DBUS_FILE" ||
    sed -i '/^Exec=/ s@$@ -f /var/log/wpa_supplicant.log@' "$DBUS_FILE"

####################################################################

finish

