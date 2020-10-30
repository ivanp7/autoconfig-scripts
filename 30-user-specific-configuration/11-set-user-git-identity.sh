#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Set user's Git identity ####"

####################################################################

check_user

####################################################################

until { echo -n 'User name: '; read USERNAME; git config --global user.name "$USERNAME"; }
do echo "Try again"; sleep 2; done

until { echo -n 'User e-mail: '; read USEREMAIL; git config --global user.email "$USEREMAIL"; }
do echo "Try again"; sleep 2; done

####################################################################

finish

