#!/usr/bin/env bash
# Full credit goes to - https://github.com/fabiomaia/linuxify/blob/master/.linuxify
# This file only contains the linuxifying relevant to me.
BREW_HOME=$(brew --prefix)

# most programs
export PATH="${BREW_HOME}/bin:$PATH"
export MANPATH="${BREW_HOME}/share/man:$MANPATH"
export INFOPATH="${BREW_HOME}/share/info:$INFOPATH"

brew install bash
brew install coreutils
brew install findutils
brew install gnutls
brew install gawk
brew install grep
brew install gnu-indent
brew install gnu-getopt
brew install gnu-sed
brew install gnu-tar
brew install gnu-which

# coreutils
export PATH="${BREW_HOME}/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="${BREW_HOME}/opt/coreutils/libexec/gnuman:$MANPATH"

# findutils
export PATH="${BREW_HOME}/opt/findutils/libexec/gnubin:$PATH"

# gnu-indent
export PATH="${BREW_HOME}/opt/gnu-indent/libexec/gnubin:$PATH"

# gnu-sed
export PATH="${BREW_HOME}/opt/gnu-sed/libexec/gnubin:$PATH"

# gnu-tar
export PATH="${BREW_HOME}/opt/gnu-tar/libexec/gnubin:$PATH"

# gnu-which
export PATH="${BREW_HOME}/opt/gnu-which/libexec/gnubin:$PATH"

# grep
export PATH="${BREW_HOME}/opt/grep/libexec/gnubin:$PATH"

# ssh-copy-id
export PATH="${BREW_HOME}/usr/local/opt/ssh-copy-id/bin:$PATH"

# unzip
export PATH="${BREW_HOME}/usr/local/opt/unzip/bin:$PATH"

unset BREW_HOME