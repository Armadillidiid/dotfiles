#!/usr/bin/env bash
# Load API keys from pass and export them to systemd user environment

set -euo pipefail

# Wait for GPG agent to be ready
timeout=10
count=0
while ! gpg-connect-agent /bye &>/dev/null; do
    if [ $count -ge $timeout ]; then
        echo "Error: GPG agent not ready after ${timeout}s" >&2
        exit 1
    fi
    sleep 1
    ((count++))
done

# Load each secret and export to systemd user environment
declare -A secrets=(
    ["P_OPENAI_API_KEY"]="api/openai"
    ["P_GROQ_API_KEY"]="api/groq"
    ["P_TAVILY_API_KEY"]="api/tavily"
    ["P_ANTHROPIC_API_KEY"]="api/anthropic"
    ["P_FIGMA_API_KEY"]="api/figma"
    ["P_SENTRY_API_KEY"]="api/sentry"
    ["P_CONTEXT7_API_KEY"]="api/context7"
)

for var_name in "${!secrets[@]}"; do
    pass_path="${secrets[$var_name]}"
    
    if value=$(pass show "$pass_path" 2>/dev/null); then
        # Export to systemd user environment
        systemctl --user set-environment "${var_name}=${value}"
        echo "Loaded ${var_name} from ${pass_path}"
    else
        echo "Warning: Failed to load ${pass_path}" >&2
    fi
done

echo "All API keys loaded successfully"
