#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

while getopts u:a:f: flag
do
    case "${flag}" in        
        f) sourcefile=${OPTARG};;
        c) caskfile=${OPTARG};;
    esac
done

show_info "Updating brew packages..."
brew update && brew upgrade `brew outdated`  || die 'Failed update & upgrade brew packages.'
show_success "Updating brew packages...done!"

if [[ !-z "$sourcefile" ]]
then
    [ ! -f "$sourcefile" ] && die "sourcefile '$sourcefile' does not exist."

    show_info "Installing brew packages from '$sourcefile'..."
    xargs -a <(awk '! /^ *(#|$)/' "$sourcefile") -r -- brew install
    show_success "Installing brew packages from '$sourcefile'...Done!"
fi

if [[ !-z "$caskfile" ]]
then
    [ ! -f "$caskfile" ] && die "caskfile '$caskfile' does not exist."

    show_info "Installing brew cask packages from '$caskfile'..."
    xargs -a <(awk '! /^ *(#|$)/' "$caskfile") -r -- brew cask install
    show_success "Installing brew cask packages from '$caskfile'...Done!"
fi
