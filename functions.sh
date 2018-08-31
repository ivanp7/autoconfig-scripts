#!/bin/bash

GIT_URL_PREFIX=https://gitlab.com/ivanp7

####################################################################

check_root ()
{
    if [[ $EUID != 0 ]]; then
        echo This script must be run under root. Terminating...
        exit 1
    fi
}

check_user ()
{
    if [[ $EUID == 0 ]]; then
        echo This script must be run under a non-priviledged user. Terminating...
        exit 1
    fi
}

initialize ()
{
    check_user
    USERNAME=$(whoami)
    cd ~
    sudo su
    pacman -Syu
}

print_message ()
{
    echo
    echo $(printf '%0.s-' $(seq 1 $(wc -c <<< $*)))
    echo $*
    echo $(printf '%0.s-' $(seq 1 $(wc -c <<< $*)))
    echo
}

run_as_nonroot ()
{
    sudo -H -u $USERNAME "$@"
}

install_official_packages ()
{
    pacman --noconfirm -S "$@"
}

install_packages ()
{
    run_as_nonroot yay --noconfirm -S "$@"
}

finish ()
{
    # read -n1 -rsp $'Done. Press any key to reboot computer now (Ctrl+C to cancel)...\n'
    # print_message "Done. Restarting in 5 seconds. Press Ctrl+C to abort..."
    # sleep 5
    # reboot
    print_message "Done!"
}

####################################################################

