# ============================================================================
# Environment Variables and Configuration
# ============================================================================

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

# PATH additions
export PATH="$PATH:$HOME/.rvm/bin"                    # RVM
export PATH="$PATH:/home/emmanuel/.lmstudio/bin"      # LM Studio CLI

# API Keys from GNU pass
export P_OPENAI_API_KEY=$(pass api/openai)
export P_GROQ_API_KEY=$(pass api/groq)
export P_TAVILY_API_KEY=$(pass api/tavily)
export P_ANTHROPIC_API_KEY=$(pass api/anthropic)
export P_FIGMA_API_KEY=$(pass api/figma)
export P_SENTRY_API_KEY=$(pass api/sentry)
export P_CONTEXT7_API_KEY=$(pass api/context7)
