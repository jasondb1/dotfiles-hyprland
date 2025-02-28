#!/usr/bin/env bash

title="External Monitor:"
dir="~/.config/rofi/user"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $HOME/.config/rofi/config.rasi"

# 󰍺 󰍹 󰶐

# Options
connect="󰍺 Connect/Reset External Desktop"
disconnect="󰶐 Disconnect Extended Desktop"
mainoff="󰶐 Main Display Off"
mainon="󰍹 Main Display On"
mirror="󰍺 Mirror Monitors"
stopmirror="󰶐 Stop Mirroring"
reset="󰍺 Reset External"
threemonitor="󰍺 3 Monitor Setup"

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
options="$connect\n$disconnect\n$mirror\n$stopmirror\n$threemonitor\n$mainoff\n$mainon"
chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu -selected-row 0)"

case $chosen in
    $connect)
		#Connect Monitor
	hyprctl keyword monitor HDMI-A-1, disable
	#sleep 2
	hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 0x-1080, 1
	
	if [[ ! -z $(hyprctl monitors |grep "\sDP-1.*") ]]
	then
			hyprctl keyword monitor DP-1, disable
			#sleep 2
			hyprctl keyword monitor DP-1, 1920x1080@60, 0x-1080, 1
	fi
        ;;
    $disconnect)
		#Remove Monitor
	hyprctl keyword monitor HDMI-A-1, disable
	hyprctl keyword monitor DP-1, disable
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
		hyprctl keyword monitor DP-1, 1920x1080@60, 0x0, 1, mirror, eDP-2
        ;;
     $stopmirror)
		#Remove Monitor
		hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 0x-1080, 1
		hyprctl keyword monitor DP-1, 1920x1080@60, 0x-1080, 1
        ;;
    $threemonitor)
				hyprctl keyword monitor HDMI-A-1, disable
	    	hyprctl keyword monitor DP-1, disable
        
        #sleep 2
        hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 1920x-1080, 1
    		hyprctl keyword monitor DP-1, 1920x1080@60, 0x-1080, 1
        ;;
        
    
esac
