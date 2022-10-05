#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

show_info "Current Hostname: $(uname -n)"

read -t 5 -p 'New Hostname: (Continuing in 5s...) ' myhostname

if [ -z "$myhostname" ]
then
	show_info "Kept Hostname: $(uname -n)"
else
	show_success "Changing hostname to $myhostname"
	hostnamectl set-hostname $myhostname
	show_info "Current Hostname: $(uname -n)"
fi

show_info "Setting up Gnome settings..."

# Sort by folders first, then files in Nautilus
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Show hidden files, we're not little kids
gsettings set org.gtk.Settings.FileChooser show-hidden true

# Don't remember history
gsettings set org.gnome.desktop.privacy remember-recent-files false

show_success "Setting up Gnome settings...Done!"
