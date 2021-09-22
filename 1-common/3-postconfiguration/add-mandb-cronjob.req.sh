#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Add mandb cronjob"
. "./.init.sh"

####################################################################

mandb
add_cronjob '@daily /usr/bin/mandb' 'mandb'

