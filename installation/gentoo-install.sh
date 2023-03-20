#!/bin/sh

MAKE_CONF_USE='
X xinerama fbcon alsa man \
-cjk \
-systemd -gnome -dbus -kde -semantic-desktop -policykit \
-qt5 -qt6 -gtk -motif \
-xemacs -subversion -cvs -clamav -emboss \
-ldap -nas -nntp \
-ios -ipod -aqua -coreaudio -ibm -quicktime -mms \
-a52 -cdinstall -cdr -css -dvd -dvdr -vcd \
-bluetooth -ieee1394 -smartcard \
'

MAKE_CONF_VIDEO_CARDS='intel nouveau' # other: radeon amdgpu
MAKE_CONF_INPUT_DEVICES='libinput -joystick' # other: synaptics

MAKE_CONF_ACCEPT_LICENSE='* -@EULA' # (this is old Gentoo default)

ETC_TIMEZONE='Europe/Minsk'

ETC_LOCALE_GEN='
en_US.UTF-8 UTF-8
ru_RU.UTF-8 UTF-8
'
ETC_ENV_D_02LOCALE='
LANG="en_US.UTF-8"
LC_COLLATE="C.UTF-8"
'

ROOT_PARTITION=$(df --output=source . | tail -1) # autodetect
ROOT_PARTITION_UUID=$(blkid | grep "^$ROOT_PARTITION:" | sed 's/.*\sPARTUUID="//; s/".*//') # autodetect

BOOT_PARTITION=$(fdisk -l | sed '/ EFI System$/!d; s/\s.*//' | head -1) # autodetect
BOOT_PARTITION_UUID=$(blkid | grep "^$BOOT_PARTITION:" | sed 's/.*\sPARTUUID="//; s/".*//') # autodetect

ETC_FSTAB="

# system root directory
PARTUUID=$ROOT_PARTITION_UUID   /       ext4    noatime 0 1

# UEFI boot directory
PARTUUID=$BOOT_PARTITION_UUID   /boot   vfat    defaults,noatime 0 2

# system tmp directory
tmpfs  /tmp                 tmpfs   nosuid,noatime,nodev 0 0

# portage tmp directory
tmpfs  /var/tmp/portage     tmpfs   uid=portage,gid=portage,mode=775,nosuid,noatime,nodev 0 0

"

ETC_HOSTNAME="computer"
ETC_HOSTS="
127.0.0.1 localhost $ETC_HOSTNAME $ETC_HOSTNAME.homenetwork
"

CONSOLE_KEYMAP="ruwin_alt-UTF-8"
CONSOLE_FONT="ruscii_8x16"

INSTALL_INTEL_MICROCODE=true # unset if not using Intel CPU

LINUX_KERNEL_CONFIG= # path to Linux kernel configuration file (if unset, `make menuconfig` will be invoked)

CONFIGURATION_IS_APPROVED= # set to 'yes' to approve

# END OF USER CONFIGURATION SECTION !!!
###############################################################################
###############################################################################

set -e # quit on fail

[ "$CONFIGURATION_IS_APPROVED" = "yes" ] || { echo "Configuration is not approved. Edit the script configuration section."; exit 2; }

cd -- "$(dirname -- "$0")" # go to this script directory
THIS_SCRIPT="$(basename -- "$0")"

check_dir () { [ "$PWD" = "/mnt/gentoo" ]; }
check_dir

change_root () { [ "$PWD" = "/" ] || { check_dir && exec chroot ./ "./$THIS_SCRIPT"; }; } # change root and continue
#change_root

REMOVE_FROM=$((2+$LINENO)); checkpoint () { sed -i "$REMOVE_FROM,/^checkpoint\$/d" "$THIS_SCRIPT"; } # remove lines from $REMOVE_FROM up to checkpoint call
###############################################################################

cp -- "$THIS_SCRIPT" "${THIS_SCRIPT}.orig" # make backup of the original script state
checkpoint

tar xpvf stage3-*.tar.xz --xattrs-include='*.*' --numeric-owner
checkpoint

