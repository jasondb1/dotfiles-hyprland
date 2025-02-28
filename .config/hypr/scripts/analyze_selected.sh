#!/bin/bash
# Get the text selected
selection=$(wl-paste --primary --no-newline)

# Copy the selected text to the clipboard
wl-copy "$selection"

notify-send "$selection"
