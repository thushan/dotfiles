alias ls='ls -F'
alias ll='ls -lah'
alias psync='rsync -avh --info=progress2'
alias dusage='du -Sh | sort -n -r | less'
alias topmem='ps h -eo pmem,comm | sort -nr | head'

if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

export EDITOR=nano
export BROWSER="firefox '%s' &"