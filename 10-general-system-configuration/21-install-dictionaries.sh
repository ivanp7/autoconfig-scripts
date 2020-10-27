#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing sdcv dictionaries ####"

####################################################################

check_user

####################################################################

install_packages stardict-full-eng-rus stardict-full-rus-eng
install_packages stardict-slang-eng-rus stardict-computer-ru

####################################################################

finish

