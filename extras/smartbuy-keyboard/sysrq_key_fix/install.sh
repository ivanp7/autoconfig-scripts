#!/bin/sh

cd "$(dirname "$0")"
sudo install -m 644 90-my-smartbuy-keyboard-fix.hwdb /usr/lib/udev/hwdb.d/
sudo udevadm --debug hwdb --update

