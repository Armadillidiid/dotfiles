#!/bin/bash
set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <iterations>"
	exit 1
fi

issues=$(gh issue list --state open --json number,title,body,comments)
ralph_commits=$(git log -n 10 --format="%H%n%ad%n%B---" --date=short 2>/dev/null || echo "No commits found")
session_id=""

for ((i = 1; i <= $1; i++)); do
	full_output=""
	run_args=(
		opencode run "$issues Previous RALPH commits: $ralph_commits"
		--file progress.txt ~/.dotfiles/scripts/.local/bin/prompt.md
		--model "github-copilot/gpt-5.3-codex"
		--agent build
		--format json
		--thinking
	)

	if [ -n "$session_id" ]; then
		run_args+=(--session "$session_id")
	fi

	# Stream output (text, thinking, tool calls) and collect text.
	while IFS= read -r line; do
		type=$(jq -r '.type // empty' <<<"$line")
		current_session_id=$(jq -r '.sessionID // empty' <<<"$line")

		if [ -z "$session_id" ] && [ -n "$current_session_id" ]; then
			session_id="$current_session_id"
			echo "Using session: $session_id"
		fi

		if [[ "$type" == "text" ]]; then
			text=$(jq -r '.part.text // empty' <<<"$line")
			if [ -n "$text" ]; then
				echo "$text"
				full_output+="$text"
			fi
		fi

		if [[ "$type" == "reasoning" ]]; then
			reasoning=$(jq -r '.part.text // empty' <<<"$line")
			if [ -n "$reasoning" ]; then
				echo "Thinking: $reasoning"
			fi
		fi

		if [[ "$type" == "tool_use" ]]; then
			tool_name=$(jq -r '.part.tool // empty' <<<"$line")
			tool_status=$(jq -r '.part.state.status // empty' <<<"$line")
			tool_desc=$(jq -r '.part.state.metadata.description // empty' <<<"$line")

			if [ -n "$tool_name" ]; then
				if [ -n "$tool_desc" ]; then
					echo "Tool [$tool_status]: $tool_name - $tool_desc"
				else
					echo "Tool [$tool_status]: $tool_name"
				fi
			fi
		fi
	done < <("${run_args[@]}")

	# Check if complete
	if [[ "$full_output" == *"<promise>COMPLETE</promise>"* ]]; then
		echo "Ralph complete after $i iterations."
		exit 0
	fi
done
