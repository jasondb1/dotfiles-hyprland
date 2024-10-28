#!/usr/bin/env bash

curStatus=""


case "$1" in
    --up)
        nmcli radio wifi on
        ;;
    --down)
        nmcli radio wifi off
        ;;
    --togmute)
        volMuteStatus
        if [ "$curStatus" = 'yes' ]
        then
            volMute unmute
        else
            volMute mute
        fi
        ;;
    --mute)
        volMute mute
        ;;
    --unmute)
        volMute unmute
        ;;
    --sync)
        volSync
        ;;
    --listen)
        # Listen for changes and immediately create new output for the bar
        # This is faster than having the script on an interval
        listen
        ;;
    --status)
		output
		;;
    *)
        # By default print output for bar
        output
        ;;
esac
