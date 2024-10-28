#! /bin/sh

#xrandr --listmonitors

#if [[ $(xrandr -q | grep 'HDMI21 connected') ]]; then

if [ $(bspc query -M --names | grep 'HDMI-1-0') ]; then

#Remove Monitor
xrandr --output HDMI-1-0 --off
bspc monitor HDMI-1-0 -r
bspc desktop I -r
killall -q polybar
polybar -q top -c "$HOME"/.config/polybar/config.ini &

else

#Connect Monitor
xrandr --output HDMI-1-0 --auto --above eDP-1
bspc monitor HDMI-1-0 -d I
killall -q polybar
polybar -q top -c "$HOME"/.config/polybar/config.ini &
polybar -q Secondary -c "$HOME"/.config/polybar/config.ini &

fi
