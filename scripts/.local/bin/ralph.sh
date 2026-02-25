#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <iterations>"
  exit 1
fi

for ((i = 1; i <= $1; i++)); do
  echo "Iteration $i"
  echo "------------------------------"

  result=$(
    opencode run "\
1. Find the highest-priority feature to work on and work only on that feature. \
This should be the one YOU decide has the highest priority - not necessarily the first item. \
2. Check that the types check via pnpm typecheck. \
3. Update the PRD with the work that was done. \
4. Append your progress to the progress.txt file. \
Use this to leave a note for the next person working in the codebase. \
5. Make a git commit of that feature. \
ONLY WORK ON A SINGLE FEATURE. \
If, while implementing the feature, you notice the PRD is complete, output <promise>COMPLETE</promise>" \
      --file .opencode/plans progress.txt --model "github-copilot/claude-sonnet-4.6"
  )

  echo "$result"

  if [[ "$result" == *"<promise>COMPLETE</promise>"* ]]; then
    echo "PRD complete after $i iterations, exiting."
    notify-send "PRD complete after $i iterations"
    exit 0
  fi
done
