#!/usr/bin/env bash
BASE=(
    # System
    bash-completion
    curl
    git
    htop
    jq
    pkg-config
    smartmontools
    ssh-copy-id
    tmux
    tree
    unar
    unzip
    wget
    youtube-dl
    zsh-syntax-highlighting

    # Developer
    awscli
    go
    hugo
    rustup-init
    tinygo
)
CASKS=(
    # System
    keepassxc
    gpgtools
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
    font-inconsolidata
    font-roboto
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

show_info "Installing BASE brew packages..."
brew install ${BASE[@]}
show_success "Installing BASE brew packages...Done!"

show_info "Cleaning up brew..."
brew cleanup
show_success "Cleaning up brew...Done!"

show_info "Installing brew Cask..."
brew install caskroom/cask/brew-cask
show_success "Installing brew Cask...Done!"

show_info "Installing brew cask packages..."
brew install ${CASKS[@]} --cask
show_success "Installing brew cask packages...Done!"

show_info "Installing brew Fonts Cask..."
brew tap caskroom/fonts
show_success "Installing brew Fonts Cask...Done!"

show_info "Installing brew fonts packages..."
brew install ${FONTS[@]} --cask
show_success "Installing brew cask packages...Done!"

show_info "Cleaning up brew..."
brew cleanup
show_success "Cleaning up brew...Done!"

show_success "We're done brew! /NZ-accent"