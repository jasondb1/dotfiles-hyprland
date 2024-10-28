#!/bin/sh

monitor_connected="";

# 󰍺 󰍹 󰶐

monitor_print() {
	if [ $(xrandr | grep "HDMI-1-0 connected" | wc -c) -eq 0 ]
		then
		  echo  "%{T4}%{F#828791}󰶐  %{F-}%{T-}"
		else
		  #if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
		  #then 
			echo "%{T4}%{F#5657f5}󰍺  %{F-}%{T-}"
		fi
}

monitor_status(){
	if [ $(xrandr | grep "HDMI-1-0 connected" | wc -c) -eq 0 ]
		then
			monitor_connected = "false";
		else
			monitor_connected = "true";
	fi
}

monitor_toggle() {
		if [ $(bspc query -M --names | grep 'HDMI-1-0') ]; then

		#Remove Monitor
		xrandr --output HDMI-1-0 --off
		bspc monitor HDMI-1-0 -r
		bspc desktop I -r
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &

		else

		#Connect Monitor
		xrandr --output HDMI-1-0 --auto --above eDP-1
		bspc monitor HDMI-1-0 -d I
		killall -q polybar
		polybar -q top -c "$HOME"/.config/polybar/config.ini &
		polybar -q Secondary -c "$HOME"/.config/polybar/config.ini &
    fi
}

case "$1" in
    --toggle)
        monitor_toggle
        ;;
    --status)
        monitor_print
        ;;
     --print)
        monitor_print
        ;;
      *)
		echo $"Usage: $0 {status | print | toggle}"
		exit 1
		;;
esac
