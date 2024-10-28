#!/bin/sh

if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{T1}%{F#66ffffff} %{T-}"
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo "%{T1} %{T-}"
  fi
  echo "%{T1}%{F#2193ff} %{T-}"
fi
