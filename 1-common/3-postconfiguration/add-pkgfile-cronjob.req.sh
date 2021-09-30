#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Add pkgfile cronjob"
. "./.init.sh"

####################################################################

add_cronjob '@daily /usr/bin/pkgfile --update' 'pkgfile --update' &&
    echo "Added the cronjob, now running the task for the first time"
pkgfile --update

