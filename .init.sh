if [ "$(id -u)" -ne 0 ]; then
    echo This script must be run under root. Terminating...
    exit 1
fi

###############################################################################

GIT_URL_PREFIX="https://github.com/ivanp7"

###############################################################################

print_custom_message ()
{
    local CHAR="$1"
    shift 1

    echo
    echo $(printf "%0.s$CHAR" $(seq 1 $(echo $* | wc -c)))
    echo $*
    echo $(printf "%0.s$CHAR" $(seq 1 $(echo $* | wc -c)))
    echo
}

print_message ()
{
    print_custom_message '-' "$@"
}

print_error ()
{
    print_custom_message '!' "$@"
}

###############################################################################

aux_dir ()
{
    echo "$SCRIPT_DIR/.aux/$SCRIPT_NAME"
}

mktemp_dir_and_cd ()
{
    cd -- "$(sudo -u autoconfig mktemp -d -p /tmp ${1}.XXXXXX)"
}

mktemp_file ()
{
    sudo -u autoconfig mktemp -p /tmp ${1}.XXXXXX
}

###############################################################################

AUR_HELPER=yay

choose_packages_and_start_self_logging ()
{
    [ -n "$AUTOCONFIG_CHOSEN_PACKAGES" ] && return

    local DIALOG_FILE="$(mktemp_file dialog_file)"
    local HEIGHT=$(tput lines)
    dialog --erase-on-exit --checklist "Select packages to install" $(($HEIGHT-3)) $(($(tput cols)-6)) $(($HEIGHT-9)) \
        "$@" \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    AUTOCONFIG_CHOSEN_PACKAGES="$(cat "$DIALOG_FILE")"
    [ -z "$AUTOCONFIG_CHOSEN_PACKAGES" ] && exit

    export AUTOCONFIG_CHOSEN_PACKAGES
    self_logging
}

install_packages ()
{
    [ "$#" -gt 0 ] && {
        mktemp_dir_and_cd yay
        export HOME="$PWD"
        sudo --preserve-env=HOME -u autoconfig $AUR_HELPER --needed --noconfirm -S "$@"
    }
}

uninstall_packages ()
{
    [ "$#" -gt 0 ] && pacman --noconfirm -Rns "$@"
}

check_packages ()
{
    for p in $@
    do pacman -Qi "$p" > /dev/null 2>&1 || return 1
    done
}

find_package ()
{
    pacman -Qi "$1" | grep '^Name\s*:' | sed -E 's/.*:\s*//'
}

git_clone_and_cd ()
{
    local DIR="$1"
    local URL="$2"

    mktemp_dir_and_cd "$DIR"
    sudo -u autoconfig git clone "$URL" "$DIR"
    cd -- "$DIR"
}

download_and_extract_source ()
{
    export HOME="$PWD"
    sudo --preserve-env=HOME -u autoconfig makepkg --noconfirm -o
}

build_and_install_package ()
{
    export HOME="$PWD"
    sudo --preserve-env=HOME -u autoconfig makepkg --noconfirm -Lefsri
}

install_pacman_hook ()
{
    mkdir -p /etc/pacman.d/hooks
    install -Dm 644 -t /etc/pacman.d/hooks/ "$(aux_dir)/$1.hook"
}

###############################################################################

SERVICES_DIRECTORY="/etc/runit/sv"
SERVICES_RUN_DIRECTORY="/run/runit/service"
SERVICES_LOG_DIRECTORY="/var/log/runit"

install_service ()
{
    SERVICE_MODE="$1"
    SERVICE_FILE="$2"

    [ ! -f "$SERVICE_FILE" ] && return 1

    local NAME="$(basename "$SERVICE_FILE")"
    local DIR="$SERVICES_DIRECTORY/$NAME"
    mkdir -p -- "$DIR"

    install -Dm 754 -T "$SERVICE_FILE" "$DIR/run"
    case "$SERVICE_MODE" in *down*) touch -- "$DIR/down" ;; esac
    case "$SERVICE_MODE" in
        *log*)
            mkdir -p -- "$SERVICES_LOG_DIRECTORY/$NAME"
            mkdir -p -- "$DIR/log"
            echo '#!/bin/sh' > "$DIR/log/run"
            echo "svlogd -tt \"$SERVICES_LOG_DIRECTORY/$NAME\"" >> "$DIR/log/run"
            chmod 754 "$DIR/log/run"
            ;;
    esac
}

enable_service ()
{
    [ -d "$SERVICES_RUN_DIRECTORY" -a -d "$SERVICES_DIRECTORY/$1" ] &&
        ln -s -t "$SERVICES_RUN_DIRECTORY" "$SERVICES_DIRECTORY/$1"
}

check_service ()
{
    [ -d "$SERVICES_DIRECTORY/$1" ]
}

###############################################################################

add_cronjob ()
{
    crontab -l | grep -q "$2" && return 1
    crontab -l | { cat; echo "$1"; } | crontab -
}

###############################################################################

INIT_SCRIPTS_DIRECTORY="/usr/local/bin/startup-init"

install_init_script ()
{
    check_service startup-init && install -Dm 755 -t "$INIT_SCRIPTS_DIRECTORY" "$1"
}

###############################################################################

install_keymap ()
{
    check_service startup-init && [ -x "$INIT_SCRIPTS_DIRECTORY/console-keymap.sh" ] || return 1

    local MAP_FILE="/usr/local/share/kbd/keymaps/$(basename "$1")"
    { dumpkeys | head -1; cat "$1"; } > "$MAP_FILE"
    chmod 644 "$MAP_FILE"
}

###############################################################################

self_logging ()
{
    export AUTOCONFIG_SELF_LOGGING=enabled

    export AUTOCONFIG_LOG_DIR="/tmp/autoconfig-logs"
    mkdir -p "$AUTOCONFIG_LOG_DIR" || {
        print_error "Cannot create log directory"
        exit 1
    }
    chmod 777 "$AUTOCONFIG_LOG_DIR" 2> /dev/null

    AUTOCONFIG_LOG_FILE="$(mktemp -p "$AUTOCONFIG_LOG_DIR" "$(basename "$0").log.XXXXXX")" || {
        print_error "Cannot create log file"
        exit 1
    }
    chmod 644 "$AUTOCONFIG_LOG_FILE"

    mispipe "$SCRIPT_DIR/$SCRIPT_NAME 2>&1" "tee \"$AUTOCONFIG_LOG_FILE\""
    exit $?
}

###############################################################################

script_finish ()
{
    local CODE=$?
    print_custom_message '=' "Execution finished with code = $CODE"
    return $CODE
}

script_interrupt ()
{
    local CODE=$?
    print_custom_message '=' "Execution interrupted with signal = $(($CODE - 128))"
    return $CODE
}

###############################################################################

[ -z "$AUTOCONFIG_SELF_LOGGING" ] && self_logging || {
    [ "$AUTOCONFIG_SELF_LOGGING" = "enabled" ] && {
        trap "script_finish" EXIT
        trap "script_interrupt" INT TERM
    }
}

print_custom_message '=' "$SCRIPT_TITLE"

