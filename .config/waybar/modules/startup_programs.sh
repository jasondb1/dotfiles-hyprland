#! /bin/sh


hyprctl dispatch workspace 1
hyprctl dispatch exec kitty
sleep 0.5
hyprctl dispatch workspace 3
hyprctl dispatch exec thunderbird
sleep 0.5
hyprctl dispatch workspace 4
hyprctl dispatch exec brave
sleep 0.5
hyprctl dispatch exec workspace 9
#hyprctl dispatch togglespecialworkspace magic,show
hyprctl dispatch exec obsidian
sleep 0.5
#hyprctl dispatch togglespecialworkspace magic,hide
hyprctl dispatch movetoworkspacesilent "special:magic,class:(.*obsidian.*)"
