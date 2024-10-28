#!/usr/bin/env bash

title="Bluetooth:"
dir="~/.config/rofi/user"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# Options
connect=" Enable Bluetooth"
disconnect=" Disable Bluetooth"
restart=" Restart Bluetooth"
manager=" Bluetooth Manager"

# Variable passed to rofi
options="$connect\n$disconnect\n$restart\n$manager"

chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu -selected-row 0)"
case $chosen in
    $connect)
		systemctl start bluetooth
        ;;
    $disconnect)
		systemctl stop bluetooth
        ;;
    $restart)
		systemctl restart bluetooth
        ;;
    $manager)
		blueman-manager
        ;;
    
esac
