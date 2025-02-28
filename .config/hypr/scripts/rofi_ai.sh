#! /bin/bash

prompt=$1

browser="brave"

#default model
model="llama3.1"
format="Plain Text"
temperature=0.7
output=""
exval=0

rofi_command="rofi -theme $HOME/.config/rofi/config.rasi"

SYSTEM_PROMPTS="$HOME/.config/hypr/scripts/ai_system_prompts"

# Define file where the chat history will be saved
CHAT_HISTORY_FILE="/tmp/chat_history.json"

# Initialize the chat history file
#if [ ! -f "$CHAT_HISTORY_FILE" ]; then
  echo '{"messages": []}' > "$CHAT_HISTORY_FILE"
#fi

# Function to append a new message to the chat history file
append_to_history() {
  local role="$1"
  local content="$2"
  
  # Read the current chat history
  local current_history=$(cat "$CHAT_HISTORY_FILE")

  # Format the new message in JSON format
  new_message=$(jq -n \
    --arg role "$role" \
    --arg content "$content" \
    '{role: $role, content: $content}')

  # Append the new message to the current history
  updated_history=$(echo "$current_history" | jq --argjson new_message "$new_message" '.messages += [$new_message]')

  # Save the updated chat history back to the file
  echo "$updated_history" > "$CHAT_HISTORY_FILE"
}

# Function to send the chat to the Ollama API
send_chat() {
  local model="${model}"
  
  # Read the chat history from the file
  local chat_history=$(cat "$CHAT_HISTORY_FILE")
  
  i=0
  while true;
  do
  i=i+1
  echo $i
  sleep 0.2
  done | yad --progress --no-buttons --pulsate --center --text-align=center --width=400  --size=fit --text="<b><big>Waiting for Ollama to complete...</big></b>" &
  YAD_PID=$!

    opts=$(jq -n \
    --arg temperature "$temperature" \
    '{temperature: $temperature|tonumber } ')

#---------Working Code
    #echo $(echo "$chat_history" | jq --arg model "$model" --argjson options "$opts" '. + {model: $model, stream: false, options: $options}')
   
   response=$(curl --location 'http://localhost:11434/api/chat' \
    --header 'Content-Type: application/json' \
    --data "$(echo "$chat_history" | jq --arg model "$model" --argjson opts "$opts" '. + {model: $model, stream: false, options: $opts}')")
 
 #-------------------
 
 #----------------------Testing
 #Trial 1
 #~ yad --title="Streaming Text" --text-info --width=400 --height=200 --no-buttons --scroll --editable -update -tail | curl -s --location 'http://localhost:11434/api/chat' \
    #~ --header 'Content-Type: application/json' \
    #~ --data "$(echo "$chat_history" | jq --arg model "$model" --argjson opts "$opts" '. + {model: $model, stream: true, options: $opts}')" | while read -r line; do
    
    #~ response=$( echo "$line" | jq -r '.message.content' )
    #~ completed=$( echo "$line" | jq -r '.done' )
    #~ echo -n "$response" 

	#~ done &
	
	#Trial2
	#--working sort of
	
	#~ reponse=""
	
		#~ curl -s --location 'http://localhost:11434/api/chat' \
    #~ --header 'Content-Type: application/json' \
    #~ --data "$(echo "$chat_history" | jq --arg model "$model" --argjson opts "$opts" '. + {model: $model, stream: true, options: $opts}')" | while read -r line; do
    
    #~ response+=$( echo "$line" | jq -r '.message.content' )
    #~ #echo $( echo "$line" | jq -r '.message.content' ) 
    #~ fragment=$( echo "$line" | jq -r '.message.content' )
    #~ #stdbuf -o0 printf "%s" "$fragment"
    #~ stdbuf -o0 -i0 echo -n "$fragment"

	#~ done | yad  \
	#~ --listen --tail --update --text-info \
  #~ --text="Output..." --wrap \
  #~ --width=800 \
  #~ --height=800 \
  #~ --button=yad-cancel

 #---------------------- End Testing
      
    echo $response
    #assistant_reply=$(echo "$response" | jq -r '.message.content')
    output=$(echo "$response" | jq -r '.message.content')
    #output=$response
    #echo "Assistant: $output"
    append_to_history "assistant" "$output"
    
    kill -SIGUSR1 $YAD_PID
}

