#!/bin/bash

# Define file where the chat history will be saved
CHAT_HISTORY_FILE="/tmp/chat_history.json"

# Initialize the chat history file if it doesn't exist
if [ ! -f "$CHAT_HISTORY_FILE" ]; then
  echo '{"messages": []}' > "$CHAT_HISTORY_FILE"
fi

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
  local model="$1"
  
  # Read the chat history from the file
  local chat_history=$(cat "$CHAT_HISTORY_FILE")

  # Send the request to Ollama API using curl
  response=$(curl --location 'http://localhost:11434/api/chat' \
    --header 'Content-Type: application/json' \
    --data "$(echo "$chat_history" | jq --arg model "$model" '. + {model: $model, stream: false}')")
    
    echo $response
    
    assistant_reply=$(echo "$response" | jq -r '.message.content')
    echo "Assistant: $assistant_reply"
    append_to_history "assistant" "$assistant_reply"

  #~ # Check if the response is valid
  #~ if [[ "$response" == *"choices"* ]]; then
    #~ # Get the assistant's response from the API response
    #~ #assistant_reply=$(echo "$response" | jq -r '.choices[0].message.content')
    #~ assistant_reply$(echo "$response" | jq -r '.message.content')
    
    #~ # Append the assistant's response to the chat history
    #~ append_to_history "assistant" "$assistant_reply"

    #~ # Output the assistant's response
    #~ echo "Assistant: $assistant_reply"
  #~ else
    #~ echo "Error: Invalid response from API"
    #~ echo "Response: $response"
  #~ fi
}

# Function to handle user input
user_input() {
  echo "Enter your message: "
  read user_message

  # Append the user's message to the chat history
  append_to_history "user" "$user_message"

  # Send the chat to the API and get the response
  send_chat "llama3.1" # Specify the llama3.1 model here
}

# Main loop to keep the conversation going
while true; do
  user_input
done
