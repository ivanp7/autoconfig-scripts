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
install_official_packages gdb strace
install_official_packages screen tmux
install_official_packages neofetch htop glances
install_official_packages pkgfile
pkgfile --update
systemctl enable pkgfile-update.timer
install_official_packages when task pass
install_official_packages openssh sshfs encfs
install_official_packages wget rsync
install_official_packages inetutils gnu-netcat ngrep tcpdump
install_official_packages wol ethtool ifplugd
install_official_packages cpupower usbutils usb_modeswitch
install_official_packages dosfstools ntfs-3g inotify-tools entr
install_official_packages ncdu extundelete trash-cli
install_official_packages unzip p7zip atool
install_official_packages at cronie
systemctl enable --now atd cronie
install_official_packages moreutils jq dialog expect
install_official_packages alsa-utils
install_official_packages beep libcaca fbv mpv
install_official_packages ffmpegthumbnailer poppler
install_official_packages w3m youtube-dl
install_official_packages sdcv
install_official_packages octave

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

