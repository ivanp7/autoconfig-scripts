#!/bin/sh

CLHS_PATH="/usr/local/share/HyperSpec"
CLHS_DATA="$CLHS_PATH/Data"
CLHS_MAP="$CLHS_DATA/Map_Sym.txt"

SYMBOL_FILE="$(sed -n '1~2p' "$CLHS_MAP" | tr 'A-Z' 'a-z' | 
    dmenu -p "Common Lisp symbol" -fn "$DEFAULT_FONT" -l 10 -i | 
    xargs -I {} grep -Fix -A 1 '{}' "$CLHS_MAP" | sed '1d')"
[ -n "$SYMBOL_FILE" ] || exit
CLHS_URL="$CLHS_DATA/$SYMBOL_FILE"

tabbed-surf-custom.sh info_clhs "$CLHS_URL"

