#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing essentials from official repositories ####"

####################################################################

check_root

####################################################################

print_message "#### Installing manuals ####"

install_official_packages man-db man-pages

print_message "#### Installing shells ####"

install_official_packages dash
install_official_packages zsh zsh-completions zsh-syntax-highlighting

print_message "#### Installing SSH and encryption tools ####"

install_official_packages openssh sshfs encfs

print_message "#### Installing file transfering tools ####"

install_official_packages wget rsync

print_message "#### Installing filesystem management tools ####"

install_official_packages dosfstools ntfs-3g inotify-tools entr
install_official_packages ncdu trash-cli

print_message "#### Installing archives management tools ####"

install_official_packages unzip unrar p7zip atool

print_message "#### Installing hardware management tools ####"

install_official_packages acpi tlp tlp-runit cpupower usbutils usb_modeswitch
install_official_packages wol ethtool

print_message "#### Installing system state monitoring tools ####"

install_official_packages neofetch htop glances powertop

install_official_packages pkgfile

print_message "#### Installing cron and delayed jobs tools ####"

install_official_packages at cronie

print_message "#### Installing basic development, programming and debugging tools ####"

install_official_packages base-devel ctags
install_official_packages gdb strace

install_official_packages inetutils gnu-netcat ngrep tcpdump

print_message "#### Installing auxilliary tools ####"

install_official_packages jq dialog expect

print_message "#### Installing editor ####"

install_official_packages neovim

print_message "#### Installing terminal session tools ####"

install_official_packages screen tmux
install_official_packages fzf ripgrep

print_message "#### Installing working environment tools ####"

install_official_packages when task pass
install_official_packages sdcv octave
install_official_packages w3m toxic

print_message "#### Installing media tools ####"

install_official_packages alsa-utils beep 
install_official_packages mpv 
install_official_packages poppler

print_message "#### Installing miscellaneous stuff ####"

install_official_packages fortune-mod

####################################################################

finish

