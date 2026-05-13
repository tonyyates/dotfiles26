#!/usr/bin/env bash
# =============================================================================
# scripts/symlink.sh — Manual symlink fallback (used if stow fails)
# =============================================================================
set -euo pipefail

DOTFILES="$HOME/.dotfiles/config"

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "${dst}.backup.$(date +%s)"
    echo "  Backed up: $dst"
  fi
  ln -sfn "$src" "$dst"
  echo "  Linked: $dst → $src"
}

link "$DOTFILES/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILES/.gitignore_global" "$HOME/.gitignore_global"
link "$DOTFILES/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/.config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
link "$DOTFILES/.config/nvim/lua/config/options.lua" "$HOME/.config/nvim/lua/config/options.lua"
link "$DOTFILES/.config/nvim/lua/config/keymaps.lua" "$HOME/.config/nvim/lua/config/keymaps.lua"
link "$DOTFILES/.config/nvim/lua/plugins/extras.lua" "$HOME/.config/nvim/lua/plugins/extras.lua"

echo ""
echo "  ✓ Symlinks created"
