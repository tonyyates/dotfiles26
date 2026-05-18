-- =============================================================================
-- ~/.config/nvim/lua/plugins/extras.lua
-- Additional plugins on top of LazyVim defaults
-- =============================================================================

return {
  -- ── Colorscheme: Tokyo Night ────────────────────────────────────────────────
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- ── LazyGit integration ─────────────────────────────────────────────────────
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
  },

  -- ── Yazi file manager ──────────────────────────────────────────────────────
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>e", "<cmd>Yazi<CR>", desc = "Open Yazi" },
      { "<leader>cw", "<cmd>Yazi cwd<CR>", desc = "Open Yazi in cwd" },
    },
    opts = {
      open_for_directories = true,
    },
  },

  -- ── Tmux navigator ─────────────────────────────────────────────────────────
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft", "TmuxNavigateDown",
      "TmuxNavigateUp", "TmuxNavigateRight",
    },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
  },

  -- ── Better code comments ───────────────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    event = "BufReadPost",
  },

  -- ── Harpoon 2: fast file navigation ────────────────────────────────────────
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      local map = vim.keymap.set
      map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
      map("n", "<leader>hh", function() require("telescope").extensions.marks.marks() end, { desc = "Telescope Marks"})
      -- Quick access 1-4
      for i = 1, 4 do
        map("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon file " .. i })
      end
    end,
  },

  -- ── Undotree ───────────────────────────────────────────────────────────────
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
    },
  },

  -- ── Treesitter extra parsers ───────────────────────────────────────────────
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash", "css", "dockerfile", "go", "gomod", "graphql",
        "html", "http", "javascript", "json", "json5", "jsonc",
        "lua", "markdown", "markdown_inline", "python", "regex",
        "rust", "sql", "toml", "tsx", "typescript", "vim", "yaml",
      },
    },
  },

  -- ── LSP: extra servers ────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {},      -- TypeScript
        gopls = {},         -- Go
        rust_analyzer = {}, -- Rust
        pyright = {},       -- Python
        lua_ls = {},        -- Lua
        dockerls = {},      -- Dockerfile
        yamlls = {},        -- YAML
      },
    },
  },

  -- ── Conform: formatting ────────────────────────────────────────────────────
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "ruff_format" },
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        sh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- ── Copilot ────────────────────────────────────────────────────────────────
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },  -- use copilot-cmp instead
      panel = { enabled = false },
    },
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = true,
  },

  -- ── Obsidian: markdown notes ────────────────────────────────────────────────
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*",
  --   event = { "BufReadPre " .. vim.fn.expand("~") .. "/notes/**.md" },
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   opts = {
  --     workspaces = {
  --       { name = "personal", path = "~/notes" },
  --     },
  --   },
  -- },
}
