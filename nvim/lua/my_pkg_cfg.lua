local m = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

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

require "nvim-web-devicons".setup {
  default = true
}

require "nvim-treesitter.configs".setup {
  -- indent = {
  --   enable = false
  -- },
  highlight = {
    enable = true,
    disable = {"python"} -- broken...
  },
  -- incremental_selection = {
  --   enable = true,
  --   use_languagetree = true
  --   -- disable = { 'cpp', 'lua' },
  -- },
  ensure_installed = {"c", "cpp", "lua", "javascript", "toml", "json", "java", "bash"}
  -- playground = {
  --   enable = true,
  --   disable = {},
  --   updatetime = 25,
  --   persist_queries = false
  -- }
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
    },
    {
      cmd = {
        "prettier -w --parser babel --single-quote"
      },
      start_pattern = "^```javascript$",
      end_pattern = "^```$"
    },
    {
      cmd = {
        "black"
      },
      start_pattern = "^```python$",
      end_pattern = "^```$"
    },
    {
      cmd = {
        "prettier -w --parser yaml --single-quote --quote-props preserve"
      },
      start_pattern = "^```yaml$",
      end_pattern = "^```$"
    }
  }
}
