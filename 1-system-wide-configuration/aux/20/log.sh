#!/bin/sh

FILENAME=/var/log/usage-log/$(date +%F)

[ -f "$FILENAME" ] ||
    { dd if=/dev/zero bs=1 count=$((24*60)) | tr '\0' '.' | fold -w 60; echo; } > $FILENAME

HOUR=$(date +%H)
MINUTE=$(date +%M)
sed -i -E "$(($HOUR+1))s/^(.{$MINUTE})./\1#/" $FILENAME

