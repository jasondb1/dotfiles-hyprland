#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
killall -q polybar
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
#polybar bar1 --config=~/.config/polybar/config.ini>&1 | tee -a /tmp/polybar1.log & disown
polybar bar2 --config=~/.config/polybar/config.ini>&1 | tee -a /tmp/polybar2.log & disown
#polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown
echo "Bars launched..."
