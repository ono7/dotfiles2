local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local esc = vim.api.nvim_replace_termcodes(
  '<ESC>', true, false, true
)

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
  "ono7/null-ls.nvim",
  "onsails/lspkind-nvim",
  "Glench/Vim-Jinja2-Syntax",
  -- "BlakeWilliams/numetal.vim", -- nice colorscheme
  { "catppuccin/nvim",        name = "catppuccin" },
  -- "numtostr/navigator.nvim",
  "kylechui/nvim-surround",
  "SmiteshP/nvim-navic",
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
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --     vim.keymap.set(
  --       "n",
  --       ",t",
  --       require("lsp_lines").toggle,
  --       { desc = "Toggle lsp_lines" }
  --     )
  --     -- vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
  --     vim.diagnostic.config({ virtual_lines = true })
  --   end,
  -- },
  -- {
  --   "fgheng/winbar.nvim"
  -- },
  -- "mfussenegger/nvim-dap",
  -- "jay-babu/mason-nvim-dap.nvim",
  'ThePrimeagen/harpoon',
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
  {
    "numtostr/fterm.nvim",
    opts = {},
    config = function()
      require('FTerm').setup {
        dimensions = {
          height = 0.9,
          width = 0.9,
        }
      }
      vim.keymap.set("n", "<c-t>", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
      vim.keymap.set("t", "<c-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
    end
  },
  -- {
  --   -- npm install -g yarn
  --   -- or
  --   -- npm install -g live-server
  --   -- npm install -g nodemon
  --   -- nodemon --exec go run main.go --signal SIGTERM
  --   'barrett-ruth/live-server.nvim',
  --   -- build = 'yarn global add live-server',
  --   build = 'npm install -g live-server',
  --   config = true
  -- },
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
    config = function()
      local ft = require("Comment.ft")
      local api = require("Comment.api")
      ft.jinja = { '{#%s#}', '{#%s#}' }
      ft.text = { '#%s', '#%s#' }
      require('Comment').setup({ ignore = "^$" })
      vim.keymap.set("n", "<C-c>", function() api.toggle.linewise.current() end,
        { noremap = true, silent = true })
      vim.keymap.set('x', '<C-c>', function()
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.toggle.linewise(vim.fn.visualmode())
      end)
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
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    "kiyoon/treesitter-indent-object.nvim",
    -- keys = {
    --   {
    --     "ai",
    --     "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>",
    --     mode = { "x", "o" },
    --     desc = "Select context-aware indent (outer)",
    --   },
    --   {
    --     "aI",
    --     "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>",
    --     mode = { "x", "o" },
    --     desc = "Select context-aware indent (outer, line-wise)",
    --   },
    --   {
    --     "ii",
    --     "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>",
    --     mode = { "x", "o" },
    --     desc = "Select context-aware indent (inner, partial range)",
    --   },
    --   {
    --     "iI",
    --     "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>",
    --     mode = { "x", "o" },
    --     desc = "Select context-aware indent (inner, entire range)",
    --   },
    -- },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   config = function()
  --     require("treesitter-context").setup({
  --       max_lines = 1,
  --     })
  --     vim.keymap.set("n", "[c", function()
  --       require("treesitter-context").go_to_context()
  --     end, { silent = true })
  --   end,
  -- },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end
  },
  "folke/neodev.nvim",
}, {})
