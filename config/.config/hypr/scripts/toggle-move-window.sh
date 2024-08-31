#!/bin/bash
# Define the path for the toggle variable
TOGGLE_FILE="$HOME/.cache/move_window_toggle"

# Check if the toggle file exists
if [ -f "$TOGGLE_FILE" ]; then
	exit
fi

# Create the toggle file
touch "$TOGGLE_FILE"
echo "Toggle for moving window is set."
notify-send "Toggle for moving window is set."
# Wait for 3 seconds
sleep 3

if [ -f "$TOGGLE_FILE" ]; then
  # Remove the toggle file
	rm "$TOGGLE_FILE"
	echo "Toggle for moving window is cleared."
	notify-send "Toggle for moving window is cleared."
fi
