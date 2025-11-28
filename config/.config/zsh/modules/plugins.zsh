# ============================================================================
# Plugins Module - Zinit and Plugin Management
# ============================================================================

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Register local completions directory
zinit add-fpath $HOME/.comp

# Load bracketed-paste-magic BEFORE plugins
# This sets $zle_bracketed_paste array required by Oh My Posh
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# Load Oh-My-Zsh plugins
zinit wait lucid for   \
  OMZP::common-aliases  \
  OMZP::archlinux       \
  OMZP::sudo            \
  OMZP::systemd         \
  OMZP::docker-compose  \
  OMZP::command-not-found 

# Configure zsh-autosuggestions to disable default keybindings
# We'll set our own keybindings in keybindings.zsh
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=()

# Load essential ZSH plugins
zinit wait lucid light-mode for  \
  atinit"zicompinit; zicdreplay" zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab
