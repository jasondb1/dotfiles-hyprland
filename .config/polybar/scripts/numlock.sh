#!/bin/sh

if [ $(xset -q | awk '/Num Lock/{print $8}') = "off" ]
then
  echo "%{T4}%{F#828791}󰰒 %{F-}%{T-}"
else
    echo "%{T4}󰰒 %{T-}"
fi
