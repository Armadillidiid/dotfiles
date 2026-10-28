#!/usr/bin/env bash
# Launch OpenCode service with the nvm default node toolchain on PATH.
# Sourcing nvm.sh auto-runs `nvm use default` — same alias resolution as an
# interactive shell (major aliases, lts/*, installed-version matching), so no
# path here needs updating when node versions change.
# Remaining PATH comes from the systemd user manager environment.

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    # shellcheck disable=SC1090
    . "$NVM_DIR/nvm.sh"
fi

# systemd snapshots its environment per unit start, so restarting this unit
# never picks up a rotated API key on its own. Re-read the pass store first and
# export the fresh values into this process, which the MCP children inherit.
secrets_file="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/secrets.env"
if [ -x "$HOME/.local/bin/load-pass-env.sh" ]; then
    if ! "$HOME/.local/bin/load-pass-env.sh" >/dev/null; then
        echo "warning: secret refresh failed, falling back to $secrets_file" >&2
    fi
fi
if [ -r "$secrets_file" ]; then
    set -a
    # shellcheck disable=SC1090
    . "$secrets_file"
    set +a
fi

exec /usr/bin/opencode serve --service
