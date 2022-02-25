#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

while getopts f:c: flag
do
    case "${flag}" in
        f) sourcefile=${OPTAsRG};;
        c) caskfile=${OPTARG};;
    esac
done

if test ! $(which brew); then
    show_info "Installing homebrew..."    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

show_info "Updating brew packages..."
# brew update && brew upgrade `brew outdated`  || die 'Failed update & upgrade brew packages.'
show_success "Updating brew packages...done!"

show_info "Configuring GNU Core Utilities..."
brew tap homebrew/dupes
brew install bash
brew install coreutils
brew install findutils
brew install gnu-indent --with-default-names
brew install gnu-grep --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
show_success "Configuring GNU Core Utilities...Done!"

if test ! -z "$sourcefile"
then
    [ ! -f "$sourcefile" ] && die "sourcefile '$sourcefile' does not exist."

    show_info "Installing brew packages from '$sourcefile'..."
    xargs -a <(awk '! /^ *(#|$)/' "$sourcefile") -r -- brew install
    show_success "Installing brew packages from '$sourcefile'...Done!"
    show_info "Cleaning up brew..."
    brew cleanup
    show_success "Cleaning up brew...Done!"
fi

if test ! -z "$caskfile"
then
    [ ! -f "$caskfile" ] && die "caskfile '$caskfile' does not exist."
    show_info "Installing brew Cask..."
    brew install caskroom/cask/brew-cask
    show_success "Installing brew Cask...Done!"
    show_info "Installing brew cask packages from '$caskfile'..."
    xargs -a <(awk '! /^ *(#|$)/' "$caskfile") -r -- brew cask install
    show_success "Installing brew cask packages from '$caskfile'...Done!"
    show_info "Cleaning up brew..."
    brew cleanup
    show_success "Cleaning up brew...Done!"
fi
