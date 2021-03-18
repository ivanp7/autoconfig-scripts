#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Configuring stunnel ####"

####################################################################

check_root

####################################################################

CONFIG_FILE="/etc/stunnel/stunnel.conf"

install -Dm 644 "$(aux_dir)/stunnel.conf" "$CONFIG_FILE"

until { echo -n 'Site name: '; read -r SITENAME; echo "$SITENAME" | grep -q "^[a-zA-Z0-9-]\+\.[a-zA-Z]\+$"; }
do echo "Try again"; sleep 1; done
sed -i "s/SITE_NAME/$SITENAME/g" "$CONFIG_FILE"

####################################################################

finish

