#!/usr/bin/env bash

dir="~/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# 󰍺 󰍹 󰶐

# Options
connect="󰍺 Extend Desktop"
disconnect="󰶐 Disconnect Extended Desktop"
mirror="󰍺 Mirror Monitors"
stopmirror="󰶐 Stop Mirroring"

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
options="$connect\n$disconnect\n$mirror\n$stopmirror"

chosen="$(echo -e "$options" | $rofi_command -p "External Monitor" -dmenu -selected-row 0)"
case $chosen in
    $connect)
		#Connect Monitor
		xrandr --output HDMI-1-0 --auto --above eDP-1
		bspc monitor HDMI-1-0 -d I
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &
		polybar -q Secondary -c "$HOME"/.config/polybar/config.ini &
		feh --bg-scale ~/Pictures/Backgrounds/Background.jpg ~/Pictures/Backgrounds/Background.jpg &
        ;;
    $disconnect)
		#Remove Monitor
		xrandr --output HDMI-1-0 --off
		bspc monitor HDMI-1-0 -r
		bspc desktop I -r
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &
		feh --bg-scale ~/Pictures/Backgrounds/Background.jpg &
        ;;
     $mirror)
		#Remove Monitor
		xrandr --output HDMI-1-0 --auto
        ;;
     $stopmirror)
		#Remove Monitor
		xrandr --output HDMI-1-0 --off
        ;;
    
esac
