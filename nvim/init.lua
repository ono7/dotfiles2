-- Follow the white rabbit...

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local indent = 2

-- providers
g.python3_host_prog = os.getenv("HOME") .. "/.virtualenvs/prod3/bin/python3"
g.loaded_python_provider =0
g.loaded_perl_provider =0
g.loaded_ruby_provider =0

-- load custom setup
require("keymaps")
require("settings")
require("utils")
-- require("autocmds")

-- color and syntax related
cmd "colorscheme onehalfdark"
cmd "syntax enable"
cmd "syntax sync minlines=256"
cmd "syntax sync maxlines=300"
cmd "syntax on"

g.mapleader = " "
g.vimsyn_embed = "l"

-- auto install paq if not exists
local install_path = fn.stdpath("data") .. "/site/pack/paqs/opt/paq-nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  cmd("!git clone https://github.com/savq/paq-nvim.git " .. install_path)
end

-- setup paq
vim.cmd 'packadd paq-nvim'         
local paq = require'paq-nvim'.paq 

-- plugins
paq {'savq/paq-nvim', opt=true}   
paq 'ervandew/supertab'
paq 'christoomey/vim-tmux-navigator'
paq 'tpope/vim-commentary'
paq 'tpope/vim-eunuch'
paq 'tpope/vim-markdown'
paq 'kyazdani42/nvim-web-devicons'
paq 'windwp/nvim-autopairs' -- testing for speed...
-- paq 'jiangmiao/auto-pairs'
paq 'akinsho/nvim-bufferline.lua'
paq 'nvim-treesitter/nvim-treesitter'
paq 'lukas-reineke/format.nvim'

-- init lua plugins
require'nvim-autopairs'.setup{}
require'nvim-web-devicons'.setup{}
-- require'bufferline'.setup{}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "rust" },  -- list of language that will be disabled
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  },
}

require "format".setup {
  -- lukas-reineke/format.nvim
  -- https://github.com/lukas-reineke/format.nvim
  -- :h format.txt

  -- npm install lua-fmt prettier -g
  -- pip install black, pylint, epdb, ipython
  -- autocmd BufWritePost * FormatWrite

  vim = {
    {
      cmd = {"luafmt -i 2 -w replace"},
      -- start_pattern = "^lua << EOF$",
      -- end_pattern = "^EOF$"
    }
  },
  lua = {
    {
      cmd = {
        function(file)
          return string.format("luafmt -i 2 -l %s -w replace %s", vim.bo.textwidth, file)
        end
      }
    }
  },
  python = {
    {
      cmd = {
        "black"
      }
    }
  },
  json = {
    {
      cmd = {"prettier -w --parser json"}
    }
  },
  typescript = {
    {
      cmd = {"prettier -w --parser typescript --single-quote"}
    }
  },
  yaml = {
    {
      cmd = {"prettier -w --parser yaml --single-quote --quote-props preserve"}
    }
  },
  vimwiki = {
    {
      cmd = {"prettier -w --parser babel"},
      start_pattern = "^{{{javascript$",
      end_pattern = "^}}}$",
      target = "current"
    },
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^{{{lua$",
      end_pattern = "^}}}$",
      target = "current"
    },
    {
      cmd = {"black"},
      start_pattern = "^{{{python$",
      end_pattern = "^}}}$",
      target = "current"
    }
  },
  javascript = {
    {cmd = {"prettier -w --single-quote", "eslint --fix"}}
  },
  markdown = {
    {cmd = {"prettier -w"}},
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^```lua$",
      end_pattern = "^```$",
      target = "current"
      -- current only format where cursor is
    }
  }
}
-- Plug 'Glench/Vim-Jinja2-Syntax', { 'for' : 'jinja' }
-- Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
-- Plug 'junegunn/fzf.vim'
-- Plug 'tpope/vim-surround'
-- Plug 'tpope/vim-repeat'
-- Plug 'tpope/vim-markdown', {'for' : 'markdown'}
-- Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
-- Plug 'vimwiki/vimwiki'


