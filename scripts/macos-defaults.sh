#!/usr/bin/env bash
# =============================================================================
# scripts/macos-defaults.sh — Sensible macOS defaults for developers
# Run once after bootstrap; some changes require a logout/restart
# =============================================================================
set -euo pipefail

echo "  Setting macOS defaults..."

# ── System ────────────────────────────────────────────────────────────────────
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable automatic capitalization
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes and quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Key repeat: fast (minimum delay + fast rate for vim-style navigation)
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ── Trackpad ─────────────────────────────────────────────────────────────────
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Finder ────────────────────────────────────────────────────────────────────
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Search in current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# ── Dock ─────────────────────────────────────────────────────────────────────
# Icon size
defaults write com.apple.dock tilesize -int 48

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# ── Screenshots ───────────────────────────────────────────────────────────────
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# ── Safari / WebKit ───────────────────────────────────────────────────────────
# Enable developer tools
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# ── Activity Monitor ─────────────────────────────────────────────────────────
# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# Update frequency: 2 seconds
defaults write com.apple.ActivityMonitor UpdatePeriod -int 2

# ── TextEdit ─────────────────────────────────────────────────────────────────
# Use plain text mode by default
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# ── App Store ─────────────────────────────────────────────────────────────────
# Auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# ── Restart affected apps ─────────────────────────────────────────────────────
for app in "Finder" "Dock" "SystemUIServer" "cfprefsd"; do
  killall "$app" &>/dev/null || true
done

echo "  ✓ macOS defaults applied (some changes require logout/restart)"
