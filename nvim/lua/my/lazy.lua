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
  -- "ap/vim-css-color",
  "tpope/vim-repeat",
  -- "roxma/vim-tmux-clipboard",
  "ono7/null-ls.nvim",
  "onsails/lspkind-nvim",
  "Glench/Vim-Jinja2-Syntax",
  -- "BlakeWilliams/numetal.vim", -- nice colorscheme
  { "catppuccin/nvim",        name = "catppuccin" },
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
  -- "mfussenegger/nvim-dap",
  -- "jay-babu/mason-nvim-dap.nvim",
  "NvChad/nvim-colorizer.lua",
  -- "brenoprata10/nvim-highlight-colors",
  { "sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
  },
  { "numtostr/fterm.nvim" },
  {
    -- npm install -g yarn
    -- or
    -- npm install -g live-server
    'barrett-ruth/live-server.nvim',
    -- build = 'yarn global add live-server',
    build = 'npm install -g live-server',
    config = true
  },
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
      "dcampos/nvim-snippy",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp-signature-help",
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
  {
    "numToStr/Comment.nvim",
    opts = {},
    setup = function()
      require("comment").setup({})
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- config = function()
    --   require('plugins.treesitter')
    -- end,
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      -- {
      --   "lukas-reineke/indent-blankline.nvim",
      --   setup = function()
      --     require "indent_blankline".setup {
      --       space_char_blankline = " ",
      --       show_current_context = true,
      --       show_current_context_start = true,
      --       show_trailing_blankline_indent = false,
      --     }
      --   end
      -- },
    },
  },
  -- {
  --   "kiyoon/treesitter-indent-object.nvim",
  --   keys = {
  --     {
  --       "ai",
  --       "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
  --       mode = { "x", "o" },
  --       desc = "Select context-aware indent (outer)",
  --     },
  --     {
  --       "aI",
  --       "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
  --       mode = { "x", "o" },
  --       desc = "Select context-aware indent (outer, line-wise)",
  --     },
  --     {
  --       "ii",
  --       "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
  --       mode = { "x", "o" },
  --       desc = "Select context-aware indent (inner, partial range)",
  --     },
  --     {
  --       "iI",
  --       "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
  --       mode = { "x", "o" },
  --       desc = "Select context-aware indent (inner, entire range)",
  --     },
  --   },
  -- },
  -- {
  --   'nvimdev/indentmini.nvim',
  --   -- event = 'BufEnter',
  --   config = function()
  --     require("indentmini").setup({
  --       char = "│",
  --       exclude = {
  --         "markdown",
  --       }
  --     })
  --     -- use comment color
  --     vim.cmd.highlight("default link IndentLine Comment")
  --   end,
  -- },
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
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  "folke/neodev.nvim",
}, {})
