# ============================================================================
# Keybindings Module
# ============================================================================

# Use emacs keybindings
bindkey -e

# Line editing
bindkey "^U" backward-kill-line
bindkey "^K" kill-line
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# Word navigation
bindkey "^[[1;5C" forward-word      # Ctrl+Right Arrow
bindkey "^[[1;5D" backward-word     # Ctrl+Left Arrow

# History
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^r' history-incremental-search-backward

# Autosuggestions
bindkey '^[ ' autosuggest-accept    # Alt+Space

# Custom widget: Open history file in editor
open-history-file() {
    fc -W  # Write current history to file
    $EDITOR "$HISTFILE" < /dev/tty
    fc -R  # Reload history
    zle reset-prompt
}
zle -N open-history-file
bindkey '^z' open-history-file

# Utility
bindkey "^L" clear-screen
bindkey "^W" backward-kill-word
bindkey "^Y" yank
bindkey "^_" undo

# Commented out experimental keybindings
# autosuggest-fetch-and-accept() {
#     zle autosuggest-fetch
#     zle autosuggest-accept
# }
# zle -N autosuggest-fetch-and-accept
# bindkey '^[l' autosuggest-fetch-and-accept
