#!/usr/bin/env bash

title="Nvidia:"
dir="~/.config/rofi/user"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/nord.rasi"

# Options
integrated="Switch to Integrated mode"
hybrid="Switch to Hybrid mode"
asusdmuxdgpu="Switch to Asus Dmux Gpu"
enable_optimus="Enable Optimus (reboot required)"
enable_discrete="Discrete (reboot required)"

# Variable passed to rofi
options="$integrated,$hybrid,$asusdmuxdgpu,$enable_optimus,$enable_discrete"

chosen="$(echo -e "$options" | $rofi_command -p "$title" -dmenu -selected-row 0)"
case $chosen in
    $integrated)
		supergfxctl -m Integrated
        ;;
    $hybrid)
		supergfxctl -m Hybrid
        ;;
    $asusdmuxdgpu)
		supergfxctl -m AsusMuxDgpu
        ;;
    $enable_optimus)
    	asusctl bios -d 1
        ;;
    $enable_discrete
		asusctl bios -d 0
        ;;
esac
