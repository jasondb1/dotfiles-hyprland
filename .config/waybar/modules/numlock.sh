#!/bin/sh



#if [ $(xset -q | awk '/Num Lock/{print $8}') = "off" ]
if [[ $(cat /sys/class/leds/input3::numlock/brightness) ==  '0' ]]
then
  #echo "󰰒 "
  echo '{"text": "󰰒 ", "class": "disabled", "tooltip": "Numlock Off"}'
else
    #echo "󰰒 "
    echo '{"text": "󰰒 ", "class": "enabled", "tooltip": "Numlock On"}'
fi
