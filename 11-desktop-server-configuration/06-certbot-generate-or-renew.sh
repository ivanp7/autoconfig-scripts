#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Generating/renewing SSL certificate ####"

####################################################################

check_root

####################################################################

certbot certonly --manual --preferred-challenges dns

####################################################################

finish

