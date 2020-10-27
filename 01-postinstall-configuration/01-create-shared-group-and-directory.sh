#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Creating shared group and directory ####"

####################################################################

check_root

####################################################################

groupadd shared
mkdir "$SHARED_DIRECTORY"
chown root:shared "$SHARED_DIRECTORY"
chmod 2775 "$SHARED_DIRECTORY"

####################################################################

finish

