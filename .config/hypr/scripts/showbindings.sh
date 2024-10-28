#! /bin/bash
sed -n "s/^\s*bind = \([^,]*\), \(\S*\),.*\(#.*\)/\1 \2\t\3/p" ~/.config/hypr/keybinds.conf | column -t -s "#" --table-column name=Key --table-column name=Action,width=80,strictwidth,trunc --table-order Action,Key | rofi -dmenu -i -no-show-icons -theme $HOME/.config/rofi/user/nord.rasi -width 1500
#sed -n "s/^\s*bind = \(\S*\), \(\S*\),.*\(#.*\)/\1 \2\t\3/p" ~/.config/hypr/keybinds.conf | column -t -s "#" --table-column name=Key --table-column name=Action,width=80,strictwidth,trunc --table-order Action,Key | rofi -dmenu -i -no-show-icons -theme $HOME/.config/rofi/user/nord.rasi -width 1500


