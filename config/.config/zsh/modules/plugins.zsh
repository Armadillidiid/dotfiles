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

# Load Oh-My-Zsh plugins
zinit wait lucid for   \
  OMZP::common-aliases  \
  OMZP::archlinux       \
  OMZP::sudo            \
  OMZP::systemd         \
  OMZP::docker-compose  \
  OMZP::command-not-found 

# Load essential ZSH plugins
zinit wait lucid light-mode for  \
  atinit"zicompinit; zicdreplay" zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab
