#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Install Common Lisp HyperSpec ####"

####################################################################

check_root

####################################################################

install -Dm 755 -t /usr/local/bin/ "$(aux_dir)/clhs.sh"
tar xvf "$(aux_dir)/HyperSpec.tar.gz" -C /usr/local/share -z HyperSpec

####################################################################

finish

