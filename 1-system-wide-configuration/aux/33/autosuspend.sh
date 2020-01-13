#!/bin/sh

users_logged_in ()
{
    [ "$(who | cut -d' ' -f1 | sort | uniq | wc -l)" -gt "0" ]
    return
}

connections_on_port ()
{
    [ "$(ss -anp | grep :$1 | grep ESTAB | wc -l)" -gt "0" ]
    return
}

process_active ()
{
    [ "$(pgrep "$1" | wc -l)" -gt "0" ]
    return
}

########################################################################

# Check if the computer is active
check_if_active ()
{
    local SSH_PORT=62222
    users_logged_in || connections_on_port $SSH_PORT || process_active "^tmux"
    return
}

########################################################################

CHECK_INTERVAL=60
CHECKS_BEFORE_SLEEP=10

cd $(dirname $0)

while true
do
    if ! check_if_active
    then
        GOTO_SLEEP="yes"

        for i in $(seq 1 $CHECKS_BEFORE_SLEEP)
        do
            sleep $CHECK_INTERVAL

            if check_if_active
            then
                GOTO_SLEEP="no"
                break
            fi
        done

        if [ "$GOTO_SLEEP" = "yes" ]
        then
            date >> /var/log/autosuspend.log
            ./autosuspend_op.sh
        fi
    fi

    sleep $CHECK_INTERVAL
done

