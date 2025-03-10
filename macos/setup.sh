#!/bin/bash

# Some options can be found
# https://mynixos.com/options/system
# $ defaults read
# https://github.com/kevinSuttle/macOS-Defaults/blob/master/REFERENCE.md


# Check if duti is installed 
if command -v duti &> /dev/null; then
    # Set Zed as the default application for text files
    echo "Setting up default applications..."
    duti -s dev.zed.Zed .txt all
    duti -s dev.zed.Zed .json all
    duti -s dev.zed.Zed .md all
    duti -s dev.zed.Zed .yaml all
else
    echo "Warning: duti is not installed. File associations for Zed couldn't be set."
    echo "Install duti with 'brew install duti' to set default applications."
fi

# Dock settings

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0
# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false




# Finder settings
#
# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Trackpad settings
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

# Global domain settings
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
defaults write NSGlobalDomain "com.apple.keyboard.fnState" -bool true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Screenshot settings
defaults write com.apple.screencapture location -string "$HOME/Pictures/screenshots"
defaults write com.apple.screencapture show-thumbnail -bool false

# Spaces settings (Aerospace)
defaults write com.apple.spaces spans-displays -int 0

# Dock expose settings (Aerospace)
defaults write com.apple.dock expose-group-apps -int 0

# Restart affected applications
killall Finder
killall Dock
killall SystemUIServer


echo "macOS settings have been updated. Some changes may require a logout/restart to take effect."
