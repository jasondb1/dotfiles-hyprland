#!/bin/sh

status_print() {

	mode=$(makoctl mode)
	if [ $mode = "default" ]
		then
		  echo  '{"text":"􀋙", "alt":"Notifications enabled", "tooltip": "Notifications Enabled", "class":"enabled"}'
		else
		  echo  '{"text":"􀋝", "alt":"Notifications disabled", "tooltip": "Notifications Disabled", "class":"disabled"}'
	fi
}

notification_toggle() {
	mode=$(makoctl mode)
	if [ $mode = "default" ]
		then
		  notify-send "Notifications Disabled"
		  makoctl set-mode do-not-disturb
		else
		  makoctl set-mode default
		  notify-send "Notifications Enabled"
	fi	
}

case "$1" in
    --toggle)
        notification_toggle
        ;;
    --status)
        status_print
        ;;
      *)
		echo $"Usage: $0 {--status | --toggle}"
		exit 1
		;;
esac
