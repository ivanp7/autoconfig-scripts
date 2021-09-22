#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Generate or renew SSL certificate"
. "./.init.sh"

####################################################################

certbot certonly --manual --preferred-challenges dns

