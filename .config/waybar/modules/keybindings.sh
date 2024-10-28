#! /bin/bash
sed -n "s/^\s*bindsym \(\S*\).*\(#.*\)/\1\t\2/p" ~/.config/sway/config | column -t -s "#" --table-column width=80 | rofi -dmenu -i -no-show-icons -theme $HOME/.config/polybar/scripts/rofi/nord.rasi -width 1500
