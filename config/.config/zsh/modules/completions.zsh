# ============================================================================
# Completions and ZStyle Configuration
# ============================================================================

# Auto completion styles
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completion (commented out)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' rehash true

# fzf-tab configuration
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'

# Shell integrations
eval "$(fzf --zsh)"                                                    # FZF
eval "$(zoxide init zsh --cmd cd)"                                     # Zoxide
eval "$(oh-my-posh init zsh -c $HOME/.config/oh-my-posh/omp.json)"   # Oh-my-posh
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"  # Kiro terminal

# Optional completions (commented out)
# . <(eksctl completion zsh)
# . <(minikube completion zsh)
