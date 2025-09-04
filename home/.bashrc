#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias open='xdg-open'
alias reset-network='~/.local/bin/reset-network.sh'
alias reset-easyeffects='~/.local/bin/reset-easyeffects.sh'
alias middle-scroll='~/.local/bin/middle_click_to_scroll.sh'
alias wreboot='sudo efibootmgr -n 0003 && sudo reboot'
# alias ls='exa --group-directories-first'
alias ls='lsd --group-directories-first'
alias ll='lsd -la'
alias cat='bat'
alias catx='bat --decorations=never'
alias pn='pnpm'
alias reset-kdeconnect='killall kdeconnectd ; kdeconnect-cli --refresh'
alias ..='cd ..'
alias grep='grep --color=always'
alias fz="fzf"

source /usr/share/nvm/init-nvm.sh

# Neovim config switcher
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvs="NVIM_APPNAME=LazyVim nvim"
alias vi="NVIM_APPNAME=nvim nvim"
alias ai="gh copilot suggest"
alias aix="gh copilot explain"
alias save-session="~/.local/bin/save-kitty-session.sh"
alias res-session="~/.local/bin/restore-kitty-session.sh"
alias vpn="nmcli con up uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"
alias vpn-d="nmcli con down uuid 46383f82-2a39-4bb9-a9da-82fc506f5489"

function nvims() {
	items=$(
		find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;
		find $HOME/.dotfiles -maxdepth 5 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;
	)
	selected=$(printf "%s\n" "${items[@]}" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200'" fzf)
	if [[ -z $selected ]]; then
		return 0
	elif [[ $selected == "nvim" ]]; then
		selected=""
	fi
	NVIM_APPNAME=$selected nvim "$@"
}
alias nvim-all=nvims

# function nvims() {
# 	items=("LazyVim" "default")
# 	config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
# 	if [[ -z $config ]]; then
# 		echo "Nothing selected"
# 		return 0
# 	elif [[ $config == "default" ]]; then
# 		config=""
# 	else
# 		alias vi="NVIM_APPNAME=${config} nvim"
# 	fi
# 	NVIM_APPNAME=$config nvim $@
# }

# Auto-ls when cd-ing into directories
function cd () {
  builtin cd "$@";
  lsd -aG;
}

# Chatgpt API_KEY
OPENAI_API_KEY=$(~/.local/bin/open-ai-key.sh)
export OPENAI_API_KEY

# Powerline
function _update_ps1() {
	PS1=$(powerline-shell $?)
}

# if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
# 	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
# fi

# Editor
export EDITOR=nvim
export NVIM_APPNAME=LazyVim

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# pnpm
export PNPM_HOME="/home/emmanuel/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# change directory to repo
function repo() {
	if [ "$1" == "w" ]; then
		cd ~/ghq/github.com/govahq/monorepo//
	elif [ "$1" == "p" ]; then
		cd ~/ghq/github.com/Armadillidiid/
	else
		cd ~/ghq/github.com/
	fi
}

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/bash/__tabtab.bash ] && . ~/.config/tabtab/bash/__tabtab.bash || true

# autocompletion for eksctl and minikube
# . <(eksctl completion bash)
# . <(minikube completion bash) 

# setup zoxide
eval "$(zoxide init bash --cmd cd)"

# Moar pager -- man
export MOAR='--statusbar=bold --no-linenumbers -style catppuccin-mocha'
export PAGER=/usr/bin/moar
# export PAGER=nvimpager
# export NVIMPAGER_NVIM=nvim

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
