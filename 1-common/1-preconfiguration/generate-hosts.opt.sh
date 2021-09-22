#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Generate /etc/hosts"
. "./.init.sh"

####################################################################

git_clone_and_cd hosts-gen https://github.com/mustaqimM/hosts-gen.git

HOSTNAME="$(cat /etc/hostname)"

mkdir -p /etc/hosts.d/
install -Dm 644 -t /etc/hosts.d/ "$(aux_dir)/00-hosts.header"
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" > /etc/hosts.d/01-hosts.local
echo >> /etc/hosts.d/01-hosts.local
examples/gethostszero

bin/hosts-gen

