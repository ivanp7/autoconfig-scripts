#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install packages for Lisp development"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
    sbcl "Steel Bank Common Lisp" on \
    quicklisp "A library manager for Common Lisp" on \
    roswell "Lisp installer and launcher" on

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

