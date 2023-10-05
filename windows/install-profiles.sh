#!/usr/bin/env bash

BASE=(
	.bashrc
	.bash_profile
	../.aliases
)
source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

show_info "Copying default profiles..."

for i in "${BASE[@]}"
do
	cp --backup=numbered $i ~/
	show_success "Copied $i!"
done
show_info "Copying default profiles...Done!"
show_warning "Reload with: $ source ~/.bash_profile!"
show_success "Finished installing profiles!"
