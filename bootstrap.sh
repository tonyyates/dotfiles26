#!/usr/bin/env bash
# =============================================================================
# bootstrap.sh — Single command Mac setup
# Usage: /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/YOU/dotfiles/main/bootstrap.sh)"
# =============================================================================
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/tonyyates/dotfiles26.git" # <-- Change this

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'
info() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }
section() {
  echo -e "\n${YELLOW}══════════════════════════════════════${NC}"
  echo -e "${YELLOW}  $1${NC}"
  echo -e "${YELLOW}══════════════════════════════════════${NC}"
}

# ── 1. Xcode Command Line Tools ───────────────────────────────────────────────
section "Xcode Command Line Tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  warn "Xcode CLT install triggered — rerun bootstrap.sh after it completes"
  exit 0
else
  info "Xcode CLT already installed"
fi

# ── 2. Homebrew ───────────────────────────────────────────────────────────────
section "Homebrew"
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Apple Silicon path
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  info "Homebrew already installed"
  brew update
fi

# ── 3. Clone dotfiles ─────────────────────────────────────────────────────────
section "Dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  info "Cloning dotfiles..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  info "Dotfiles already cloned — pulling latest..."
  git -C "$DOTFILES_DIR" pull
fi

# ── 4. Homebrew Bundle ────────────────────────────────────────────────────────
section "Homebrew Bundle"
info "Installing all packages from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock

# ── 5. Stow symlinks ─────────────────────────────────────────────────────────
section "Symlinking config files"
brew install stow 2>/dev/null || true
cd "$DOTFILES_DIR"
stow --target="$HOME" --restow config 2>/dev/null || {
  warn "stow conflict — using manual symlinks fallback"
  bash "$DOTFILES_DIR/scripts/symlink.sh"
}

# ── 6. Shell: Zsh + Oh My Zsh ────────────────────────────────────────────────
section "Zsh / Oh My Zsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
# Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi
# Plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] &&
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ ! -d "$ZSH_CUSTOM/plugins/zsh-z" ] &&
  git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM/plugins/zsh-z"

# ── 7. Neovim: LazyVim ───────────────────────────────────────────────────────
section "Neovim / LazyVim"
NVIM_CONFIG="$HOME/.config/nvim"
if [ ! -f "$NVIM_CONFIG/lua/config/lazy.lua" ]; then
  info "Bootstrapping LazyVim..."
  # Backup existing config
  [ -d "$NVIM_CONFIG" ] && mv "$NVIM_CONFIG" "${NVIM_CONFIG}.bak.$(date +%s)"
  git clone https://github.com/LazyVim/starter "$NVIM_CONFIG"
  rm -rf "$NVIM_CONFIG/.git"
fi

# ── 8. tmux: TPM ─────────────────────────────────────────────────────────────
section "tmux / TPM"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  info "Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
info "Run: tmux, then prefix + I to install plugins"

# ── 9. macOS system defaults ──────────────────────────────────────────────────
section "macOS Defaults"
bash "$DOTFILES_DIR/scripts/macos-defaults.sh"

# ── 10. Git config ────────────────────────────────────────────────────────────
section "Git"
bash "$DOTFILES_DIR/scripts/git-setup.sh"

# ── Done ──────────────────────────────────────────────────────────────────────
section "🎉  Bootstrap complete!"
echo ""
echo "  Next steps:"
echo "  1. Edit $DOTFILES_DIR/Brewfile and re-run: brew bundle"
echo "  2. Restart your terminal (or: exec zsh)"
echo "  3. Open tmux → prefix + I to install plugins"
echo "  4. Open nvim → wait for LazyVim to install plugins"
echo "  5. Run: p10k configure  (if you want to reconfigure the prompt)"
echo ""
