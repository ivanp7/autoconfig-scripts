#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Set login issue ####"

####################################################################

check_root

####################################################################

install -Dm 644 "$(aux_dir)/issue" /etc/
LOGO_HALFWIDTH=18
LOGO_HALFHEIGHT=10
PROMPT_HEIGHT=5
sed -i "s/<HORIZONTAL>/$(($(tput cols) / 2 - $LOGO_HALFWIDTH))/; 
    s/<VERTICAL>/$(($(tput lines) / 2 - $LOGO_HALFHEIGHT - $PROMPT_HEIGHT))/" /etc/issue

####################################################################

finish

