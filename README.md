# workspace management

collection of scripts to use for workspace management in i3

currently consists of

- _kill\_all.sh_ kill all open windows on a given ws
- _ws\_rename.sh_ rename given ws

All scripts will either operate on a workspace given by name, or on the currently focused workspace, if no name is given.


Use this in combination with a section like the following in i3config
```
set $workspace_mode " [k]ill | re[n]ame | move ↔ "
mode $workspace_mode {
  bindsym k exec --no-startup-id $HOME/scripts/ws_mgmt/kill_all.sh ; mode "default"
  bindsym Left move workspace to output left
  bindsym Right move workspace to output right
  bindsym n exec --no-startup-id $HOME/scripts/ws_mgmt/ws_rename.sh ; mode "default"
  bindsym Return mode "default"
  bindsym Escape mode "default"
  bindsym $mod+s mode "default"
}
bindsym $mod+s mode $workspace_mode
```