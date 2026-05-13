# dotfiles 🛠️

> Reproducible Mac setup for software engineers — single command bootstrap.

## Quick start

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tonyyates/dotfiles26/master/bootstrap.sh)"
```

That's it. Everything else is automatic.

---

## What gets installed

### Terminal stack
| Tool | Role |
|------|------|
| **zsh** + Oh My Zsh | Shell |
| **Powerlevel10k** | Prompt theme |
| **tmux** + TPM | Terminal multiplexer |
| **Neovim** + LazyVim | Editor |
| **LazyGit** | Git TUI |
| **Yazi** | File manager |
| **fzf** | Fuzzy finder (files, history, processes) |
| **zoxide** | Smart `cd` |

### CLI replacements
| Old | New | Why |
|-----|-----|-----|
| `ls` | `eza` | Icons, git status, tree view |
| `cat` | `bat` | Syntax highlighting, line numbers |
| `find` | `fd` | Faster, friendlier syntax |
| `grep` | `ripgrep` | 10× faster, `.gitignore`-aware |
| `du` | `dust` | Visual disk usage |
| `top` | `btop` | Beautiful resource monitor |
| `ping` | `prettyping` | Animated, colourful |
| `cd` | `zoxide` | Frecency-based smart jumps |
| `git diff` | `delta` | Side-by-side, syntax-highlighted diffs |

### Dev toolchain
- `asdf` — manages Node, Python, Ruby, etc. versions
- `direnv` — per-project `.envrc` support
- `uv` — fast Python package manager
- `gh` — GitHub CLI
- `mkcert` — local HTTPS certs

---

## Adding packages incrementally

### From the terminal (auto-appends to Brewfile):
```bash
binstall ripgrep          # brew install + append
bcask tableplus           # brew install --cask + append
bmas "Things 3"           # mas install + append
dotfiles-add tap homebrew/cask-fonts  # add a tap
```

### Manual (then commit):
```bash
echo 'brew "some-tool"' >> ~/.dotfiles/Brewfile
cd ~/.dotfiles && git add Brewfile && git commit -m "add: some-tool"
```

### Apply Brewfile on another machine:
```bash
brew bundle --file=~/.dotfiles/Brewfile
```

---

## Directory structure

```
dotfiles/
├── bootstrap.sh              # One-command setup
├── Brewfile                  # All packages
├── config/                   # Stowed to $HOME
│   ├── .zshrc
│   ├── .gitconfig
│   ├── .gitignore_global
│   └── .config/
│       ├── tmux/tmux.conf
│       ├── nvim/
│       │   └── lua/
│       │       ├── config/
│       │       │   ├── options.lua
│       │       │   └── keymaps.lua
│       │       └── plugins/
│       │           └── extras.lua
│       ├── lazygit/config.yml
│       └── yazi/yazi.toml
└── scripts/
    ├── macos-defaults.sh     # Sensible macOS settings
    ├── git-setup.sh          # Git identity + SSH key
    └── symlink.sh            # Fallback if stow fails
```

---

## tmux cheatsheet

Prefix: `Ctrl-a`

| Shortcut | Action |
|----------|--------|
| `prefix + \|` | Split horizontal |
| `prefix + -` | Split vertical |
| `prefix + c` | New window |
| `Ctrl + h/j/k/l` | Navigate panes (no prefix needed) |
| `Alt + h/l` | Switch windows |
| `prefix + r` | Reload config |
| `prefix + I` | Install plugins (TPM) |
| `prefix + [` | Enter copy mode (vim keys) |

---

## Neovim cheatsheet

Leader: `Space`

| Shortcut | Action |
|----------|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>e` | Open Yazi file manager |
| `<leader>ha` | Harpoon: add file |
| `<leader>1-4` | Harpoon: jump to file |
| `<leader>u` | Undo tree |
| `<C-s>` | Save |
| `jk` / `jj` | Exit insert mode |
| `<S-h>` / `<S-l>` | Previous/next buffer |

---

## After bootstrap

1. Run `p10k configure` to set up your prompt style
2. Open tmux → `prefix + I` to install plugins
3. Open `nvim` → wait for LazyVim to install plugins
4. Add your git identity if prompted
5. Upload your SSH key to GitHub (script opens the page)
6. Customise `~/.zshrc.local` for machine-specific settings (not tracked)

---

## Updating

```bash
cd ~/.dotfiles
git pull
brew bundle --file=Brewfile  # sync packages
```

---

## Philosophy

- **One command** to go from zero to productive
- **Git-tracked** — every change is auditable
- **Idempotent** — safe to run multiple times
- **Modular** — comment out anything you don't want
- **Incremental** — adding a new tool takes one command
