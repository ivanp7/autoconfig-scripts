#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing computer remote control script ####"

####################################################################

check_user

####################################################################

ros install ivanp7/remote-control

####################################################################

finish

