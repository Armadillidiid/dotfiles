#!/bin/bash
set -e

usage() {
	echo "Usage: $0 <iterations> [--session[=SESSION_ID]]"
	echo ""
	echo "Examples:"
	echo "  $0 5"
	echo "  $0 5 --session"
	echo "  $0 5 --session=abc123"
	echo "  $0 5 --session abc123"
}

iterations=""
use_session="false"
session_id=""

while [[ $# -gt 0 ]]; do
	case "$1" in
	-h | --help)
		usage
		exit 0
		;;
	--session)
		use_session="true"
		if [[ -n "${2:-}" && "${2:0:2}" != "--" ]]; then
			session_id="$2"
			shift
		fi
		;;
	--session=*)
		use_session="true"
		session_id="${1#*=}"
		;;
	*)
		if [[ -z "$iterations" ]]; then
			iterations="$1"
		else
			echo "Unknown argument: $1"
			usage
			exit 1
		fi
		;;
	esac
	shift
done

if [[ -z "$iterations" || ! "$iterations" =~ ^[0-9]+$ || "$iterations" -le 0 ]]; then
	echo "iterations must be a positive integer"
	usage
	exit 1
fi

issues=$(gh issue list --state open --json number,title,body,comments)
ralph_commits=$(git log -n 10 --format="%H%n%ad%n%B---" --date=short 2>/dev/null || echo "No commits found")

if [[ "$use_session" == "true" && -n "$session_id" ]]; then
	echo "Using provided session: $session_id"
fi

for ((i = 1; i <= iterations; i++)); do
	full_output=""
	run_args=(
		opencode run "$issues Previous RALPH commits: $ralph_commits"
		--file progress.txt ~/.dotfiles/scripts/.local/bin/prompt.md
		--model "github-copilot/gpt-5.3-codex"
		--agent build
		--format json
		--thinking
	)

	if [[ "$use_session" == "true" && -n "$session_id" ]]; then
		run_args+=(--session "$session_id")
	fi

	# Stream output (text, thinking, tool calls) and collect text.
	while IFS= read -r line; do
		type=$(jq -r '.type // empty' <<<"$line")
		current_session_id=$(jq -r '.sessionID // empty' <<<"$line")

		if [[ "$use_session" == "true" && -z "$session_id" && -n "$current_session_id" ]]; then
			session_id="$current_session_id"
			echo "Created session: $session_id"
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
			tool_detail=""

			case "$tool_name" in
			read)
				tool_detail=$(jq -r '.part.state.input | [.filePath, (if .offset then "offset=" + (.offset|tostring) else empty end), (if .limit then "limit=" + (.limit|tostring) else empty end)] | map(select(. != null and . != "")) | join(" ")' <<<"$line")
				;;
			glob)
				tool_detail=$(jq -r '.part.state.input | ["pattern=" + (.pattern // ""), (if .path then "path=" + .path else empty end)] | map(select(. != "")) | join(" ")' <<<"$line")
				;;
			grep)
				tool_detail=$(jq -r '.part.state.input | ["pattern=" + (.pattern // ""), (if .path then "path=" + .path else empty end), (if .include then "include=" + .include else empty end)] | map(select(. != "")) | join(" ")' <<<"$line")
				;;
			bash)
				tool_detail=$(jq -r '.part.state.input | [.command, (if .description then "desc=" + .description else empty end), (if .workdir then "workdir=" + .workdir else empty end)] | map(select(. != null and . != "")) | join(" | ")' <<<"$line")
				;;
			edit)
				tool_detail=""
				;;
			write)
				tool_detail=""
				;;
			webfetch)
				tool_detail=$(jq -r '.part.state.input.url // empty' <<<"$line")
				;;
			task)
				tool_detail=$(jq -r '.part.state.input | [.subagent_type, .description] | map(select(. != null and . != "")) | join(" | ")' <<<"$line")
				;;
			skill)
				tool_detail=$(jq -r '.part.state.input.name // empty' <<<"$line")
				;;
			*)
				tool_detail=$(jq -c '.part.state.input // {}' <<<"$line")
				if [[ "$tool_detail" == "{}" ]]; then
					tool_detail=""
				fi
				;;
			esac

			if [ -n "$tool_name" ]; then
				if [ -n "$tool_desc" ]; then
					echo "Tool [$tool_status]: $tool_name - $tool_desc"
				else
					echo "Tool [$tool_status]: $tool_name"
				fi
				if [ -n "$tool_detail" ]; then
					echo "  input: $tool_detail"
				fi
			fi
		fi

		if [[ "$type" == "error" ]]; then
			err_msg=$(jq -r '.error.data.message // .error.name // "Unknown error"' <<<"$line")
			echo "Error: $err_msg"
		fi
	done < <("${run_args[@]}")

	# Check if complete
	if [[ "$full_output" == *"<promise>COMPLETE</promise>"* ]]; then
		echo "Ralph complete after $i iterations."
		exit 0
	fi
done
