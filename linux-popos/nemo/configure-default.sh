#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/console-colours.sh"

configure_settings() {
	xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	gsettings set org.gnome.desktop.background show-desktop-icons false
	gsettings set org.nemo.desktop show-desktop-icons true
}
create_autostart() {
	cp --backup ./nemo-desktop.desktop ~/.config/autostart/
}
show_info "Configuring nemo as default file manager..."
configure_settings
create_autostart
show_success "Configuring nemo as default file manager...done!"
