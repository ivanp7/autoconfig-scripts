#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Create autoconfig user and group and install sudoers file"
. "./.init.sh"

####################################################################

useradd -c "Autoconfiguration scripts" -d / -l -M -s /usr/bin/nologin -U autoconfig
install -m 440 -t /etc/sudoers.d/ "$(aux_dir)/autoconfig_sudoers"

