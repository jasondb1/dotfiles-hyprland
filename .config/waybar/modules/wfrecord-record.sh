#!/bin/bash

#get audio with pactl list sources | grep Name

#wf-recorder --audio --file=$HOME/Videos/$(date -Is).mp4 &> /dev/null &
wf-recorder -c libx264 --audio=alsa_output.pci-0000_00_1f.3.analog-stereo.monitor --file=$HOME/Videos/$(date -Is).mp4 &> /dev/null &
#wf-recorder -c libx264 -x yuv420p -o $(swaymsg -r -t get_outputs  | jq -r '.[] | select(.focused == true).name') -f $HOME/Videos/$(date -Is).mp4 &> /dev/null &
notify-send '  screen cap started'
sleep .1

# send signal to update monitor
pkill -RTMIN+8 waybar

