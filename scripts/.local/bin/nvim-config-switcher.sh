items=$(
find $HOME/.config -maxdepth 2 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;
find $HOME/.dotfiles -maxdepth 5 -name "init.lua" -type f -execdir sh -c 'pwd | xargs basename' \;
)
selected=$(printf "%s\n" "${items[@]}" | FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS-} --preview-window 'right:border-left:50%:<40(right:border-left:50%:hidden)' --preview 'lsd -l -A --tree --depth=1 --color=always --blocks=size,name ~/.config/{} | head -200'" fzf)
if [[ -z $selected ]]; then
  exit 0
elif [[ $selected == "nvim" ]]; then
  selected=""
fi
NVIM_APPNAME=$selected nvim "$@"
