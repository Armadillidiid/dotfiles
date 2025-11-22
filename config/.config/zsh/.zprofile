# PATH additions
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.sst/bin
export PATH="$PATH:$HOME/.rvm/bin"                    # RVM
export PATH="$PATH:$HOME/.lmstudio/bin"                 # LM Studio CLI

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

# GNU Pass
export PASSWORD_STORE_DIR="$HOME/.dotfiles/password-store/.password-store"

# GHQ
export GHQ_ROOT="$HOME/ghq"

# API Keys from GNU pass
export P_OPENAI_API_KEY=$(pass api/openai)
export P_GROQ_API_KEY=$(pass api/groq)
export P_TAVILY_API_KEY=$(pass api/tavily)
export P_ANTHROPIC_API_KEY=$(pass api/anthropic)
export P_FIGMA_API_KEY=$(pass api/figma)
export P_SENTRY_API_KEY=$(pass api/sentry)
export P_CONTEXT7_API_KEY=$(pass api/context7)

# Askpass
export SUDO_ASKPASS=/usr/bin/ksshaskpass
