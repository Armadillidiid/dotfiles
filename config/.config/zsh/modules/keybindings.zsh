# Clear all keybinds
bindkey -rp ''

# Add back keybinds for all printable characters
bindkey -R "^\\\\"-"^\^" self-insert
bindkey -R " "-"~" self-insert
bindkey -R "\M-^@"-"\M-^?" self-insert

# Essential Line Editing
bindkey "^A" beginning-of-line           # Ctrl+A - Go to start of line
bindkey "^E" end-of-line                 # Ctrl+E - Go to end of line
bindkey "^K" kill-line                   # Ctrl+K - Delete from cursor to end
bindkey "^U" backward-kill-line          # Ctrl+U - Delete from cursor to start
bindkey "^W" backward-kill-word          # Ctrl+W - Delete word before cursor
bindkey "^Y" yank                        # Ctrl+Y - Paste (yank) killed text
bindkey "^_" undo                        # Ctrl+/ - Undo last change

# Character Navigation
# bindkey "^B" backward-char               # Ctrl+B - Move back one character
# bindkey "^F" forward-char                # Ctrl+F - Move forward one character
# bindkey "^H" backward-delete-char        # Ctrl+H / Backspace - Delete char before
bindkey "^?" backward-delete-char        # Backspace - Delete char before
bindkey "^D" delete-char                 # Ctrl+D - Delete char under cursor

# Arrow keys
bindkey "^[[A" up-line-or-history       # Up arrow
bindkey "^[[B" down-line-or-history     # Down arrow  
bindkey "^[[C" forward-char             # Right arrow
bindkey "^[[D" backward-char            # Left arrow

# Word Navigation
bindkey "^[[1;5C" forward-word          # Ctrl+Right Arrow
bindkey "^[[1;5D" backward-word         # Ctrl+Left Arrow
# bindkey "^[b" backward-word             # Alt+B - Back one word
# bindkey "^[f" forward-word              # Alt+F - Forward one word
# bindkey "^[d" kill-word                 # Alt+D - Delete word after cursor
# bindkey "^[^H" backward-kill-word       # Alt+Backspace - Delete word before cursor
# bindkey "^[^?" backward-kill-word       # Alt+Backspace (alternative)
bindkey "^H" backward-kill-word       # Ctrl+Backspace (alternative)

# History
bindkey "^P" history-search-backward    # Ctrl+P - Previous in history
bindkey "^N" history-search-forward     # Ctrl+N - Next in history
bindkey "^R" history-incremental-search-backward  # Ctrl+R - Search history backward

# Completion
bindkey "^I" expand-or-complete         # Tab - Complete
bindkey "^[[Z" reverse-menu-complete    # Shift+Tab - Reverse complete

# Line Actions
# bindkey "^J" accept-line                # Ctrl+J / Enter - Accept line
bindkey "^M" accept-line                # Enter - Accept line
bindkey "^L" clear-screen               # Ctrl+L - Clear screen
bindkey "^G" send-break                 # Ctrl+G - Abort current action
bindkey "^V" quoted-insert              # Ctrl+V - Insert next char literally

# Plugin Integrations
bindkey '^[ ' autosuggest-accept        # Alt+Space - Accept autosuggestion
bindkey '^E' autosuggest-accept   # Ctrl+E - Accept autosuggestion
bindkey "^[[200~" bracketed-paste       # Bracketed paste mode (loaded in plugins.zsh)

# Custom Widgets
# Open history file in editor
open-history-file() {
    fc -W  # Write current history to file
    $EDITOR "$HISTFILE" < /dev/tty
    fc -R  # Reload history
    zle reset-prompt
}
zle -N open-history-file
bindkey '^Z' open-history-file          # Ctrl+Z - Edit history file

# Ctrl+X Ctrl+E - Edit command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^O" edit-command-line          # Ctrl+O - Edit command line

# Copy current command  line to clipboard 
copy-line() {
    print -rn -- "$BUFFER" | wl-copy
}
zle -N copy-line 
bindkey '^X^Y' copy-line                 # Ctrl+X Ctrl+Y - Copy line to clipboard

# Show keybindings in human-readable format
show-keybindings() {
    {
        bindkey | sed -E \
            -e 's/"//g' \
            -e 's/^([^ ]+) +/\1\t/' \
            -e 's/\^M/ENTER/g' \
            -e 's/\^I/TAB/g' \
            -e 's/\^H/CTRL+H/g' \
            -e 's/\^\?/BACKSPACE/g' \
            -e 's/\^_/CTRL+_/g' \
            -e 's/\^\[\[1;5C/CTRL+→/g' \
            -e 's/\^\[\[1;5D/CTRL+←/g' \
            -e 's/\^\[\[Z/SHIFT+TAB/g' \
            -e 's/\^\[\[A/↑/g' \
            -e 's/\^\[\[B/↓/g' \
            -e 's/\^\[\[C/→/g' \
            -e 's/\^\[\[D/←/g' \
            -e 's/\^\[OA/↑/g' \
            -e 's/\^\[OB/↓/g' \
            -e 's/\^\[OC/→/g' \
            -e 's/\^\[OD/←/g' \
            -e 's/\^\[\[200~/BRACKETED-PASTE/g' \
            -e 's/\^\[([a-zA-Z])/ALT+\1/g' \
            -e 's/\^\[ /ALT+SPACE/g' \
            -e 's/\^\[\^/ALT+CTRL+/g' \
            -e 's/\^\[/ESC+/g' \
            -e 's/\^X\^/CTRL+X CTRL+/g' \
            -e 's/\^X/CTRL+X /g' \
            -e 's/\^([A-Z@])/CTRL+\1/g' \
            -e 's/\^([a-z])/CTRL+\1/g' \
        | awk -F'\t' '{printf "%-35s -> %s\n", $1, $2}' \
        | sort
    } | ${PAGER:-less}
    
    zle reset-prompt
}
zle -N show-keybindings
bindkey '^[[1;5P' show-keybindings        # Ctrl+F1
