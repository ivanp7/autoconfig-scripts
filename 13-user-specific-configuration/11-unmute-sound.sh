#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Unmuting sound  ####"

####################################################################

check_user

####################################################################

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

####################################################################

finish

