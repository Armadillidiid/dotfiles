export ZDOTDIR="$HOME/.config/zsh"

# Optionally source a secondary .zshenv stored alongside the other configs.
if [ -r "$ZDOTDIR/.zshenv" ] && [ "$ZDOTDIR" != "$HOME" ]; then
  source "$ZDOTDIR/.zshenv"
fi
