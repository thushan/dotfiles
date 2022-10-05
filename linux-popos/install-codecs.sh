#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

show_success "Setting up Multimedia Codecs..."

show_info "Installing dependencies..."
sudo apt install -y libavcodec-extra libdvd-pkg
show_info "Reconfiguring libdvd..."
sudo dpkg-reconfigure libdvd-pkg

show_success "Setting up Multimedia Codecs...Done!"
