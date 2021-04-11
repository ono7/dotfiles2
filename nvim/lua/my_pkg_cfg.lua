--- locals ---
local m = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

if vim.g.loaded_paq then
  --- autopairs ---
  require("nvim-autopairs").setup()

  --- tmux navigator, in lua ---
  require("Navigator").setup(
    {
      disable_on_zoom = true
    }
  )
  m("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opt)
  m("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opt)
  m("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opt)
  m("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opt)

  --- comments ---
  require("kommentary.config").configure_language(
    "default",
    {
      prefer_single_line_comments = true,
      use_consistent_indentation = true,
      ignore_whitespace = true
    }
  )

  --- sweet sweet icons for ntree ---
  require "nvim-web-devicons".setup {
    default = true
  }

  --- treesitter setup ---
  require "nvim-treesitter.configs".setup {
    highlight = {
      enable = true
      -- disable = { 'c', 'rust' },
    },
    incremental_selection = {
      enable = true,
      -- disable = { 'cpp', 'lua' },
      keymaps = {
        node_incremental = "grn",
        scope_incremental = "grc"
      }
    },
    ensure_installed = {"c", "cpp", "lua", "python", "javascript"},
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,
      persist_queries = false
    }
  }

  --- formatting ---
  require "format".setup {
    --[[

    lukas-reineke/format.nvim
    https://github.com/lukas-reineke/format.nvim
    :h format.txt

    npm install lua-fmt prettier -g
    pip install black pylint epdb ipython

  --]]
    lua = {
      {
        cmd = {
          function(file)
            return string.format("luafmt -i 2 -w replace %s", file)
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
        cmd = {
          "prettier -w --parser json"
        }
      }
    },
    typescript = {
      {
        cmd = {
          "prettier -w --parser typescript --single-quote"
        }
      }
    },
    yaml = {
      {
        cmd = {
          "prettier -w --parser yaml --single-quote --quote-props preserve"
        }
      }
    },
    vimwiki = {
      {
        cmd = {
          "prettier -w"
        }
      },
      {
        cmd = {
          "luafmt -i 2 -w replace"
        },
        start_pattern = "^{{{lua$",
        end_pattern = "^}}}$",
        target = "current"
      },
      {
        cmd = {
          "black"
        },
        start_pattern = "^{{{python$",
        end_pattern = "^}}}$",
        target = "current"
      }
    },
    javascript = {
      {
        cmd = {
          "prettier -w"
          -- "eslint --fix"
        }
      }
    },
    markdown = {
      {
        cmd = {
          "prettier -w"
        }
      },
      {
        cmd = {
          "luafmt -i 2 -w replace"
        },
        start_pattern = "^```lua$",
        end_pattern = "^```$",
        target = "current"
        -- current only format where cursor is
      },
      {
        cmd = {
          "prettier -w --parser babel --single-quote"
        },
        start_pattern = "^```javascript$",
        end_pattern = "^```$",
        target = "current"
      },
      {
        cmd = {
          "black"
        },
        start_pattern = "^```python$",
        end_pattern = "^```$",
        target = "current"
      }
    }
  }
end
