#! /bin/bash

browser="brave"

#models=$(ollama list | grep -v 'NAME' |awk '{print $1}')
models=$(ollama list | grep -v 'NAME' | awk '{print $1}' | tr '\n' '\!')
output="Plain Text\!Markdown\!HTML\!LaTeX\!Code Snippets\!Lists\!Tables\!CSV\!XML\!URL\!Ascii Art"
        
#INPUTTEXT=$(yad --text-align=center --text="Please enter your request" --entry --entry-label=""
# --entry-text="Type here" )
#yad --text="You entered: $INPUTTEXT"

#~ INPUTForm=$(yad --Title="User Entry" \
		#~ --form\
		#~ --field="Date::DT" \		
		#~ --field="Model::CB" model1\!model2 \
		#~ --field="Prompt::TXT" \
		#~ )
		
INPUTForm=$(yad \
                --form \
                --field="Model:CB" "$models" \
                --field="Output:CB" "$output" \
                --field="Prompt::TXT" "" \
                --field="Attach:SFL" /home/$USER \
                )
		
model=$(echo "$INPUTForm" | cut -d "|" -f 1 '-')
output=$(echo "$INPUTForm" | cut -d "|" -f 2 '-')
attachment=$(echo "$INPUTForm" | cut -d "|" -f 4 '-')
prompt=$(echo "$INPUTForm" | cut -d "|" -f 3 '-')


if [[ -f $attachment ]]; then
		echo "Model:$model output:$output attach:$attachment Prompt:$prompt "
		output=$(ollama run "$model" "$prompt" < "$attachment")
		
		else
		echo "no attachment"
		prompt+="\n Output should be in $output format."
		echo "Model:$model output:$output Prompt:$prompt "
		output=$(ollama run "$model" "$prompt")
fi


#copy to the clipboard and 
wl-copy "$output"
echo "$output" | yad --text-info --wrap --scroll --file-op --editable "-"
echo "$output" >> /tmp/ollama_chat

#yad --calendar --date-format=%Y-%m-%d


#~ case "$1" in
    #~ --search)
#~ #search internet using 
        #~ ;;
        
    #~ --ollama)
    
    
				#~ ;;
    
    #~ --email)
    
    
				#~ ;;
    #~ *)
        #~ echo $"Usage: $0 {--search | --ollama | --email}"
        #~ ;;
#~ esac
