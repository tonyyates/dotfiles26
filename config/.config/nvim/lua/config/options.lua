-- =============================================================================
-- ~/.config/nvim/lua/config/options.lua
-- LazyVim config — place this file after running: git clone lazyvim/starter
-- =============================================================================

local opt = vim.opt

-- ── UI ────────────────────────────────────────────────────────────────────────
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.conceallevel = 2           -- for markdown, obsidian etc

-- ── Indentation ───────────────────────────────────────────────────────────────
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

-- ── Search ────────────────────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- ── Files ─────────────────────────────────────────────────────────────────────
opt.undofile = true
opt.backup = false
opt.swapfile = false

-- ── Performance ───────────────────────────────────────────────────────────────
opt.updatetime = 200
opt.timeoutlen = 300

-- ── Clipboard ────────────────────────────────────────────────────────────────
opt.clipboard = "unnamedplus"  -- use system clipboard

-- ── Mouse ─────────────────────────────────────────────────────────────────────
opt.mouse = "a"