# Function to escape quotes and special characters for HTML
escape_html() {
    local output="$1"
    
    # Escape double quotes (")
    output=$(echo "$output" | sed 's/"/\\"/g')
    
    # Escape single quotes (')
    output=$(echo "$output" | sed "s/'/\\'/g")
    
    # Escape ampersands (&), less than (<), and greater than (>) for HTML
    output=$(echo "$output" | sed 's/&/\&amp;/g')
    output=$(echo "$output" | sed 's/</\&lt;/g')
    output=$(echo "$output" | sed 's/>/\&gt;/g')

    # Escape newline characters to prevent breaking the HTML
    output=$(echo "$output" | sed 's/\n/\\n/g')

}

# Confirmation Dialog
confirmation() {
  echo -e "yes\nno" | $rofi_command -dmenu -selected-row 1 -no-fixed-num-lines
}

read_model() {
	
		name=$( cat $SYSTEM_PROMPTS | grep "$choice" | cut -d'|' -f1 )
		model=$( cat $SYSTEM_PROMPTS | grep "$choice" | cut -d'|' -f2 )
		temperature=$( cat $SYSTEM_PROMPTS | grep "$choice" | cut -d'|' -f3 )
		system=$( cat $SYSTEM_PROMPTS | grep "$choice" | cut -d'|' -f4 )
		prompt=$( cat $SYSTEM_PROMPTS | grep "$choice" | cut -d'|' -f5 )
		
}

display_prompt() {
	
	#echo "$prompt"
	
	#include model?
	input=$(yad --title"rofi_ai.sh" --focus-field=3 --width=800 --height=800 --scroll --text="${name}: ${model}" \
	--form \
	--field="System Role:${system}:LBL" "" \
	--field="----------------------------------------------------------------------------:LBL" "" \
	--field="Prompt:TXT" "${prompt}" \
	--form --field="Folder List:SFL" "" \
	--button="Quit":1 --button="Send":0 \
	)
	exval=$?
	
	if [[ "$exval" == 1 ]]; then 
		exit 1 
	fi
	#echo $input
	
	userinput=$( echo $input | cut -d'|' -f3)
	FILE=$( echo $input | cut -d'|' -f4)
	
	if [ ! -f "$FILE" ]; then
			FILE=""
	else
			userinput+="\nFile:$FILE"
	fi

	echo $userinput
	
}

display_output () {
	
	#output=escape_html $output 
	#TODO validate html output
	
	input=$(yad --quoted-output --button="Save":3 --button="E-mail":2 --button="Quit":1 --button="Send":0 --focus-field=1 --width=800 --height=800 --scroll \
	--form \
	--field="Prompt" "" \
	--field="Output:TXT" "${output}" \
	--form --field="Attach File:SFL" "" \
	)
	exval=$?
	
	echo $input
	
	userinput=$( echo $input | cut -d'|' -f1)
	FILE=$( echo $input | cut -d'|' -f2)
	
	if [ ! -f "$FILE" ]; then
			FILE=""
	else
			userinput+="\nFile:$FILE"
	fi

	echo $userinput
	
}

outputoptions="Plain Text\!Markdown\!HTML\!LaTeX\!Code Snippets\!Lists\!Tables\!CSV\!XML\!URL\!Ascii Art"



#Ask user for type of prompt
options="General Chat\n"
options+=$( cat $SYSTEM_PROMPTS | cut -d'|' -f1 | sort )
options+="\n--------\nSummarize\nAdd Prompt\nEdit Prompt\nDelete Prompt\n"
choice="$(echo -e "$options" | rofi -config $HOME/.config/rofi/config.rasi -p "Please Select" -dmenu -selected-row 0)"
#echo $choice

case $choice in
	"General Chat")
		system="Multifaceted conversational interface providing information and assistance on various topics. Output Format:${format} unless otherwise specified."
		name="General Chat Bot"
		append_to_history "system" "$system"
	;;
	
	"Summarize")
		system="Role: You are an analyst providing a summary to the given input. Goal: Your goal is to summarize the given file in 300 words or less unless otherwise specified. Call out relevant details in point form."
		append_to_history "system" "$system"
		
	;;
	
	"Add Prompt")
	
	#TODO: validate to ensure Name was entered
	
		#list models
		models=$(ollama list | grep -v 'NAME' |awk '{print $1}' | tr "\n" "!" )
		
		userinput=$(yad --scroll --width=800 --height=800 \
		--form \
		--field="Name" "MyName" \
		--field="Model:CB" "${models}" \
		--field="Temperature:NUM" "${temperature}"!0..2!0.1!1 \
		--field="System Template" "" \
		--field="<b>User Prompt Template</b>:TXT" "Role: Your area a general chatbot. Goal: Your goal is to provide the best response possible in ${format} unless prompted otherwise." )
		
		echo $userinput

		echo $userinput >>$SYSTEM_PROMPTS
		exit 1
	;;
	
		"Delete Prompt")

		options=$( cat $SYSTEM_PROMPTS | cut -d'|' -f1 )
		choice="$(echo -e "$options" | $rofi_command -p "Please Select Prompt To Remove" -dmenu -selected-row 0)"
		
		confirm=$(confirmation &)

			case $confirm in
				yes)
				echo "remove: $choice"
					grep -v "$choice" $SYSTEM_PROMPTS > /tmp/tmp_prompt
					cat /tmp/tmp_prompt > $SYSTEM_PROMPTS
					exit 1
					;;

				no) exit 1 ;;
			esac

		echo "exiting"
		#echo $userinput >> $SYSTEM_PROMPTS
		exit 1
	;;
	
	"Edit Prompt")

		options=$( cat $SYSTEM_PROMPTS | cut -d'|' -f1 )
		choice="$(echo -e "$options" | $rofi_command -p "Please Select Prompt To Edit" -dmenu -selected-row 0)"
		echo $choice
		
		#list models
		models=$(ollama list | grep -v 'NAME' |awk '{print $1}' | tr "\n" "!" )
		read_model "$choice"
		
#		--field="Temperature:SCL" 0\!0..2\!0.1\!0.8 \		
		userinput=$(yad --scroll --width=800 --height=800 \
		--form \
		--field="Name" "${name}" \
		--field="Model:CB" "${models}" \
		--field="Temperature:NUM" "${temperature}"!0..2!0.1!1 \
		--field="System" "${system}" \
		--field="<b>System Prompt</b>:TXT" "${prompt}" )
		
		#confirmation
		confirm=$(confirmation &)

			case $confirm in
				yes)
				echo "edit: $choice"
					grep -v "$choice" $SYSTEM_PROMPTS > /tmp/tmp_prompt
					echo $userinput >> /tmp/tmp_prompt
					cat /tmp/tmp_prompt > $SYSTEM_PROMPTS
					exit 1
					;;

				no) exit 1 ;;
			esac

		echo "exiting"
		#echo $userinput >> $SYSTEM_PROMPTS
		exit 1
	;;
	
	*)
	
		if [[ -z "$choice" ]]; then
			echo "No model selected. Exiting"
			exit 1
		fi

		read_model "$choice"
		append_to_history "system" "$system"
		
	;;
esac


display_prompt

prompt="$userinput"

while [[ $exval == 0 ]] 
do

#echo "prompt: $prompt"
# Append the user's message to the chat history and run chat
append_to_history "user" "$prompt"
send_chat

#copy to the clipboard
wl-copy "$output"

display_output

		if [[ "$exval" == 2 ]]; then
			echo "email"
			#xdg-email [--utf8] [--cc address] [--bcc address] [--subject text] [--body text
		#	] [--attach file] [ mailto-uri | address(es) ]
			exit 1
			elif [[ "exval" == 3 ]]; then
				##TODO implement save dialogue
				echo $output $HOME/Downloads/saved.md
				echo "file saved to ~/Downloads/saved.md"
		fi

#echo $userinput
prompt=$( echo "$userinput" | cut -d'|' -f1 )

done
