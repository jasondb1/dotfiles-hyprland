#!/bin/sh

#Iosevka
#;; 󰁹 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰂃 󰂄 󰂅 󰂆 󰂇 󰂈 󰂉 󰂊 󰂋 󰂌 󰂍 󰂎 󰂏 󰂐 󰂑 󰂚 󰂛 󰂜 󰂝 󰂞 󰂟 󰂠 󰂢 󰂯 󰂰 󰂱 󰂲 󰂳 󰂴 󰃽 󰃾 󰅗 󰅘 󰅙 󰅚 󰅜 󰅝 󰆍 󰍹 󰕾 󰕿 󰖀 󰖁 󰖩 󰖪 󰖭 󰔡 󰔢 󰘚 󰤟 󰤠 󰤡 󰤢 󰤣 󰤤 󰤥 󰤦 󰤧 󰤨 󰤩 󰤪 󰤫 󰤬 󰤭 󰤮 󰤯 
#;; 󰤙  󰤚 󰦴 󰨙 󰨚 󰮂 󰮃 󰯉 󰴙 󰵀 󰵚 󰵛 󰸉 󰸕 󰻏 󱀫 󱈎 󱊡 󱊢 󱊣 󱊤 󱊥 󱊦 󱎒 󱎑 󱎐 󱎏 󱎎 󱎕 󱎖 󱑬 󱑭 󱑮 󱑯 󱑰 󱑱 󱑲 󱑳 󱑴 󱩎 󱩏 󱩐 󱩑 󱩒 󱩓 󱩔 󱩕 󱩖 󰍛 󰖟
#;; 󰇧 󰈔 󰈤 󰈮 󰉕 󰉖 󰈹 󰊗 󰋁 󰋂 󰐥 󰑉 󰒊 󰓓 󰕰 󰘚
#;; 󰛮 󰡁 󰡹 󰀻 󰄘 󰄙 
# 󰋩 󰋯 󰌳 󰌲 󰍬 󰍭 󰍮 󰐗 󰐖 󰎦 󰎩 󰎬 󰎮 󰎰 󰎵 󰎸 󰎻 󰎾 󰒱 󰒔 󰒓 󰓓 󰗖
# 󰂯 󰂲

bluetooth_print() {
    #bluetoothctl | while read -r; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
            #printf '#1'
            #echo "%{T4}󰂯{T-}"
            #echo  "%{T4}%{F#0082fc}󰂯 %{F-}%{T-}"

            devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
            counter=0

            echo "$devices_paired" | while read -r line; do
                device_info=$(bluetoothctl info "$line")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    #device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

                    #if [ $counter -gt 0 ]; then
                        #printf ", %s" "$device_alias"
                    #else
                        #printf " %s" "$device_alias"
                    #fi

                    counter=$((counter + 1))

                    echo  "%{T4}%{F#0082fc}󰂯 %{F-}%{T-}"
                    
                fi
                
                if bluetoothctl show | grep -q "Powered: no"; then
					echo  "%{T4}%{F#3b4252}󰂯 %{F-}%{T-}"
                fi  
            done

            #printf '\n'
        else
			
			#echo ""
            #echo  "%{T4}%{F#3b4252}󰂯 %{F-}%{T-}"
            echo  "%{T4}%{F#3b4252}󰂯 %{F-}%{T-}"
            
        fi
    #done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac
