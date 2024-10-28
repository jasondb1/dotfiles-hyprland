#!/bin/sh
 perf=$(cat /sys/firmware/acpi/platform_profile)

performance_print() {

	if [ $perf = "performance" ]
		then
		  echo  '{"text":"􀓎", "alt":"Performance", "class":"performance"}'
		else
		  if [ $perf = "balanced" ]
		  then 
			echo  '{"text":"􀐳", "alt":"Balanced", "class":"balanced"}'
		  else  
			echo  '{"text":"􀓐", "alt":"Quiet", "class":"quiet"}'
		fi
	fi
}

performance_toggle() {
    	if [ $perf = "performance" ]
			then
			  #echo  "balanced" |tee /sys/firmware/acpi/platform_profile
			  asusctl profile -P balanced
			else
			  if [ $perf = "balanced" ]
				  then 
					#echo  "quiet" |tee /sys/firmware/acpi/platform_profile\
					asusctl profile -P quiet
				  else  
					#echo  "performance" |tee /sys/firmware/acpi/platform_profile
					asusctl profile -P performance
			  fi
		fi
	
}

case "$1" in
    --toggle)
        performance_toggle
        ;;
    --status)
        performance_print
        ;;
      *)
		echo $"Usage: $0 {--status | --toggle}"
		exit 1
		;;
esac
