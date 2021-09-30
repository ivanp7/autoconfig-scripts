#!/bin/sh

cd -- "$(dirname "$0")"

INSTALLED_PACKAGES="\
    base base-devel runit elogind-runit \
    linux-lts linux-firmware grub \
    dhcpcd connman-runit \
    vi git moreutils dialog sudo \
    terminus-font \
    "

usage ()
{
    echo "USAGE: $(basename $0) [<list of additional packages for basestrap>]"
    echo "INSTALLED PACKAGES:" $INSTALLED_PACKAGES
    echo "SUGGESTED PACKAGES: intel-ucode amd-ucode wpa_supplicant crda wvdial"
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

if ! command -v basestrap > /dev/null
then
    echo "Error: basestrap not found, do you run from the live image?"
    echo
    usage
    exit 1
fi

###############################################################################

print_step "Run basestrap"
basestrap /mnt $INSTALLED_PACKAGES $@

print_step "Run fstabgen"
fstabgen -U /mnt >> /mnt/etc/fstab

###############################################################################

print_step "Copy autoconfig scripts"
AUTOCONFIG_PATH="/mnt/var/tmp/archlinux-autoconfig"
mkdir -p "$AUTOCONFIG_PATH"
cp -rf --preserve=mode -t "$AUTOCONFIG_PATH" ".."

###############################################################################

print_step "Done! Now do 'artix-chroot /mnt' and then continue with the 2-install-chroot.sh"

