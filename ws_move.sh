#!/usr/bin/env bash

# move the focused ws to the other display
# - get focused ws
# - get ws's display
# - move ws to other display

# note: this works, but there's builtin i3 methods to do that as well.
# so, it is not used.


# source shared functions
. "$(dirname "$(realpath "$0")")/common.include"

wsid=$(get_ws_id_by_name_or_not "$1")
wsname=$(get_ws_name_by_id_or_not $wsid)

[ -z "$wsid" ] && { log_journal "workspace \"$1\" not found"; exit 1 ;}

display="$(get_ws_output $wsid)"

if [ "$display" == "DP-3" ]; then
    log_journal "moving ws \"$wsname\" to display DP-5"
    i3-msg move workspace "$wsname" to output "DP-5"
else
    log_journal "moving ws \"$wsname\" to display DP-3"
    i3-msg move workspace "$wsname" to output "DP-3"
fi
