#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/scripts/console-colours.sh"

show_info "Setting up default links..."

BASE=(
	.bashrc
	.zshrc
	.aliases
	.aliases-linux
	.commands
	.tmux.conf
	.editorconfig
	.wgetrc
	.vimrc
	.gbinit
	.curlc
	.dockerrc
)

for i in "${BASE[@]}"
do
    show_info "Linking $i..."

	if [ -f ~/$i ]; then
		random_name=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '')
		show_warning "Found $i already, backing up to $i.$random_name..."
		cp ~/$i ~/$i.$random_name
	fi
	ln -snf $i ~/
	show_success "Linked $i!"

done
show_success "Setting up default links...done!"


