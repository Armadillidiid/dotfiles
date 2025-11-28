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
        if [ -z "$directory" ]; then
            return
        fi
    else
        directory="$name"
    fi

    # Change to the selected directory
    builtin cd "$HOME/ghq/$directory" || return
}

# Navigate to workspace and attach to zellij session
function zj() {
    local workspace
    local name="$1"

    if [ -z "$name" ]; then
        local directory=$(ghq list | fzf)
        
        if [ -z "$directory" ]; then
            return
        fi

        workspace="$HOME/ghq/$directory"
        name=$(basename "$directory")
    else
        workspace=$(pwd)
    fi

    # Change to workspace directory
    builtin cd "$workspace" || return

    local layout_path=".zellij.kdl"
    if [ -e "$layout_path" ]; then
        zellij --layout "$layout_path" attach -f -c "$name"
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

# Auto ls after every cd
function chpwd() {
    emulate -L zsh
    ls -a
}
