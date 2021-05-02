#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Generating 'hosts' file ####"

####################################################################

check_root

####################################################################

DIR=hosts-gen

cd /tmp
if [ ! -d "$DIR" ]
then git clone https://github.com/mustaqimM/hosts-gen.git
fi
cd $DIR

HOSTNAME=$(cat /etc/hostname)

mkdir -p /etc/hosts.d/
install -Dm 644 "$(aux_dir)/00-hosts.header" /etc/hosts.d/
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" > /etc/hosts.d/01-hosts.local
echo >> /etc/hosts.d/01-hosts.local
examples/gethostszero

bin/hosts-gen

####################################################################

finish

