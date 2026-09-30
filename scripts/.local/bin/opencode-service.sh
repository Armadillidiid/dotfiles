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

exec /usr/bin/opencode serve --service
