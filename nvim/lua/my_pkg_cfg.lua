-- locals

local m = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

-- autopairs
require("nvim-autopairs").setup()

-- tmux navigator, in lua
require("Navigator").setup(
  {
    disable_on_zoom = true
  }
)
m("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opt)
m("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opt)
m("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opt)
m("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opt)

-- route nvim lsp diagnostics to ale
require("nvim-ale-diagnostic")
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false
  }
)

-- comments
require("kommentary.config").configure_language(
  "default",
  {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true
  }
)

-- sweet sweet icons for ntree
require "nvim-web-devicons".setup {
  default = true
}

-- better highlighting
require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {
      "rust",
      "json",
      "yaml"
    }
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false -- Whether the query persists across vim sessions
  }
}

require "format".setup {
  --[[

    lukas-reineke/format.nvim
    https://github.com/lukas-reineke/format.nvim
    :h format.txt

    npm install lua-fmt prettier -g
    pip install black pylint epdb ipython
    autocmd BufWritePost * FormatWrite

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
