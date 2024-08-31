#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH=$PATH:/home/emmanuel/go/bin
export PATH=$PATH:/home/emmanuel/.local/bin
export PATH=$PATH:/home/emmanuel/.sst/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
