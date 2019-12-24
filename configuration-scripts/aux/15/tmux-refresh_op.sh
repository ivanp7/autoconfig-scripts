#!/bin/sh

UNUSED_VT=13
TMUX_TMP_WINDOW=yaft-tmp-window
TMUX_TMP_WINDOW_CMD='echo "Switch tty or tmux session."; while true; do sleep 1; done'

TMUX_STATUS_INTERVAL="$(tmux show-options -g status-interval | cut -d' ' -f2)"

list_yaft_clients()
{
    tmux list-clients 2> /dev/null | grep yaft-256color
}

find_client()
{
    if [ -f "/tmp/yaft-refresh-service/$1" ]
    then
        local PTS=$(cat /tmp/yaft-refresh-service/$1)
        if [ -n "$PTS" ]
        then
            local CLIENT=$(list_yaft_clients | grep ^$PTS:)
            echo -n "$CLIENT"
        fi
    fi
}

client_pts()
{
    echo -n "$1" | cut -d':' -f1
}

client_session()
{
    echo -n "$1" | awk '{print $2}'
}

restore_client()
{
    # destroy the empty temporary window if it's there
    if [ "$(tmux display-message -t $(client_session "$1"): -p '#W')" = "$TMUX_TMP_WINDOW" ]
    then
        local session="$(client_session "$1")"

        # enable status bar updating
        tmux set -t "${session}": status-interval "$TMUX_STATUS_INTERVAL"
        tmux set -t "${session}": visual-activity on

        tmux kill-window -t "${session}":"$TMUX_TMP_WINDOW"

        sleep 0.3
    fi

    # refresh screen
    tmux refresh-client -t "$(client_pts "$1")"
}

hide_client()
{
    # switch to the empty temporary window to suppress framebuffer redraws
    if [ "$(tmux display-message -t $(client_session "$1"): -p '#W')" != "$TMUX_TMP_WINDOW" ]
    then
        local session="$(client_session "$1")"

        # disable screen updating
        tmux set -t "${session}": status-interval 0
        tmux set -t "${session}": visual-activity off

        tmux new-window -t ${session}: -n "$TMUX_TMP_WINDOW" "$TMUX_TMP_WINDOW_CMD"
    fi
}

refresh_tty()
{
    # # switch to an unused virtual terminal, wait a little and return
    sleep 0.3
    sudo chvt $UNUSED_VT
    sleep 0.3
    sudo chvt $(echo $1 | tail -c+4) || sudo chvt 1
    # sudo dd if=/dev/zero of=/dev/fb0 2> /dev/null
}

refresh()
{
    # get current tty name
    TTY=$(cat /sys/class/tty/tty0/active)
    # get tmux client under yaft belonging to current tty
    CLIENT=$(find_client $TTY)

    # we're in yaft, restore the active tmux client, hide the other
    if [ -n "$CLIENT" ]
    then
        list_yaft_clients |
            while read client
            do 
                if [ "$(client_session "$client")" != "$(client_session "$CLIENT")" ]
                then hide_client "$client"; fi
            done
        sleep 0.1
        restore_client "$CLIENT"

    # we're on bare tty, hide all yaft tmux clients
    elif [ ! -f "/tmp/yaft-refresh-service/$TTY" ]
    then
        list_yaft_clients |
            while read client
            do 
                hide_client "$client"
            done
        refresh_tty $TTY

    # we're in X, restore all yaft tmux clients
    else
        list_yaft_clients |
            while read client
            do 
                restore_client "$client"
            done
    fi
}

refresh

