#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Generating 'hosts' file ####"

####################################################################

check_root

####################################################################

DIR=hosts-gen

cd /tmp
if [ ! -d "$DIR" ]
then git clone http://git.r-36.net/hosts-gen
fi
cd $DIR

HOSTNAME=$(hostname)

mkdir -p /etc/hosts.d/
install -Dm 644 $(aux_dir)/00-hosts.header /etc/hosts.d/
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" > /etc/hosts.d/01-hosts.local
echo >> /etc/hosts.d/01-hosts.local
examples/gethostszero

bin/hosts-gen

####################################################################

finish

