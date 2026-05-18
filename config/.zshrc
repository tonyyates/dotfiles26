# =============================================================================
# ~/.zshrc — Sourced by dotfiles stow from config/.zshrc
# =============================================================================

# ── Oh My Zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  gh
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
  docker
  kubectl
  fzf
  direnv
  asdf
)

source "$ZSH/oh-my-zsh.sh"

# ── Powerlevel10k ─────────────────────────────────────────────────────────────
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── Homebrew (Apple Silicon) ──────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── PATH ──────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# ── Environment ───────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"

# fzf — use ripgrep as the default command
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ── Aliases: Navigation ───────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# ── Aliases: ls → eza ────────────────────────────────────────────────────────
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza --tree --icons --level=2'
alias la='eza -a --icons'

# ── Aliases: cat → bat ───────────────────────────────────────────────────────
alias cat='bat --paging=never'
alias catt='/bin/cat'  # escape hatch

# ── Aliases: Git ──────────────────────────────────────────────────────────────
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gs='git status -sb'
alias lg='lazygit'

# ── Aliases: Docker ───────────────────────────────────────────────────────────
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'

# ── Aliases: Kubernetes ───────────────────────────────────────────────────────
alias k='kubectl'
alias kctx='kubectx'
alias kns='kubens'

# ── Aliases: Misc ─────────────────────────────────────────────────────────────
alias vi='nvim'
alias vim='nvim'
alias ping='prettyping --nolegend'
alias df='dust'
alias top='btop'
alias http='httpie'
alias reload='exec zsh'
alias dotfiles='cd ~/.dotfiles'

# ── Brewfile helper: auto-append when you brew install ───────────────────────
# Usage: binstall <package>   — installs AND appends to Brewfile
# Usage: bcask <package>      — cask install AND appends to Brewfile
binstall() {
  brew install "$@" && \
    echo "brew \"$1\"" >> "$HOME/.dotfiles/Brewfile" && \
    echo "✓ Added 'brew \"$1\"' to Brewfile"
}
bcask() {
  brew install --cask "$@" && \
    echo "cask \"$1\"" >> "$HOME/.dotfiles/Brewfile" && \
    echo "✓ Added 'cask \"$1\"' to Brewfile"
}
bmas() {
  local id=$(mas search "$1" | head -1 | awk '{print $1}')
  mas install "$id" && \
    echo "mas \"$1\", id: $id" >> "$HOME/.dotfiles/Brewfile" && \
    echo "✓ Added MAS app '$1' (id: $id) to Brewfile"
}

# ── Functions: useful dev helpers ─────────────────────────────────────────────
# fcd: fuzzy-find and cd into a directory
fcd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git 2>/dev/null | fzf +m) && cd "$dir"
}

# fkill: fuzzy kill a process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  [ -n "$pid" ] && echo "$pid" | xargs kill -${1:-9}
}

# mkcd: mkdir + cd
mkcd() { mkdir -p "$1" && cd "$1" }

# serve: quick http server in current directory
serve() { python3 -m http.server "${1:-8000}" }

# ports: show what's listening
ports() { lsof -iTCP -sTCP:LISTEN -n -P }

# dotfiles-add: generic Brewfile appender with deduplication
dotfiles-add() {
  local type="$1" pkg="$2"
  local brewfile="$HOME/.dotfiles/Brewfile"
  local entry
  case "$type" in
    brew)  entry="brew \"$pkg\"" ;;
    cask)  entry="cask \"$pkg\"" ;;
    mas)   entry="mas \"$pkg\", id: $3" ;;
    tap)   entry="tap \"$pkg\"" ;;
    *)     echo "Usage: dotfiles-add [brew|cask|mas|tap] <package> [mas-id]"; return 1 ;;
  esac
  if grep -qF "$entry" "$brewfile"; then
    echo "Already in Brewfile: $entry"
  else
    echo "$entry" >> "$brewfile"
    echo "✓ Appended to Brewfile: $entry"
  fi
}

# ── zoxide (smarter cd) ───────────────────────────────────────────────────────
eval "$(zoxide init zsh --cmd cd)"

# ── direnv ────────────────────────────────────────────────────────────────────
eval "$(direnv hook zsh)"

# ── asdf ─────────────────────────────────────────────────────────────────────
[[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]] && \
  source /opt/homebrew/opt/asdf/libexec/asdf.sh

# ── fzf completions ───────────────────────────────────────────────────────────
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
source <(fzf --zsh) 2>/dev/null || true

# ── Local overrides (not tracked in git) ─────────────────────────────────────
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
