#!/bin/sh

users_logged_in ()
{
    [ "$(who | wc -l)" -gt 0 ]
    return
}

connections_on_port ()
{
    [ "$(ss -HOn state established "( sport = $1 )" | wc -l)" -gt 0 ]
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

