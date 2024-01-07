#!/usr/bin/env bash
# inspired by: https://github.com/mathiasbynens/dotfiles/blob/master/.macos

source "$(dirname "${BASH_SOURCE[0]}")./scripts/console-colours.sh"

show_info "-- Setting up OS X"
show_info "OSX:    $(sw_vers -productVersion)"
show_info "Build:  $(sw_vers -buildVersion)"
show_info "Kernel: $(uname -r)"

show_info "Initialising..."
# run within sudo
sudo -v
show_info "Got Sudo and you know it..."

## SYSTEM
show_info "SYSTEM SETTINGS..."

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
sudo systemsetup -setrestartfreeze on

# Show the ~/Library folder
chflags nohidden ~/Library # && xattr -d com.apple.FinderInfo ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Set Timezone to downunder mate.
sudo systemsetup -settimezone "Australia/Melbourne" > /dev/null

# Set language and text formats to Australians mate.
defaults write NSGlobalDomain AppleLanguages -array "en" "au"
defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD"
defaults write NSGlobalDomain AppleMetricUnits -bool true
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Always show scrollbars
# Possible values: `WhenScrolling`, `Automatic` and `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

## DEVICES
show_info "DEVICE SETTINGS..."

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

## FINDER
show_info "FINDER SETTINGS..."

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

## TERMINAL
show_info "TERMINAL SETTINGS..."
# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

## ACTIVITY MONITOR
show_info "ACTIVITY MONITOR SETTINGS..."

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

show_info "Killing affected apps..."

for app in "Activity Monitor" \
	"cfprefsd" \
	"Finder" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done

show_success "DONE, try turning it off & on again before using things! :-)"
