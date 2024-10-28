#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="~/.config/polybar/scripts/rofi"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# Options
connect="󰐥 Connect Monitor"
disconnect="󰐥 Disconnect Monitor"

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
options="$connect\n$disconnect"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $connect)
		#Connect Monitor
		xrandr --output HDMI-1-0 --auto --above eDP-1
		bspc monitor HDMI-1-0 -d I
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &
		polybar -q Secondary -c "$HOME"/.config/polybar/config.ini &
        ;;
    $disconnect)
		#Remove Monitor
		xrandr --output HDMI-1-0 --off
		bspc monitor HDMI-1-0 -r
		bspc desktop I -r
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &
        ;;
    
esac
