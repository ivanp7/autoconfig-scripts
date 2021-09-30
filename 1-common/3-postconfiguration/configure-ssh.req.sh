#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure ssh"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

while [ -z "$SSH_PORT" ]
do
    DIALOG_FILE="$(mktemp_file dialog_file)"
    dialog --erase-on-exit --inputbox "Input SSH server port" 8 25 "62222" \
        2> "$DIALOG_FILE" || {
        print_error "Canceled"
        exit
    }

    SSH_PORT="$(cat "$DIALOG_FILE")"

    echo "$SSH_PORT" | grep -qE "^[1-9][0-9]*\$" && [ "$SSH_PORT" -le 65535 ] || SSH_PORT=

    [ -z "$SSH_PORT" ] && continue

    export SSH_PORT
    self_logging
done

groupadd ssh-users
groupadd sftp-users

sed -i "s/^#Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i "s/^#PubkeyAuthentication .*/PubkeyAuthentication yes/" /etc/ssh/sshd_config
sed -i "s/^#PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i "s/^#PermitEmptyPasswords .*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
sed -i "s/^UsePAM .*/UsePAM no/" /etc/ssh/sshd_config
sed -i "s/^#X11Forwarding .*/X11Forwarding yes/" /etc/ssh/sshd_config
sed -i "s/^#X11UseLocalhost .*/X11UseLocalhost yes/" /etc/ssh/sshd_config
sed -i "/^Subsystem.*sftp.*/ s/Subsystem/#Subsystem/" /etc/ssh/sshd_config

! grep -q "\<sftp-users\>" /etc/ssh/sshd_config &&
    cat "$(aux_dir)/sshd_config_tail" | tee -a /etc/ssh/sshd_config

ssh-keygen -A

