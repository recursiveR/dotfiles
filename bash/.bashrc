#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias mutt='mutt -F ~/.config/mutt/muttrc'
alias py='python3'
alias jn='jupyter notebook'

alias :q="echo This isn\'t VIM, asshat."
alias :wq="echo This isn\'t VIM, asshat."

slate="\[\033[0;36m\]"
green="\[\033[38;5;35m\]"
blue="\[\033[0;34m\]"
brown="\[\033[0;35m\]"
hyperBlue="\[\033[38;5;32m\]"
reset="\[\033[0m\]"

source ~/.git-prompt.sh
source ~/.git-completion.bash
export GIT_PS1_SHOWDIRTYSTATE=1
# '\$(__git_ps1)' adds git-related stuff

export PS1="$hyperBlue\w$brown\$(__git_ps1)$green $ $reset"

# Disable ctrl-s freezing terminal
stty -ixon
