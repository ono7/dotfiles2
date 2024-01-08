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
  "tpope/vim-fugitive",
  "nvimtools/none-ls.nvim",
  "onsails/lspkind-nvim",
  "Glench/Vim-Jinja2-Syntax",
  "ThePrimeagen/git-worktree.nvim",
  -- "BlakeWilliams/numetal.vim", -- nice colorscheme
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  -- {
  --   "stevearc/oil.nvim",
  --   config = function()
  --     require("oil").setup({
  --       default_file_explorer = false
  --     })
  --     vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  --   end
  -- },
  { "catppuccin/nvim",        name = "catppuccin" },
  {
    "folke/trouble.nvim",
    config = function()
      vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
    end
  },
  "kylechui/nvim-surround",
  -- {
  --   'monkoose/matchparen.nvim',
  --   config = function()
  --     require('matchparen').setup({
  --       on_startup = true,       -- Should it be enabled by default
  --       hl_group = 'MatchParen', -- highlight group of the matched brackets
  --       debounce_time = 10,      -- debounce time in milliseconds for rehighlighting of brackets.
  --     })
  --   end
  -- },
  --- dap goods ---
  "mfussenegger/nvim-dap",
  "mfussenegger/nvim-dap-python",
  "jay-babu/mason-nvim-dap.nvim",
  "leoluz/nvim-dap-go",
  "rcarriga/nvim-dap-ui",
  "thehamsta/nvim-dap-virtual-text",
  -- "ThePrimeagen/harpoon",
  "NvChad/nvim-colorizer.lua",
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
      vim.keymap.set("n", "<m-/>", '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
      vim.keymap.set("t", "<m-/>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
        { noremap = true, silent = true })
    end
  },
  -- {
  --   "f-person/git-blame.nvim",
  --   config = function()
  --     require('gitblame').setup {
  --       --Note how the `gitblame_` prefix is omitted in `setup`
  --       enabled = false,
  --     }
  --   end,
  -- },
  -- { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
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
    "nvim-treesitter/nvim-treesitter-textobjects",
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
    -- branch = "v3.x",
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
