#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

show_info "Setting up Gnome settings..."

# Sort by folders first, then files in Nautilus
gsettings set org.gtk.Settings.FileChooser sort-directories-first true

# Show hidden files, we're not little kids
gsettings set org.gtk.Settings.FileChooser show-hidden true

show_success "Setting up Gnome settings...Done!"