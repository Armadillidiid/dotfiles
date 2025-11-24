# ============================================================================
# Aliases Module
# ============================================================================

# System utilities
alias open='xdg-open'
alias reset-network=$scripts/reset-network.sh
alias reset-easyeffects=$scripts/reset-easyeffects.sh
alias reset-kdeconnect='killall kdeconnectd ; kdeconnect-cli --refresh'
alias reset-mouse='sudo sh -c "echo -n \"0000:05:00.4\" | tee /sys/bus/pci/drivers/xhci_hcd/unbind; sleep 0.2; echo -n \"0000:05:00.4\" | tee /sys/bus/pci/drivers/xhci_hcd/bind"'

# Reboot to Windows
BOOT_NUMBER=$($scripts/get-efi-boot-number.sh "Windows Boot Manager")
alias wreboot='sudo efibootmgr -n $BOOT_NUMBER && systemctl reboot'

# File management
alias ls='lsd --group-directories-first'
alias lla='lsd -la'
alias cat='bat'
alias catd='bat --decorations=never'

# Navigation
alias home="cd $HOME"
alias ..='cd ..'
alias ...="cd ../.."

# Development tools
alias grep='grep --color=always'
alias rg="rg --sort path"
alias fz="fzf"
alias sudit="sudoedit"
alias pn='pnpm'
alias ghqp="ghq get -p"
alias ghql="ghq list"

# Editors and IDEs
alias nvim-all=$scripts/nvim-config-switcher.sh
alias nvs="NVIM_APPNAME=LazyVim nvim"
alias vi="NVIM_APPNAME=nvim nvim"
alias oc="opencode"

# Shell management
alias zz="$EDITOR ${ZDOTDIR:-$HOME}/.zshrc"
alias zzz="clear && source ${ZDOTDIR:-$HOME}/.zshrc"

# Git tools
alias lz="lazygit"
alias lzd="lazydocker"

# Utilities
alias q="tldr"
alias d0t='cd ~/.dotfiles; zellij attach -c dotfiles'
alias rec='asciinema rec'
alias play='asciinema play'
alias j='jrnl'

# VPN
alias vpn="nmcli con up uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"
alias vpnd="nmcli con down uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"

# AI - GitHub Copilot
alias ask='gh copilot suggest -t shell'
alias x='gh copilot explain -t shell'

# Btrfs
alias btrfsfs="sudo btrfs filesystem df /"
alias btrfsli="sudo btrfs su li / -t"

# Zellij
alias zda="zellij delete-all-sessions"

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
