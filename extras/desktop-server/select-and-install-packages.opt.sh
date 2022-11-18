#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install packages for Web server"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
    quark-git "An extremly small and simple http get-only web server. It only serves static pages on a single host." on \
    stunnel "A program that allows you to encrypt arbitrary TCP connections inside SSL" on \
    certbot "A tool to automatically receive and install X.509 certificates to enable TLS on servers. The client will interoperate with the Let’s Encrypt CA which will be issuing browser-trusted certificates for free." on

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

