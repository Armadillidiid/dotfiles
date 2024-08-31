#!/bin/bash

# Define the path for the toggle variable
TOGGLE_FILE="$HOME/.cache/move_window_toggle"
# Check if the toggle file exists
if [ -f "$TOGGLE_FILE" ]; then
	echo "normal" >"$TOGGLE_FILE"
else
	echo "Toggle file does not exist. Not writing to it."
fi

source "$HOME/.config/hypr/scripts/move-toggled-window-to-workspace.sh"

# Execute the hyprctl command
hyprctl dispatch workspace "$1"

# Run the disable-special-workspace script
source "$HOME/.config/hypr/scripts/disable-special-workspace.sh"
