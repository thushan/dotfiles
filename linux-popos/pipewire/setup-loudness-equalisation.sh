#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/../../scripts/console-colours.sh"

GIT_REPOSITORY="https://raw.githubusercontent.com/Digitalone1/EasyEffects-Presets/master/"
PRESET="LoudnessEqualizer.json"

check_installation() {
    if command -v flatpak &> /dev/null && flatpak list | grep -q "com.github.wwmm.easyeffects"; then
        PRESETS_DIRECTORY="$HOME/.var/app/com.github.wwmm.easyeffects/config/easyeffects"
    elif which easyeffects >/dev/null; then
        PRESETS_DIRECTORY="$HOME/.config/easyeffects"
    else
        die "Couldn't determine EasyEffects Presets folder."
    fi
    
    mkdir -p $PRESETS_DIRECTORY
    show_info "Found Presets at '$PRESETS_DIRECTORY'"
}

install_preset() {
    PRESET_LOCATION="$PRESETS_DIRECTORY/output/$PRESET"
    curl --location "$GIT_REPOSITORY/$PRESET" --output $PRESET_LOCATION --silent
}

verify_install() {
    [ ! -f "$PRESET_LOCATION" ] && die "Installation failed to find preset in ('$PRESET_LOCATION') :("
}

show_info "Checking installation..."
check_installation
show_info "Installing Preset ('$PRESET')..."
install_preset
verify_install
show_success "Installing Preset ('$PRESET')...Done!"