[[ -f ~/.zshrc ]] && . ~/.zshrc

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.sst/bin

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# Editor
export EDITOR=nvim
export VISUAL=nvim
export NVIM_APPNAME=LazyVim

# Pager
export MOAR='--statusbar=bold --no-linenumbers -style catppuccin-mocha --quit-if-one-screen'
export PAGER=/usr/bin/moor
# export NVIMPAGER_NVIM=nvim

# Others
export OPENAI_API_KEY=$($HOME/.local/bin/open-ai-key.sh)
export GROQ_API_KEY=$($HOME/.local/bin/groq-api-key.sh)
export TAVILY_API_KEY=$($HOME/.local/bin/tavily-api-key.sh)
export ANTHROPIC_API_KEY=$($HOME/.local/bin/anthropic-api-key.sh)

export GHQ_ROOT="$HOME/ghq"
