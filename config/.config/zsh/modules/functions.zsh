# ============================================================================
# Functions Module
# ============================================================================

# Extract various archive formats
function extract() {
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

# Auto ls after every cd
function chpwd() {
    emulate -L zsh
    ls -a
}

# List aliases that start with given chars, or run which
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

# Navigate to project directory from ghq
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

# Navigate to workspace and attach to zellij session
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

# Attach to zellij session with fzf selection
function z() {
  ZJ_SESSIONS=$(zellij list-sessions -s)
  NO_SESSIONS=$(echo "${ZJ_SESSIONS}" | wc -l)

  if [ "${NO_SESSIONS}" -ge 2 ]; then
    zellij attach \
      "$(echo "${ZJ_SESSIONS}" | fzf)"
  else
    zellij attach -c
  fi
}

# Yazi with cd on exit
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
