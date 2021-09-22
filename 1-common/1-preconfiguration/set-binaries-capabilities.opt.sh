#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set binaries capabilities"
. "./.init.sh"

####################################################################

setcap cap_net_raw+p /usr/bin/ping

