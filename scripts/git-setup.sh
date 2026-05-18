#!/usr/bin/env bash
# =============================================================================
# scripts/git-setup.sh — Configure git user identity
# =============================================================================
set -euo pipefail

if [ -z "$(git config --global user.name 2>/dev/null)" ]; then
  echo ""
  read -rp "  Git user name: " git_name
  git config --global user.name "$git_name"
fi

if [ -z "$(git config --global user.email 2>/dev/null)" ]; then
  read -rp "  Git user email: " git_email
  git config --global user.email "$git_email"
fi

echo "  ✓ Git configured for: $(git config --global user.name) <$(git config --global user.email)>"

# Set up SSH key if none exists
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  echo ""
  echo "  No SSH key found. Generating one..."
  ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f "$HOME/.ssh/id_ed25519" -N ""
  eval "$(ssh-agent -s)"
  /usr/bin/ssh-add --apple-use-keychain "$HOME/.ssh/id_ed25519"
  echo ""
  echo "  ✓ SSH key generated. Add this to GitHub:"
  echo "  ────────────────────────────────────────"
  cat "$HOME/.ssh/id_ed25519.pub"
  echo "  ────────────────────────────────────────"
  echo "  Opening GitHub SSH settings..."
  open "https://github.com/settings/ssh/new"
fi
