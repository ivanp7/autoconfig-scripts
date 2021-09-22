#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install Common Lisp HyperSpec"
. "./.init.sh"

####################################################################

install -Dm 755 -t /usr/local/bin/ "$(aux_dir)/clhs.sh"
tar xvf "$(aux_dir)/HyperSpec.tar.gz" -C /usr/local/share -z HyperSpec

