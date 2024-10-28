#!/bin/sh

#;; 󰘚 󰛧 󰜎 󰜰 󰜶 󰜹 󰞭 󰞬 󰞫 󰞪 󰞩 󰞨 󰞧 󰝶 󰝳 󰟃 󰟄 󰟎 󰟜 󰟺 󰠝 󰡳 󰡴 󰡵 󰢿 󰢼 󰢽 󰢾 󰣚 󰤆 󰧗 󰧙 󰧛 󰧝 󰧱 󰧲 󰩈 󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥 

perf=$(cat /sys/firmware/acpi/platform_profile) 

performance_print() {

	if [ $perf = "performance" ]
		then
		  echo  "%{T4}󰑮 %{T-}"
		  #echo  "%{T4}󰡴 %{T-}"
		else
		  if [ $perf = "balanced" ]
		  then 
			echo  "%{T4}󰜎 %{T-}"
			#echo  "%{T4}󰡵 %{T-}"
		  else  
			echo  "%{T4}󰖃 %{T-}"
			#echo  "%{T4}󰡳 %{T-}"
		fi
	fi
}

performance_toggle() {
    	if [ $perf = "performance" ]
			then
			  echo  "balanced" |tee /sys/firmware/acpi/platform_profile
			else
			  if [ $perf = "balanced" ]
				  then 
					echo  "quiet" |tee /sys/firmware/acpi/platform_profile
				  else  
					echo  "performance" |tee /sys/firmware/acpi/platform_profile
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
		echo $"Usage: $0 {status | toggle}"
		exit 1
		;;
esac
