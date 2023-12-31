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
alias cat='bat'
alias pn='pnpm'
alias reset-kdeconnect='killall kdeconnectd ; kdeconnect-cli --refresh'

source /usr/share/nvm/init-nvm.sh

# Neovim config switcher
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias vi="nvim"

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
alias nvs=nvims

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

# Chatgpt API_KEY
export OPENAI_API_KEY="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"

# Powerline
function _update_ps1() {
	PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Editor
export EDITOR="NVIM_APPNAME=LazyVim /usr/bin/nvim"

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
. <(eksctl completion bash)
. <(minikube completion bash) 
