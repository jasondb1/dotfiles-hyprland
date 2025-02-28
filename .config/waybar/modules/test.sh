#! /bin/bash

	if [[  ! -z $(hyprctl monitors |grep "\sDP-1.*") ]]
	then
			#hyprctl keyword monitor DP-1, disable
			#hyprctl keyword monitor DP-1, 1920x1080@60, 0x-1080, 1
			echo "executed"
	fi
	

