#!/bin/bash
# Define the path for the toggle variable
TOGGLE_FILE="$HOME/.cache/move_window_toggle"
# Check if the toggle variable exists
if [ -f "$TOGGLE_FILE" ]; then
    # Read the toggle type (normal or special)
    toggle_type=$(cat "$TOGGLE_FILE")
    if [ "$toggle_type" == "special" ]; then
        # If the toggle is for a special workspace, move the currently focused window to the special workspace
        echo "Moving the currently focused window to special workspace $1"
        hyprctl dispatch movetoworkspacesilent special:"$1"
    else
        # If the toggle is for a normal workspace, move the currently focused window to the target workspace
        echo "Moving the currently focused window to workspace $1"
        hyprctl dispatch movetoworkspacesilent "$1"
    fi
    # Remove the toggle file after moving the window
    rm "$TOGGLE_FILE"
else
    # If the toggle is not found, just switch to the workspace
    echo "Switching to workspace $1 without moving the window"
fi
