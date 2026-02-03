# ============================================================================
# Environment Variables and Configuration
# ============================================================================

# Import API keys from systemd user environment
# These are loaded by the systemd user service 'load-pass-env.service'
if command -v systemctl &>/dev/null; then
    while IFS='=' read -r key value; do
        [[ "$key" =~ ^P_.*_API_KEY$ ]] && export "$key=$value"
    done < <(systemctl --user show-environment 2>/dev/null | grep '^P_.*_API_KEY=')
fi

# NVM (Node Version Manager)
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# FZF configuration
export FZF_ALT_C_COMMAND="fd . --type d --max-depth 2"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# History configuration
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

export OPENCODE_EXPERIMENTAL=1 
