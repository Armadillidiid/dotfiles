# If not running interactively, don't do anything
[[ $- != *i* ]] && return
scripts="$HOME/.local/bin"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" 

# Reboot to Windows
BOOT_NUMBER=$($scripts/get-efi-boot-number.sh "Windows Boot Manager")
alias wreboot='sudo efibootmgr -n $BOOT_NUMBER && systemctl reboot'

alias open='xdg-open'
alias reset-network=$scripts/reset-network.sh
alias reset-easyeffects=$scripts/reset-easyeffects.sh
alias ls='lsd --group-directories-first'
alias lla='lsd -la'
alias cat='bat'
alias catd='bat --decorations=never'
alias pn='pnpm'
alias reset-kdeconnect='killall kdeconnectd ; kdeconnect-cli --refresh'
alias home="cd $HOME"
alias ..='cd ..'
alias ...="cd ../.."
alias grep='grep --color=always'
alias fz="fzf"
alias sudt="sudoedit"
alias zz="$EDITOR $HOME/.zshrc"
alias zzz="clear && source $HOME/.zshrc"
alias ghqp="ghq get -p"
alias ghql="ghq list"
alias lz="lazygit"
alias lzd="lazydocker"
alias oc="opencode"
alias q="tldr"
alias d0t='cd ~/.dotfiles; zellij attach -c dotfiles'
alias rec='asciinema rec'
alias play='asciinema play'
alias j='jrnl'

# search content with ripgrep
alias rg="rg --sort path"

# Neovim
alias nvim-all=$scripts/nvim-config-switcher.sh
alias nvs="NVIM_APPNAME=LazyVim nvim"
alias vi="NVIM_APPNAME=nvim nvim"

# VPN
alias vpn="nmcli con up uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"
alias vpnd="nmcli con down uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"

# AI - GitHub Copilot
alias ask='gh copilot suggest -t shell'
alias x='gh copilot explain -t shell'

# Extract files
function extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.br)    tar -I brotli -xf $1 ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# btrfs aliases
alias btrfsfs="sudo btrfs filesystem df /"
alias btrfsli="sudo btrfs su li / -t"

# auto ls after every 'cd' 
function chpwd() {
    emulate -L zsh
    ls -a
}

# `w` with no arguments lists all shell aliases,
# otherwise lists aliases, that start with the given chars.
# If no alias is found, it runs `which` command.
function w() {
    local result=""
    if [[ $# -eq 0 ]]; then
        result=$(alias)
    else
        result=$(alias | rg "^$@")
    fi
    if [[ -z "$result" ]]; then
        which "$@"
    else
        echo "Aliases:"
        echo "$result"
        echo
        echo "Which:"
        which "$@"
    fi
}

function dev() {
    local name="$1"
    local directory

    # If no name is provided, prompt user to select a directory
    if [ -z "$name" ]; then
        directory=$(ghq list | fzf) || return
        
        if [ -n "$directory" ]; then
            cd "$HOME/ghq/$directory" || return
        else
            return
        fi
    fi

    # If a name is provided, check if we are already in the correct directory
    if [ "$name" != "$directory" ]; then
        cd "$HOME/ghq/$directory" || return
    fi
}

# This function navigates to a specified workspace, or allows the user to select one if not specified.
# It then attaches to a zellij session using a layout file if present, or creates a new session.
function zj() {
    local workspace
    local name="$1"

    if [ -z "$name" ]; then
        cd ~/ghq || return
        local directory=$(fd -t d -d 3 | awk -F'/' 'NF == 4' | fzf)

        if [ -z "$directory" ]; then
            cd - || return
            return
        fi

        workspace="$(pwd)/$directory"
        name=$(echo -n "$workspace" | rev | cut -d'/' -f2 | rev | sed -re 's/\./_/g')
    else
        workspace=$(pwd)
    fi

    if [ "$(pwd)" != "$workspace" ]; then
        cd "$workspace" || return
    fi

    if [ -e "$workspace/.zellij.kdl" ]; then
        zellij --layout "$workspace/.zellij.kdl" attach -f -c "$name"
    else
        zellij attach -c "$name"
    fi
}

# Zellij
alias zda="zellij delete-all-sessions"
function z () {
  ZJ_SESSIONS=$(zellij list-sessions -s)
  NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

  if [ "${NO_SESSIONS}" -ge 2 ]; then
    zellij attach \
      "$(echo "${ZJ_SESSIONS}" | fzf)"
        else
          zellij attach -c
  fi
}

# Docker
alias dcls='docker container ls'
alias dclsa='docker container ls -a'
alias dils='docker image ls'
alias dlo='docker container logs'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drit='docker container run -it'
alias dsta='docker stop $(docker ps -q)'
alias dxcit='docker container exec -it'

# Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Fzf 
export FZF_ALT_C_COMMAND="fd . --type d --max-depth 2"
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# ---- ZSH -----
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

# Load plugins
zinit wait lucid for   \
  OMZP::common-aliases  \
  OMZP::archlinux       \
  OMZP::sudo            \
  OMZP::systemd         \
  OMZP::docker-compose  \
  OMZP::command-not-found 

zinit wait lucid light-mode for  \
  atinit"zicompinit; zicdreplay" zsh-users/zsh-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  Aloxaf/fzf-tab

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Keybindings
bindkey -e
bindkey "^U" backward-kill-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^[ ' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# autosuggest-fetch-and-accept() {
#     zle autosuggest-fetch
#     zle autosuggest-accept
# }
# zle -N autosuggest-fetch-and-accept
# bindkey '^[l' autosuggest-fetch-and-accept

open-history-file() {
    fc -W  # Write current history to file
    $EDITOR "$HISTFILE" < /dev/tty
    fc -R  # Reload history
    zle reset-prompt
}
zle -N open-history-file
bindkey '^z' open-history-file

# Auto completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*' rehash true
zstyle ':fzf-tab:*' fzf-bindings 'tab:accept'

# Shell integration
eval "$(fzf --zsh)" # FZF-tab
eval "$(zoxide init zsh --cmd cd)" # Zoxide
eval "$(oh-my-posh init zsh -c $HOME/.config/oh-my-posh/omp.json)" # oh-my-posh
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
# . <(eksctl completion zsh)
# . <(minikube completion zsh) 

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/emmanuel/.lmstudio/bin"

# Ignore commands in history
function zshaddhistory() {
    [[ $1 == jrnl* ]] && return 1 
    [[ $1 == j ]] && return 1 
    
    return 0
}

# GNU pass
export P_OPENAI_API_KEY=$(pass api/openai)
export P_GROQ_API_KEY=$(pass api/groq)
export P_TAVILY_API_KEY=$(pass api/tavily)
export P_ANTHROPIC_API_KEY=$(pass api/anthropic)
export P_FIGMA_API_KEY=$(pass api/figma)
export P_SENTRY_API_KEY=$(pass api/sentry)
export P_CONTEXT7_API_KEY=$(pass api/context7)
