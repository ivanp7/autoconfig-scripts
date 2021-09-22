#!/bin/sh

cd -- "$(dirname "$0")"

usage ()
{
    echo "USAGE: $(basename $0) <hostname>"
}

print_step ()
{
    echo
    echo "========================================================================"
    echo " $@"
    echo "========================================================================"
    echo
}

if [ "$#" -eq 0 ]
then
    usage
    exit
fi

if [ "$(id -u)" -ne 0 ]
then
    echo "Error: must be root"
    echo
    usage
    exit 1
fi

HOSTNAME="$1"

[ -z "$HOSTNAME" ] && {
    echo "Error: must provide a valid hostname"
    echo
    usage
    exit 1
}

echo "$HOSTNAME" | grep -q -E "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])\$" || {
    echo "Error: the hostname is not valid"
    echo
    usage
    exit 1
}

###############################################################################

print_step "Configure time"

TIMEZONE="Europe/Minsk"
ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
hwclock --systohc

print_step "Configure locale"

sed -i "/^#en_US\.UTF-8 UTF-8/ s/^#//" /etc/locale.gen
sed -i "/^#ru_RU\.UTF-8 UTF-8/ s/^#//" /etc/locale.gen
locale-gen
install -m 644 -t /etc/ "etc/locale.conf"

print_step "Configure console"

install -m 644 -t /etc/ "etc/vconsole.conf"

print_step "Configure network"

echo "$HOSTNAME" > /etc/hostname
install -m 644 -t /etc/ "etc/hosts"
sed -i "s/hostname/$HOSTNAME/g" /etc/hosts
ln -s -t /etc/runit/runsvdir/default/ /etc/runit/sv/connmand

###############################################################################

print_step "Done! Now continue with GRUB installation"

