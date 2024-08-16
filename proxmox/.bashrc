## Lightweight bashrc for containers / VMs
# Used in most proxmox containers / VMs
##

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
# fix strange issues when resizedd.
shopt -s checkwinsize

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export COLORFGBG='default;default'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
export EDITOR=nano
export GREP_OPTIONS=' — color=auto'

# urukrama, Ubuntuforums.org
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# base aliases
alias psync='rsync -avh --info=progress2'
alias paths='echo -e ${PATH//:/\\n}'

# ls specific with exa extra love
if [ -x "$(command -v exa)" ]; then
	alias ls='exa'
	alias tree='exa --tree --level=5'
	alias lsf='exa -1'
	alias lst='exa -FlTh --level=5'
	alias lss='exa -FlTh --level=5 --no-permissions --no-user'
fi

alias l='ls -lbFh'
alias ll='ls -lah'
alias llm='ll --sort=modified'

if [ -x "$(command -v ssh)" ]; then
	# ssh / scp
	alias sshp="ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no"
fi

if [ -x "$(command -v scp)" ]; then
	alias scpp="scp -o PreferredAuthentications=password"
fi

if [ -x "$(command -v dig)" ]; then
	# network
	alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
fi

# tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
