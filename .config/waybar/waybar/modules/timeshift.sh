#!/bin/sh

case "$1" in
    --create_snapshot)
        sudo timeshift --create --comments "New Install" --tags D --snapshot-device /dev/nvme0n1p5
        notify-send "Snapshot Created"
        ;;
    --status)
        DATE=$(sudo timeshift --list | tail -n 2 | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}')
        NOW=$(date +"%Y-%m-%d")
        DIFF=$(( ($(date -d $NOW +%s) - $(date -d $DATE +%s) )/(60*60*24) ))
        echo $DIFF
        ;;
     --status_json)
        DATE=$(sudo timeshift --list | tail -n 2 | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}')
        NOW=$(date +"%Y-%m-%d")
        DIFF=$(( ($(date -d $NOW +%s) - $(date -d $DATE +%s) )/(60*60*24) ))
        echo '{"text": "$DIFF", "class": "", "tooltip": "Last Backup:$DATE ($DIFF Days)"}'
        ;;
    *)
        exit 1
        
        ;;
esac
