#!/usr/bin/env bash

get_SSID() { SSID=$(iwgetid -r ); }

get_SSID

if [ -z $SSID ]; then
   echo "%{F#77f2f2f2}󰤮"
else  
    echo "󰤨   %{F#77f2f2f2}$SSID "       
fi

