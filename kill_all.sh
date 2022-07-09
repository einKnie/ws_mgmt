#!/usr/bin/env bash

# this script shall kill all windows on the active workspace
# (or a provided workspace name, possibly)

debug=0

# source shared functions
. "$(dirname "$(realpath "$0")")/common.include"

while getopts "n:dh" arg; do
    case $arg in
        n)
            name="$OPTARG"
            ;;
        d)
            debug=1
            set -x
            ;;
        h)
            echo "kill all windows on the focused ws"
            echo "optionally provide ws name with:"
            echo "> $0 -n $wsname"
            echo
            exit 0
            ;;
        *)
            ;;
    esac
done

wsid=$(get_ws_id_by_name_or_not "$name")
wsname=$(get_ws_name_by_id_or_not $wsid)

[ -z "$wsid" ] && { log_journal "workspace \"$name\" not found"; exit 1 ;}

log_journal "preparing to kill all windows on workspace $wsname ($wsid):"
for window in $(get_ws_windows $wsid); do
    wpid=$(xprop -id $window | grep NET_WM_PID | sed -r 's/[^0-9]*//g')
    procname="$(xprop -id $window | grep ^WM_NAME | sed -r 's/[^=]*= //g')"
    wmclass="$(xprop -id $window | grep ^WM_CLASS | sed -r 's/[^,]*, //g')"

    log_journal "    $wmclass: $procname (id $window, pid $wpid)"
    [ $debug -eq 1 ] || kill $wpid
done
