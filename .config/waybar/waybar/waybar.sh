#!/usr/bin/env sh

terminate() {
# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

}

case "$1" in
    --kill)
        terminate
        echo 0 > ~/.config/waybar/state
        ;;
    --top)
		terminate
		echo 0 > ~/.config/waybar/state
        waybar -c ~/.config/waybar/config &
        ;;
     --top_bottom)
		terminate
		echo 1 > ~/.config/waybar/state
        waybar -c ~/.config/waybar/config_top_bot &
        ;;
      --toggle)
		terminate
		state=$(cat ~/.config/waybar/state)
		if [ $state -eq 1 ]
		then
			echo 0 > ~/.config/waybar/state
			waybar -c ~/.config/waybar/config_top &
		else
			echo 1 > ~/.config/waybar/state
			waybar -c ~/.config/waybar/config_top_bot &
		fi
        ;;
      --help)
		echo $"Usage: $0 {--help | --kill | --toggle | --top | --top_bottom}"
		exit 1
		;;
	   *)
			terminate
			echo 0 > ~/.config/waybar/state
			waybar -c ~/.config/waybar/config &
        ;;
esac
