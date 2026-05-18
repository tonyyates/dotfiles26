-- =============================================================================
-- ~/.config/nvim/lua/config/keymaps.lua
-- =============================================================================
local map = vim.keymap.set

-- ── Leader ───────────────────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ── Better escape ────────────────────────────────────────────────────────────
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
map("i", "jj", "<ESC>", { desc = "Exit insert mode" })

-- ── Window navigation ─────────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- ── Move lines ────────────────────────────────────────────────────────────────
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── Buffers ───────────────────────────────────────────────────────────────────
map("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- ── Better indenting ─────────────────────────────────────────────────────────
map("v", "<", "<gv", { desc = "Unindent and reselect" })
map("v", ">", ">gv", { desc = "Indent and reselect" })

-- ── LazyGit ──────────────────────────────────────────────────────────────────
map("n", "<leader>gg", function()
  require("lazygit").lazygit()
end, { desc = "LazyGit" })

-- ── Clear search highlight ────────────────────────────────────────────────────
map("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- ── Quick save ────────────────────────────────────────────────────────────────
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save file" })

-- ── Yazi file manager ────────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Yazi<CR>", { desc = "Open Yazi file manager" })

-- ── Diagnostic navigation ────────────────────────────────────────────────────
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
