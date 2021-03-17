-- init lua plugins

--[[ require "bufferline".setup {
  options = {
    always_show_bufferline = false,
    show_buffer_close_icons = false
  }
} ]]
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
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = {
      "rust"
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
  ["*"] = {
    -- remove trailing whitespace
    {
      cmd = {
        "sed -i 's/[ \t]*$//'"
      }
    }
  },
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
        "prettier -w --parser babel"
      },
      start_pattern = "^{{{javascript$",
      end_pattern = "^}}}$",
      target = "current"
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
        "prettier -w --single-quote",
        "eslint --fix"
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
    }
  }
}
