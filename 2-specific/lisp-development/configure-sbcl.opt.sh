#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure SBCL"
. "./.init.sh"

####################################################################

install -m 644 -t /etc/ "$(aux_dir)/sbclrc"
