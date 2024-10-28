#!/bin/sh

#;; 󰘚 󰛧 󰜎 󰜰 󰜶 󰜹 󰞭 󰞬 󰞫 󰞪 󰞩 󰞨 󰞧 󰝶 󰝳 󰟃 󰟄 󰟎 󰟜 󰟺 󰠝 󰡳 󰡴 󰡵 󰢿 󰢼 󰢽 󰢾 󰣚 󰤆 󰧗 󰧙 󰧛 󰧝 󰧱 󰧲 󰩈 󰪞 󰪟 󰪠 󰪡 󰪢 󰪣 󰪤 󰪥 

perf=$(system76-power profile | grep Power | awk '{print $3}') 

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
    	if [ $perf = "Performance" ]
			then
			  system76-power profile balanced
			else
			  if [ $perf = "Balanced" ]
				  then 
					system76-power profile battery
				  else  
					system76-power profile performance
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
