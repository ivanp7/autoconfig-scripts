#!/bin/sh

cd $(dirname $0)

while true
do
    # wait for TTY switch
    inotifywait -qq -e modify /sys/class/tty/tty0/active
    sleep 0.1
    ./tmux-refresh_op.sh
done

