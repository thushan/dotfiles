# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoredups
export COLORFGBG='default;default'

alias ls='ls -F --color=auto'
alias ll='ls -lah --color=auto'
alias psync='rsync -avh --info=progress2'
alias dusage='du -Sh | sort -n -r | less'
alias topmem='ps h -eo pmem,comm | sort -nr | head'

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

export EDITOR=nano
export BROWSER="firefox '%s' &"