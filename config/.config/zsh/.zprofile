
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zprofile.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zprofile.pre.zsh"

# Login-shell only setup
# Env vars moved to $ZDOTDIR/.zshenv (all shells)


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zprofile.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zprofile.post.zsh"
