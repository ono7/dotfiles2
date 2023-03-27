local status_ok, format = pcall(require, "formatter")

if not status_ok then
  print("format not loaded - plugins/formatter.lua")
  return
end

--- formatting ---
format.setup {
  --[[

    :h format.txt

    npm install lua-fmt prettier jsonlint -g
    pip install black pylint epdb ipython

  --]]
  filetype = {
    lua = {
      -- luafmt
      function()
        return {
          exe = "luafmt",
          args = {"--indent-count", 2, "--stdin"},
          stdin = true
        }
      end
    },
    go = {
      -- luafmt
      function()
        return {
          exe = "gofmt",
          args = {"-s"},
          stdin = true
        }
      end
    },
    python = {
      function()
        return {
          exe = "black",
          args = {"-"},
          stdin = true
        }
      end
    },
    json = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote"},
          stdin = true
        }
      end
    },
    markdown = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "-w"},
          stdin = true
        }
      end
    },
    html = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "-w"},
          stdin = true
        }
      end
    },
    typescript = {
      function()
        return {
          exe = "prettier",
          args = {
            "--parser typescript --stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            "--single-quote"
          },
          stdin = true
        }
      end
    },
    javascript = {
      function()
        return {
          exe = "prettier",
          args = {
            "--parser typescript --stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            "--single-quote"
          },
          stdin = true
        }
      end
    },
    yaml = {
      function()
        return {
          exe = "prettier",
          args = {
            "--stdin-filepath",
            vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
            "-w --parser yaml",
            "--single-quote",
            "--quote-props preserve"
          },
          stdin = true
        }
      end
    }
  }
}

-- python = {
--   {
--     cmd = {
--       "black"
--     }
--   }
-- },
-- json = {
--   {
--     cmd = {
--       "prettier -w --parser json"
--     }
--   }
-- },
-- typescript = {
--   {
--     cmd = {
--       "prettier -w --parser typescript --single-quote"
--     }
--   }
-- },

-- yaml = {
--   {
--     cmd = {
--       "prettier -w --parser yaml --single-quote --quote-props preserve"
--     }
--   }
-- },
-- vimwiki = {
--   {
--     cmd = {
--       "prettier -w"
--     }
--   },
--   {
--     cmd = {
--       "luafmt -i 2 -w replace"
--     },
--     start_pattern = "^{{{lua$",
--     end_pattern = "^}}}$",
--     target = "current"
--   },
--   {
--     cmd = {
--       "black"
--     },
--     start_pattern = "^{{{python$",
--     end_pattern = "^}}}$",
--     target = "current"
--   }
-- },
-- javascript = {
--   {
--     cmd = {
--       "prettier -w"
--       -- "eslint --fix"
--     }
--   }
-- },
-- cpp = {
--   {
--     cmd = {
--       -- brew install clang-format
--       "clang-format -i"
--     }
--   }
-- },
-- markdown = {
--   {
--     cmd = {
--       "prettier -w"
--     }
--   },
--   {
--     cmd = {
--       "luafmt -i 2 -w replace"
--     },
--     start_pattern = "^```lua$",
--     end_pattern = "^```$",
--     target = "current"
--   },
--   {
--     cmd = {
--       "prettier -w --parser babel --single-quote"
--     },
--     start_pattern = "^```javascript$",
--     end_pattern = "^```$"
--   },
--   {
--     cmd = {
--       "black"
--     },
--     start_pattern = "^```python$",
--     end_pattern = "^```$"
--   },
--   {
--     cmd = {
--       "prettier -w --parser yaml --single-quote --quote-props preserve"
--     },
--     start_pattern = "^```yaml$",
--     end_pattern = "^```$"
--   }
--   }
-- }
