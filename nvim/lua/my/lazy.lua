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
  {
    "tpope/vim-fugitive",
    config = function()
      vim.cmd [[hi! diffAdded ctermfg=188 ctermbg=64 cterm=bold guifg=#50FA7B guibg=NONE gui=bold]]
      vim.cmd [[hi! diffRemoved ctermfg=88 ctermbg=NONE cterm=NONE guifg=#FA5057 guibg=NONE gui=NONE]]
    end
  },
  "nvimtools/none-ls.nvim",
  "onsails/lspkind-nvim",
  "Glench/Vim-Jinja2-Syntax",
  { "ellisonleao/gruvbox.nvim", priority = 1000,    config = true, opts = ... },
  { "catppuccin/nvim",          name = "catppuccin" },
  {
    "folke/trouble.nvim",
    config = function()
      vim.keymap.set("n", "<leader>xx", function() require("trouble").open() end)
    end
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require "plugins.surround"
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {

      "mfussenegger/nvim-dap-python",
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "thehamsta/nvim-dap-virtual-text",
    }
  },
  "ThePrimeagen/harpoon",
  "NvChad/nvim-colorizer.lua",
  { "sindrets/diffview.nvim",         dependencies = { "nvim-lua/plenary.nvim" } },
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
    config = function()
      require "plugins.lsp.cmp"
    end
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
  -- {
  --   "numToStr/Comment.nvim",
  --   opts = {},
  --   config = function()
  --     local ft = require("Comment.ft")
  --     local api = require("Comment.api")
  --     ft.jinja = { '{#%s#}', '{#%s#}' }
  --     ft.text = { '#%s', '#%s#' }
  --     ft.txt = { '#%s', '#%s#' }
  --     require('Comment').setup({ ignore = "^$" })
  --     vim.keymap.set("n", "<C-c>", function() api.toggle.linewise.current() end,
  --       { noremap = true, silent = true })
  --     vim.keymap.set('x', '<C-c>', function()
  --       vim.api.nvim_feedkeys(esc, 'nx', false)
  --       api.toggle.linewise(vim.fn.visualmode())
  --     end)
  --   end
  -- },
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "plugins.telescope"
    end
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable("make") == 1
    end,
  },
  { "smartpde/telescope-recent-files" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require "plugins.treesitter"
    end
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
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
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

  "ixru/nvim-markdown",
  "folke/neodev.nvim",
}, {})
