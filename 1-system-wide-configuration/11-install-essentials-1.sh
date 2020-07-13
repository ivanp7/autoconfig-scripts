#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_root

####################################################################

install_official_packages man-db man-pages
install_official_packages base-devel ctags
install_official_packages neovim
install_official_packages fzf
install_official_packages gdb strace
install_official_packages screen tmux
install_official_packages neofetch htop glances powertop
install_official_packages pkgfile
install_official_packages when task pass
install_official_packages openssh sshfs encfs
install_official_packages wget rsync
install_official_packages inetutils gnu-netcat ngrep tcpdump
install_official_packages wol ethtool ifplugd
install_official_packages qemu edk2-ovmf
install_official_packages acpi cpupower usbutils usb_modeswitch
install_official_packages dosfstools ntfs-3g inotify-tools entr
install_official_packages ncdu extundelete trash-cli
install_official_packages unzip unrar p7zip atool
install_official_packages at cronie
install_official_packages jq dialog expect
install_official_packages alsa-utils
install_official_packages beep libcaca fbv mpv
install_official_packages ffmpegthumbnailer poppler
install_official_packages w3m toxic youtube-dl
install_official_packages sdcv
install_official_packages octave

####################################################################

print_message "#### Enabling services ####"

install_and_enable_service cronie
install_and_enable_service atd

####################################################################

print_message "#### Adding pkgfile cronjob ####"

pkgfile --update
crontab -l | { cat; echo '@daily /usr/bin/pkgfile --update'; } | crontab -

####################################################################

print_message "Relinking sh to dash..."
install_official_packages dash

ln -sfT dash /usr/bin/sh
mkdir -p /etc/pacman.d/hooks/
install -Dm 644 $(aux_dir)/dash.hook /etc/pacman.d/hooks/

print_message "Changing shell to zsh..."
install_official_packages zsh zsh-completions zsh-syntax-highlighting

mkdir -p /var/cache/zsh/
install -Dm 644 $(aux_dir)/zsh.hook /etc/pacman.d/hooks/

chsh -s /usr/bin/zsh

####################################################################

finish

