#!/bin/sh

## MAIN CODE

case $1 in
  --status)
		CUR_TIME=$(date +%s)
		STATUS=$(cat /tmp/waybar_timer)

		if [ $STATUS == "READY" ]; then
			echo  '{"text":"􀐯", "alt":"􀐯"}'
		elif [ $STATUS == "FINISHED" ]; then
			mpv --no-config --no-terminal $HOME/.config/waybar/modules/timer.wav &
			echo "READY" > /tmp/waybar_timer
			echo  '{"text":"􀐯", "alt":"􀐯"}'
			notify-send -u low "Time's Up!"
			#echo " "
			#echo "Finished"
		elif [[ $STATUS > $CUR_TIME ]]; then
			DIFF_SEC=$(( (STATUS - CUR_TIME) ))
			
			SEC=$(($DIFF_SEC%60))
			MIN=$((($DIFF_SEC-$SEC)%3600/60))
			HRS=$((($DIFF_SEC-$MIN*60)/3600))
			#TIME_DIFF="$HRS:$MIN:$SEC";
			TIME_DIFF="$HRS:$MIN";
			#echo "􀐯 " $TIME_DIFF;
			#$Time_Str = printf "􀐯 %02d:%02d:%02d" $HRS $MIN $SEC;
			printf "{\"text\":\"􀐯 %02d:%02d:%02d\", \"alt\":\"􀐯 %02d:%02d\"}" $HRS $MIN $SEC $HRS $MIN;
			#echo $TIME_DIFF;
			#echo "􀐯" $( date -d @$DIFF +%H:%M )
		else
			if [ -f "/tmp/waybar_timer" ]; then
				echo "FINISHED" > /tmp/waybar_timer
				echo  '{"text":" ", "alt":" "}'
				#echo ""
			else
				echo "READY" > /tmp/waybar_timer
				#echo ""
				echo  '{"text":"", "alt":""}'
			fi
		fi
		;;
  --increase)
	STATUS=$(cat /tmp/waybar_timer)
  
    if [ $STATUS == 'READY' ] || [ $STATUS == "FINISHED" ]
    then
		date --date='60 seconds' +%s > /tmp/waybar_timer
	else
		echo "$(( STATUS + 60 ))" > /tmp/waybar_timer
    fi
    ;;
    --decrease)
	STATUS=$(cat /tmp/waybar_timer)
  
    if [ $STATUS != 'READY' ] && [ $STATUS != "FINISHED" ]
    then
		echo "$(( STATUS - 60 ))" > /tmp/waybar_timer
	else
		exit 1
    fi
    ;;
  --cancel)
	echo "READY" > /tmp/waybar_timer
    ;;
  togglepause)
    if timerSet
    then
      if timerPaused
      then
        echo "$(( $(now) + $(secondsLeftWhenPaused) ))" > /tmp/waybar-timer/expiry
        rm -f /tmp/waybar-timer/paused
        printExpiryTime
      else
        secondsLeft > /tmp/waybar-timer/paused
        rm -f /tmp/waybar-timer/expiry
        printPaused
      fi
    else
      exit 1
    fi
    ;;
  *)
    echo "Error"
    ;;
esac
