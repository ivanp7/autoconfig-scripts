GIT_URL_PREFIX=https://github.com/ivanp7
SHARED_DIRECTORY=/usr/local/etc/shared
SERVICES_DIRECTORY=/etc/runit/sv
SERVICES_RUN_DIRECTORY=/run/runit/service
SERVICES_LOG_DIRECTORY=/var/log/runit

###############################################################################

# enable self-logging
[ -z "$LOGGING" ] && { 
    export LOGGING=yes
    mispipe "$0 2>&1" "tee \"$(basename "$0").log\""
    exit $?
}

###############################################################################

check_root ()
{
    if [ "$(id -u)" != "0" ]; then
        echo This script must be run under root. Terminating...
        exit 1
    fi

    cd /
}

check_user ()
{
    if [ "$(id -u)" = "0" ]; then
        echo This script must be run under a non-priviledged user. Terminating...
        exit 1
    fi

    cd $SHARED_DIRECTORY
}

aux_dir ()
{
    echo "$(realpath "$ROOT_DIR/.aux/$(basename "$0")")"
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
    sudo pacman --noconfirm -Rns "$@"
}

enable_service ()
{
    sudo ln -s -t $SERVICES_RUN_DIRECTORY $SERVICES_DIRECTORY/$1
}

install_and_enable_service ()
{
    install -Dm 754 -o root -g root -T "$(aux_dir)/$1.service" $SERVICES_DIRECTORY/$1/run
    case "$2" in *down*) touch $SERVICES_DIRECTORY/$1/down ;; esac

    case "$2" in 
        *log*)
            mkdir $SERVICES_DIRECTORY/$1/log
            echo '#!/bin/sh' > $SERVICES_DIRECTORY/$1/log/run
            echo "svlogd -tt $SERVICES_LOG_DIRECTORY/$1" >> $SERVICES_DIRECTORY/$1/log/run
            chmod 754 $SERVICES_DIRECTORY/$1/log/run
            mkdir -p $SERVICES_LOG_DIRECTORY/$1
            ;;
    esac

    enable_service $1
}

add_cronjob ()
{
    crontab -l | { cat; echo "$@"; } | crontab -
}

install_init_script ()
{
    install -m 755 $1 /usr/local/bin/startup-init/
}

install_keymap ()
{
    local MAP_FILE=/usr/local/share/kbd/keymaps/$(basename $1)
    { dumpkeys | head -1; cat $1; } > $MAP_FILE
    chmod 644 $MAP_FILE
}

clone_git_repo_and_cd ()
{
    local DIR=$1
    local URL=$2

    cd /tmp
    if [ -d "$DIR" ]
    then 
        cd "$DIR"
        rm -f *.pkg.tar.*
        git pull
    else 
        git clone $URL
        cd "$DIR"
    fi
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

