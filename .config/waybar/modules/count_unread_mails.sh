#!/bin/bash

# Define Thunderbird profile directory (replace this with your actual profile path)
THUNDERBIRD_PROFILE_DIR="$HOME/.thunderbird/3pxq9c9k.default-release/ImapMail/imap.mail.me.com/"
# Initialize unread count
unread_count=0

# Loop through all .msf files in the profile directory
find "$THUNDERBIRD_PROFILE_DIR" -name "*.msf" | while read msf_file; do
		
		unread_in_file=$(grep -oP "(?<=Status:.*\bN\b)" "$msf_file" | wc -l)
    echo "$msf_file: $unread_in_file"
    unread_count=$((unread_count + unread_in_file))
    
done

# Output the total number of unread emails
echo "Total unread emails: $unread_count"
