#!/bin/bash

# Create a FIFO pipe
fifo_pipe=$(mktemp -u)
mkfifo "$fifo_pipe"

# Start YAD with the FIFO pipe as the input source
yad --text-info --title="Real-time Streaming" --width=600 --height=400 --tail --no-buttons --listen --update < "$fifo_pipe" &

# Simulate streaming by generating 15 JSON fragments with a 0.2-second delay
for i in {1..15}; do
  # Simulate a JSON fragment
  json_data="{\"messages\": [{\"content\": \"Fragment $i\"}], \"done\": false}"

  # Extract the content using jq
  fragment=$(echo "$json_data" | jq -r '.messages[].content')

  # Send the fragment to the FIFO pipe
  echo "$fragment" >> "$fifo_pipe" &
	echo "$i"
  # Wait for 0.2 seconds before the next fragment
  sleep 0.2
done

# Final fragment with "done": true to indicate completion
json_data="{\"messages\": [{\"content\": \"Streaming completed\"}], \"done\": true}"
fragment=$(echo "$json_data" | jq -r '.messages[].content')
echo "$fragment" > "$fifo_pipe"

echo "here"
# Clean up the FIFO pipe
rm "$fifo_pipe"
