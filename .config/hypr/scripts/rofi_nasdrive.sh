#!/usr/bin/env bash

title="NAS Drive:"
dir="~/.config/rofi/user"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# Options
connect="􀩎 Mount NAS Drive"
disconnect="􀩑 Unmount NAS Drive"

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

chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu -selected-row 0)"
case $chosen in
    $connect)
		#Connect Monitor
	kitty mountnas.sh --mount
        ;;
    $disconnect)
		#Remove Monitor
	kitty mountnas.sh --unmount
        ;;
    
esac
