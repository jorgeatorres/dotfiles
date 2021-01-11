#!/bin/sh
# Sets various macOS config settings.

# Menubar.
defaults write com.apple.menuextra.battery ShowPercent -string "YES" # Show battery %.

# Finder.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # Column view.
defaults write com.apple.finder NewWindowTarget -string "PfHm" # New finder windows open home folder.
defaults write com.apple.finder NewWindowTargetPath -string "file:///${HOME}/"

# Dock
defaults write com.apple.dock autohide -bool true # Auto-hide.
defaults write com.apple.dock tilesize -int 33 # Dock size.
defaults delete com.apple.dock persistent-apps # Clear out of persistent apps.
defaults write com.apple.dock show-recents -bool false # Don't show recent apps.
defaults write com.apple.dock magnification -int 0 # Disable magnification.

# Trackpad.
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # Tap to click.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true # Right click.
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true # Drag lock.
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
