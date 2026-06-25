# PATH additions
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.sst/bin
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/.lmstudio/bin"
export PATH="$PATH:$HOME/.local/share/mise/shims"
export PATH="$PATH:$HOME/.local/share/omarchy/bin"
export PATH="$PATH:$HOME/.vite-plus/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
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

# GNU Pass
export PASSWORD_STORE_DIR="$HOME/.dotfiles/password-store/.password-store"

# GHQ
export GHQ_ROOT="$HOME/ghq"

# Askpass
export SUDO_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS=/usr/bin/ksshaskpass
export SSH_ASKPASS_REQUIRE=prefer
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# AWS Bedrock
# export AWS_BEARER_TOKEN_BEDROCK="$(pass api/aws-bedrock)"

# omarchy doesn't set XDG_RUNTIME_DIR via SSH, so we set it here
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
