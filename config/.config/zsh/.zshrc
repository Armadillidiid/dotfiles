# Exit if not running interactively
[[ $- != *i* ]] && return

# Set scripts directory
scripts="$HOME/.local/bin"

# Module directory
ZSH_MODULES="${ZDOTDIR:-$HOME/.config/zsh}/modules"

# Source all modules in order
# Order matters: env -> plugins -> functions -> aliases -> keybindings -> completions

# 1. Environment variables and basic configuration
[[ -f "$ZSH_MODULES/env.zsh" ]] && source "$ZSH_MODULES/env.zsh"

# 2. Plugin management (must be loaded before completions)
[[ -f "$ZSH_MODULES/plugins.zsh" ]] && source "$ZSH_MODULES/plugins.zsh"

# 3. Aliases
[[ -f "$ZSH_MODULES/aliases.zsh" ]] && source "$ZSH_MODULES/aliases.zsh"

# 4. Custom functions
[[ -f "$ZSH_MODULES/functions.zsh" ]] && source "$ZSH_MODULES/functions.zsh"

# 5. Keybindings
[[ -f "$ZSH_MODULES/keybindings.zsh" ]] && source "$ZSH_MODULES/keybindings.zsh"

# 6. Completions and shell integrations (must be last)
[[ -f "$ZSH_MODULES/completions.zsh" ]] && source "$ZSH_MODULES/completions.zsh"
