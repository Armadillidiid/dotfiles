#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <iterations>"
	exit 1
fi

issues=$(gh issue list --state open --json number,title,body,comments)

for ((i = 1; i <= $1; i++)); do
	full_output=""

	# Stream JSON output and collect text only
	while IFS= read -r line; do
		type=$(echo "$line" | jq -r '.type // empty')

		if [[ "$type" == "text" ]]; then
			text=$(echo "$line" | jq -r '.part.text // empty')
			echo "$text"
			full_output+="$text"
		fi
	done < <(opencode run "$issues" \
		--file progress.txt ~/.dotfiles/scripts/.local/bin/prompt.md \
		--model "github-copilot/claude-sonnet-4.5" \
		--agent build \
		--format json)

	# Check if complete
	if [[ "$full_output" == *"<promise>COMPLETE</promise>"* ]]; then
		echo "Ralph complete after $i iterations."
		exit 0
	fi
done

