#!/bin/bash

pkill -SIGINT wf-recorder
sleep .1
notify-send '  screen cap ended'
# send signal to update monitor
pkill -RTMIN+8 waybar
