#!/usr/bin/env bash
# Run this after cloning to initialize git and make scripts executable
cd "$(dirname "$0")"
git init
git add -A
git commit -m "chore: initial dotfiles setup"
chmod +x bootstrap.sh scripts/*.sh
echo "✓ Ready — push to GitHub then update DOTFILES_REPO in bootstrap.sh"
