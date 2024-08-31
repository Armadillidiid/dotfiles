#!/bin/bash

FILE_PATH="$HOME/.cache/last_special_workspace"

# Function to disable a special workspace
disable_workspace() {
  local workspace=$1
  echo "Disabling special workspace: $workspace"
  hyprctl dispatch togglespecialworkspace "$workspace"
}

# Function to disable the current special workspace and save its name to a file
monitors_json=$(hyprctl monitors -j)

current_workspace_id=$(hyprctl activeworkspace -j | jq -r '.monitorID')

index=$(echo "$monitors_json" | jq -r --argjson id "$current_workspace_id" 'map(.id) | index($id)')

if [ "$index" == "null" ]; then
  echo "Error: Could not find index for current workspace ID: $current_workspace_id" >&2
  exit 1
fi

current_workspace=$(echo "$monitors_json" | jq -r --arg index "$index" '.[$index|tonumber].specialWorkspace.name' | tr -d '"')

if [ -z "$current_workspace" ]; then
  echo "Error: Could not find special workspace" >&2
  exit 1
fi

if [[ ! "$current_workspace" =~ ^special: ]]; then
  echo "Error: Not a special workspace" >&2
  exit 1
fi

workspace_name=${current_workspace#special:}
echo "$workspace_name" > "$FILE_PATH"
disable_workspace "$workspace_name"

