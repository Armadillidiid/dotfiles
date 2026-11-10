#!/usr/bin/env bash
# Load API keys from pass and export them to systemd user environment

set -euo pipefail

# Mirror of the loaded secrets, consumed by units that must pick up a rotated
# key on restart (systemd snapshots the manager env per unit start, so a plain
# `systemctl restart` would otherwise keep serving the previous token).
runtime_dir="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
secrets_file="${runtime_dir}/secrets.env"
loaded_lines=()

# `--if-stale` lets the refresh timer skip work (and skip a pinentry prompt)
# when no pass entry changed since the last successful load.
if [ "${1:-}" = "--if-stale" ]; then
    if [ -f "$secrets_file" ] &&
        [ -z "$(find -L "$HOME/.password-store" -name '*.gpg' -newer "$secrets_file" -print -quit 2>/dev/null)" ]; then
        exit 0
    fi
fi

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
    ["LINEAR_API_KEY"]="api/linear"
)

# Backoff schedule (seconds). First decryption after boot frequently fails while
# gpg-agent/keyboxd warm up or while pinentry is still being shown, so retry
# instead of silently dropping the secret. Total wait: ~60s per secret.
retry_delays=(1 2 4 8 15 30)

errlog=$(mktemp)
trap 'rm -f "$errlog"' EXIT

failed=0
failed_names=()

for var_name in "${!secrets[@]}"; do
    pass_path="${secrets[$var_name]}"

    value=""
    last_err=""
    for delay in "${retry_delays[@]}"; do
        if value=$(pass show "$pass_path" 2>"$errlog"); then
            break
        fi
        value=""
        last_err=$(tail -n 3 "$errlog" | tr '\n' ' ')
        sleep "$delay"
    done

    if [ -n "$value" ]; then
        # Export to systemd user environment
        systemctl --user set-environment "${var_name}=${value}"
        if [[ "$value" =~ ^[A-Za-z0-9_./:+@=-]+$ ]]; then
            loaded_lines+=("${var_name}=${value}")
        else
            echo "Warning: ${var_name} has characters unsafe for ${secrets_file}; skipped" >&2
        fi
        echo "Loaded ${var_name} from ${pass_path}"
    else
        echo "Error: Failed to load ${pass_path}: ${last_err:-unknown error}" >&2
        failed=$((failed + 1))
        failed_names+=("${var_name}")
    fi
done

# Verify the values actually landed in the user manager environment; a silent
# set-environment failure would otherwise surface later as an empty secret in
# whatever child process consumes it.
if [ "$failed" -eq 0 ]; then
    env_dump=$(systemctl --user show-environment)
    for var_name in "${!secrets[@]}"; do
        if ! grep -q "^${var_name}=" <<<"$env_dump"; then
            echo "Error: ${var_name} missing from systemd user environment" >&2
            failed=$((failed + 1))
            failed_names+=("${var_name}")
        fi
    done
fi

if [ "$failed" -gt 0 ]; then
    echo "Error: ${failed} secret(s) could not be loaded: ${failed_names[*]}" >&2
    exit 1
fi

# Write the mirror atomically, 0600, into the per-user tmpfs.
if [ "${#loaded_lines[@]}" -gt 0 ]; then
    tmp_file=$(mktemp "${secrets_file}.XXXXXX")
    chmod 600 "$tmp_file"
    printf '%s\n' "${loaded_lines[@]}" >"$tmp_file"
    mv -f "$tmp_file" "$secrets_file"
    echo "Wrote ${#loaded_lines[@]} secret(s) to ${secrets_file}"
fi

echo "All API keys loaded successfully"
