#!/bin/sh

users_logged_in ()
{
    [ "$(who | wc -l)" -gt 0 ]
}

connections_on_port ()
{
    [ "$(ss -HOn state established "( sport = $1 )" | wc -l)" -gt 0 ]
}

process_active ()
{
    [ "$(pgrep -x $1 | wc -l)" -gt 0 ]
}

########################################################################

users_logged_in || connections_on_port 62222 || process_active tmux

