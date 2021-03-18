#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing web server and dependencies ####"

####################################################################

check_user

####################################################################

print_message "#### Installing simple static web server ####"

install_packages quark-git

print_message "#### Installing TLS proxy ####"

install_official_packages stunnel

print_message "#### Installing CertBot ####"

install_official_packages certbot

####################################################################

finish

