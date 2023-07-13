local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "tpope/vim-repeat",
  -- "roxma/vim-tmux-clipboard",
  -- "jose-elias-alvarez/null-ls.nvim",
  "onsails/lspkind-nvim",
  "Glench/Vim-Jinja2-Syntax",
  -- "BlakeWilliams/numetal.vim", -- nice colorscheme
  { "catppuccin/nvim",     name = "catppuccin" },
  "numtostr/navigator.nvim",
  -- "bfredl/nvim-miniyank",
  "kylechui/nvim-surround",
  -- {
  --   "utilyre/sentiment.nvim",
  --   version = "*",
  --   event = "VeryLazy", -- keep for lazy loading
  --   opts = {
  --     delay = 50,
  --   },
  --   init = function()
  --     -- `matchparen.vim` needs to be disabled manually in case of lazy loading
  --     vim.g.loaded_matchparen = 1
  --   end,
  -- },

  {
    'monkoose/matchparen.nvim',
    config = function()
      require('matchparen').setup({
        on_startup = true,       -- Should it be enabled by default
        hl_group = 'MatchParen', -- highlight group of the matched brackets
        debounce_time = 10,      -- debounce time in milliseconds for rehighlighting of brackets.
      })
    end
  },
  "dcampos/nvim-snippy",
  -- "mfussenegger/nvim-dap",
  -- "jay-babu/mason-nvim-dap.nvim",
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require 'colorizer'.setup()
    end
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
  },
  { "numtostr/fterm.nvim", opts = {} },
  {
    "f-person/git-blame.nvim",
    config = function()
      vim.g.gitblame_enabled = 0
    end,
  },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      -- "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      -- "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  { "numToStr/Comment.nvim",   opts = {} },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      -- pcall(require("nvim-treesitter.install").update({ with_sync = true }))
      -- require('nvim-treesitter')
      require('plugins.treesitter')
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        max_lines = 1,
      })
      vim.keymap.set("n", "[c", function()
        require("treesitter-context").go_to_context()
      end, { silent = true })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  "folke/neodev.nvim",
}, {})
