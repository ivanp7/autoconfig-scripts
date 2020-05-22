#!/bin/sh

users_logged_in ()
{
    [ "$(who | cut -d' ' -f1 | sort | uniq | wc -l)" -gt 0 ]
    return
}

connections_on_port ()
{
    [ "$(ss -anp | grep :$1 | grep ESTAB | wc -l)" -gt 0 ]
    return
}

process_active ()
{
    [ "$(pgrep -x $1 | wc -l)" -gt 0 ]
    return
}

########################################################################

SSH_PORT=62222
users_logged_in || connections_on_port $SSH_PORT || process_active tmux || process_active screen

