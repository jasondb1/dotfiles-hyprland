#!/usr/bin/env bash

title="Todo List:"
file="~/Documents/test.txt"
dir="~/.config/rofi/user"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# 󰍺 󰍹 󰶐

# Options
add="󰍺 Add Item"
delete="󰶐 Delete Item"
show="Show List"
close="Close"

# Confirmation
confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$add\n$delete\n$show\n$close"

chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu -selected-row 0)"
case $chosen in
    $connect)
		#Connect Monitor
	hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 0x-1080, 1
        ;;
    $disconnect)
		#Remove Monitor
	hyprctl keyword monitor HDMI-A-1, disable
        ;;
     $mainoff)
		#Remove Monitor
		hyprctl dispatch dpms off eDP-2
        ;;
     $mainon)
		#Remove Monitor
		hyprctl dispatch dpms on eDP-2
        ;;
     $mirror)
		#Remove Monitor
		hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 0x0, 1, mirror, eDP-2
        ;;
     $stopmirror)
		#Remove Monitor
		hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 0x-1080, 1
        ;;
    
esac
