#!/usr/bin/env bash
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='ls -F --color=auto'
alias ll='ls -lah --color=auto'
alias psync='rsync -avh --info=progress2'
alias dusage='du -Sh | sort -n -r | less'
alias topmem='ps h -eo pmem,comm | sort -nr | head'

# apt specific
alias aptpurge='sudo apt-get remove --purge'
alias aptdate='sudo apt-get update && sudo apt-get upgrade'
alias aptgrade='sudo apt-get update && sudo apt-get dist-upgrade'
alias aptclean='sudo apt-get autoclean && sudo apt-get autoremove'