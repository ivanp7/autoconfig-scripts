#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Set sxiv as default image opener"
. "./.init.sh"

####################################################################

xdg-mime default sxiv.desktop $(sed '/^MimeType=/!d; s/.*=//; s/;/ /g' /usr/share/applications/sxiv.desktop)

