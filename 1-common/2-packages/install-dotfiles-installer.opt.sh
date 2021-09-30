#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install dotfiles installer"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

if [ -z "$AUTOCONFIG_DOTFILES_PLUGINS_SELECTED" ]
then
    DIALOG_FILE="$(mktemp_file dialog_file)"
    HEIGHT=$(tput lines)
    dialog --erase-on-exit --checklist "Select plugins to install" $(($HEIGHT-3)) $(($(tput cols)-6)) $(($HEIGHT-9)) \
        x-dotfiles "X server environment configuration" off \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    AUTOCONFIG_DOTFILES_PLUGINS="$(cat "$DIALOG_FILE")"
    AUTOCONFIG_DOTFILES_PLUGINS_SELECTED=true

    export AUTOCONFIG_DOTFILES_PLUGINS AUTOCONFIG_DOTFILES_PLUGINS_SELECTED
    self_logging
fi

git_clone_and_cd dotfiles "$GIT_URL_PREFIX/dotfiles.git"
echo "Installing dotfiles..."
./install.sh

cd plugins
for plugin in $AUTOCONFIG_DOTFILES_PLUGINS
do
    [ ! -d "$plugin" ] && git clone "$GIT_URL_PREFIX/$plugin.git"
    echo "Installing $plugin..."
    ../install.sh $plugin
done

