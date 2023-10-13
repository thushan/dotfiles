#!/usr/bin/env bash
BASE=(
    # System
    bash-completion
    curl
    git
	gdu
    htop
    jq
    pkg-config
    smartmontools
    ssh-copy-id
	starship
    tmux
    tree
    unar
    unzip
    wget
    youtube-dl
    # source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    zsh-syntax-highlighting

    # Developer
    awscli
    go
    hugo
    rustup-init
    tinygo
)
TAPS=(
    homebrew/cask
    homebrew/cask-fonts
    tinygo-org/tools
)
CASKS=(
    # System
    keepassxc
    # *NOTE: Requires Password
    gpg-suite
    iterm2
    flux

    # Internet Tools / Browsers
    brave-browser
    dropbox
    firefox
    google-chrome
    opera
    signal
    slack
    # *NOTE: Requires Password
    zoom

    # Utilities
    balenaetcher

    # Developer
    dotnet
    postman
    visual-studio-code

    # Media
    vlc
)
FONTS=(
    font-inconsolata
)

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

if test ! $(which brew); then
    show_info "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    show_success "Installing homebrew...Done!"
fi

show_info "Updating brew packages..."
brew update || die 'Failed update & upgrade brew packages.' # && brew upgrade `brew outdated`
show_success "Updating brew packages...done!"

# Setup sensible GNU utilities
show_info "Configuring GNU Core Utilities..."
sh ./linuxify.sh
show_success "Configuring GNU Core Utilities...Done!"

show_info "Installing brew taps..."
for i in "${TAPS[@]}"
do
    # Have to tap these individually brew /NZ-accent!
	brew tap $i
done
show_success "Installing brew taps...Done!"

show_info "Installing BASE brew packages..."
brew install ${BASE[@]}
show_success "Installing BASE brew packages...Done!"

show_info "Cleaning up brew..."
brew cleanup
show_success "Cleaning up brew...Done!"

show_info "Installing brew cask packages..."
brew install ${CASKS[@]} --cask
show_success "Installing brew cask packages...Done!"

show_info "Installing brew fonts packages..."
brew install ${FONTS[@]} --cask
show_success "Installing brew cask packages...Done!"

show_info "Cleaning up brew..."
brew cleanup
show_success "Cleaning up brew...Done!"

show_success "We're done brew! /NZ-accent"
