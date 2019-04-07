GIT_URL_PREFIX=https://gitlab.com/ivanp7

####################################################################

check_root ()
{
    if [ "$(id -u)" != "0" ]; then
        echo This script must be run under root. Terminating...
        exit 1
    fi
}

check_user ()
{
    if [ "$(id -u)" = "0" ]; then
        echo This script must be run under a non-priviledged user. Terminating...
        exit 1
    fi

    cd /home/shared
}

aux_dir ()
{
    NUM_PREFIX=$(echo "$(basename $0)" | cut -c1-2)
    echo $SCRIPT_DIR/aux/$NUM_PREFIX
}

initcpio_preset ()
{
    basename $(find /etc/mkinitcpio.d/ -type f -name "*.preset" | head -n1) | cut -d'.' -f1
}

print_message ()
{
    echo
    echo $(printf '%0.s-' $(seq 1 $(echo $* | wc -c)))
    echo $*
    echo $(printf '%0.s-' $(seq 1 $(echo $* | wc -c)))
    echo
}

install_official_packages ()
{
    sudo pacman --needed --noconfirm -S "$@"
}

install_packages ()
{
    yay --needed --noconfirm -S "$@"
}

uninstall_packages ()
{
    sudo pacman --noconfirm -R "$@"
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

