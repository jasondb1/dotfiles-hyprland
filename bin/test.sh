#! /bin/bash

# Function to simulate incoming text (replace with your actual text source)
simulate_incoming_text() {
	echo "here"
    echo "" > /tmp/mypipe
    sleep 1
    echo "First line of incoming text" > /tmp/mypipe
    sleep 0.5
    echo "Second line of incoming text" > /tmp/mypipe
    sleep 0.5
    printf "..." > /tmp/mypipe
    sleep 0.2
        printf "..." > /tmp/mypipe
    sleep 0.2
        printf "..." > /tmp/mypipe
    sleep 0.2
        printf "..." > /tmp/mypipe
    sleep 0.2
        printf "...\n" > /tmp/mypipe
    sleep 0.2
        printf "..." > /tmp/mypipe
    sleep 0.2
        printf "..." > /tmp/mypipe
    sleep 0.2
        printf "...\n" > /tmp/mypipe


    
}

#mkfifo /tmp/pipe

#~ cat /tmp/pipe | yad --title="Real-Time Incoming Text" --height=300 --text-info --editable --update --listen

exec 3<> /tmp/pipe

yad --title="Real-Time Incoming Text" --height=300 --text-info --listen --update< /tmp/pipe &

simulate_incoming_text 

# Continuously feed the incoming text to the YAD window
 #~ simulate_incoming_text | while IFS= read -r line; do
    #~ # Update the YAD window content
	#~ yad --title="Real-Time Incoming Text" --height=300 --text-info --editable --update --listen
	
#~ done 

# Wait for YAD to close
#wait $YAD_PID
