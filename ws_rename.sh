#!/usr/bin/env bash

# rename the given workspace

# source shared functions
. "$(dirname "$(realpath "$0")")/common.include"

wsid=$(get_ws_id_by_name_or_not "$1")
wsname="$(get_ws_name_by_id_or_not $wsid)"
sane_wsname="${wsname//\"/}"

[ -z "$wsid" ] && { log_journal "workspace \"$1\" not found"; exit 1 ;}

# get new name from caller
newname="$(rofi -dmenu -lines 0 -p 'new name')"
if [ -z "$newname" ] ;then
  exit 0
fi

# get previous ws number, if any, and keep it
oldnum=${sane_wsname%%[^0-9]*}
if [ -n "$oldnum" ] ;then
  newname="$oldnum $newname"
fi

log_journal "renaming $wsname to \"$newname\""
i3-msg rename workspace "$wsname" to "\"$newname\""