sed -i '/^COMMON_FLAGS="/ s/"/"-march=native /' ./etc/portage/make.conf
checkpoint

mirrorselect -i -o >> ./etc/portage/make.conf
checkpoint

mkdir -p ./etc/portage/repos.conf
cp -v ./usr/share/portage/config/repos.conf ./etc/portage/repos.conf/gentoo.conf
checkpoint

cp -Lv /etc/resolv.conf ./etc/
checkpoint

mount --types proc /proc ./proc
checkpoint

mount --rbind /sys ./sys
checkpoint

mount --make-rslave ./sys
checkpoint

mount --rbind /dev ./dev
checkpoint

mount --make-rslave ./dev
checkpoint

mount --bind /run ./run
checkpoint

mount --make-slave ./run
checkpoint

# Switch the script into the chroot mode
sed -i 's/^check_dir$/#check_dir/; s/^#change_root$/change_root/' "$THIS_SCRIPT"
checkpoint
change_root
###############################################################################
checkpoint

mount "${BOOT_PARTITION:?No 'EFI System' partition found}" /boot
checkpoint

emerge-webrsync
checkpoint

emerge --verbose --update --deep --newuse @world
checkpoint

cat << _EOF_ >> /etc/portage/make.conf

USE=" \
$MAKE_CONF_USE
"

VIDEO_CARDS="$MAKE_CONF_VIDEO_CARDS"
INPUT_DEVICES="$MAKE_CONF_INPUT_DEVICES"

ACCEPT_LICENSE="$MAKE_CONF_ACCEPT_LICENSE"

_EOF_
checkpoint

emerge app-portage/cpuid2cpuflags
checkpoint

echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/00cpu-flags
checkpoint

echo "${ETC_TIMEZONE:?No timezone specified}" > /etc/timezone
emerge --config sys-libs/timezone-data
checkpoint

echo "${ETC_LOCALE_GEN:?No locales specified}" > /etc/locale.gen
locale-gen
checkpoint

echo "${ETC_ENV_D_02LOCALE:?No default locale specified}" > /etc/env.d/02locale
checkpoint

env-update
checkpoint

emerge sys-kernel/linux-firmware
checkpoint

[ "$INSTALL_INTEL_MICROCODE" ] && emerge sys-firmware/intel-microcode
checkpoint

emerge sys-apps/pciutils
checkpoint

emerge sys-kernel/gentoo-sources
checkpoint

eselect kernel set 1
checkpoint

if [ "$LINUX_KERNEL_CONFIG" ]
then
    cp -- "$LINUX_KERNEL_CONFIG" /usr/src/linux/.config
    cd /usr/src/linux
else
    cd /usr/src/linux
    make menuconfig
fi
checkpoint

make -j$(nproc) && make modules_install && make install
checkpoint

echo "$ETC_FSTAB" >> /etc/fstab
checkpoint

echo "$ETC_HOSTNAME" > /etc/hostname
checkpoint

emerge net-misc/dhcpcd
checkpoint

rc-update add dhcpcd default
checkpoint

echo "$ETC_HOSTS" >> /etc/hosts
checkpoint

echo "$CONSOLE_KEYMAP" | grep -q '[a-zA-Z_-]\+'
sed -i "/^keymap=/ s/=.*/=\"$CONSOLE_KEYMAP\"/" /etc/conf.d/keymaps
checkpoint

echo "$CONSOLE_FONT" | grep -q '[a-zA-Z_-]\+'
sed -i "/^consolefont=/ s/=.*/=\"$CONSOLE_FONT\"/" /etc/conf.d/consolefont
checkpoint

rc-update add consolefont boot
checkpoint

emerge app-admin/sysklogd
checkpoint

rc-update add sysklogd default
checkpoint

emerge sys-process/cronie
checkpoint

rc-update add cronie default
checkpoint

emerge sys-apps/mlocate
checkpoint

emerge net-misc/chrony
checkpoint

rc-update add chronyd default
checkpoint

emerge --verbose sys-boot/grub
checkpoint

passwd
checkpoint

echo "#############################"
echo "# Installation is finished! #"
echo "#############################"

