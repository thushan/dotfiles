#!/usr/bin/env bash
#####
# Windows specific bashrc
#####

# load aliases
if [ -f ~/.aliases ]; then . ~/.aliases; fi

if [ -x "$(command -v starship)" ]; then
	eval "$(starship init bash)"
fi
