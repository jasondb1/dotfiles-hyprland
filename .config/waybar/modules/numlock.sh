#!/bin/sh

if [ $(xset -q | awk '/Num Lock/{print $8}') = "off" ]
then
  #echo "󰰒 "
  echo '{"text": "󰰒 ", "class": "disabled", "tooltip": "Numlock Off"}'
else
    #echo "󰰒 "
    echo '{"text": "󰰒 ", "class": "enabled", "tooltip": "Numlock On"}'
fi
