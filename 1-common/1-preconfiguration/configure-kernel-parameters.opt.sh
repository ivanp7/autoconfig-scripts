#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Configure kernel parameters at runtime"
. "./.init.sh"

####################################################################

mkdir -p /etc/sysctl.d/
install -Dm 644 -t /etc/sysctl.d/ "$(aux_dir)/99-sysctl.conf"

sed '/^#/d; /^;/d; /^$/d; s/^\s*//; s/\s*=\s*/=/; s/\s*$//' "$(aux_dir)/99-sysctl.conf" | tr '\n' '\0' | xargs -0 -n1 sysctl

