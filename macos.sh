#!/usr/bin/env bash
# macOS system preferences. Run manually on a new Mac; safe to re-run.
set -euo pipefail

echo "==> Keyboard"
defaults write -g KeyRepeat -int 2
defaults write -g InitialKeyRepeat -int 25

echo "==> Screenshots"
mkdir -p "$HOME/Pictures/SS"
defaults write com.apple.screencapture location "$HOME/Pictures/SS"
defaults write com.apple.screencapture name ss

echo "==> Finder"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true   # show all filename extensions
defaults write com.apple.finder AppleShowAllFiles -bool true      # show hidden files

killall Finder SystemUIServer 2>/dev/null || true

cat <<'MSG'

Done. Log out and back in for the key repeat settings to take effect.
MSG
