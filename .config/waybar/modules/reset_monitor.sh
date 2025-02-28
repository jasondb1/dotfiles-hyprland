#! /bin/sh
	hyprctl keyword monitor HDMI-A-1, disable
	hyprctl keyword monitor DP-1, disable
	sleep 2
  hyprctl keyword monitor HDMI-A-1, 1920x1080@60, 1920x-1080, 1
	hyprctl keyword monitor DP-1, 1920x1080@60, 0x-1080, 1
	notify-send "Welcome back to your desktop!"
