#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

while getopts u:a:f: flag
do
    case "${flag}" in        
        f) sourcefile=${OPTARG};;
    esac
done

[[ -z "$sourcefile" ]] && die "-f [sourcefile] missing."
[ ! -f "$sourcefile" ] && die "sourcefile '$sourcefile' does not exist."

show_info "Adding flathub repo..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo  || die 'Failed adding flathub pack.'
show_success "Adding flathub repo...done!"

show_info "Updating existing flatpak's..."
flatpak update || die 'Failed updating flatpaks installed.'
show_success "Updating existing flatpak's...done!"

show_info "Installing flatpaks from '$sourcefile'..."
xargs -a <(awk '! /^ *(#|$)/' "$sourcefile") -r -- flatpak install -y flathub 
show_success "Installing flatpaks from '$sourcefile'...Done!"