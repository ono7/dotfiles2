-- configure lua for vim development

local M = require "lsp_core"

local lua_server_settings = {
  Lua = {
    runtime = {
      -- LuaJIT -> Neovim
      version = "LuaJIT",
      path = vim.split(package.path, ";")
    },
    diagnostics = {
      -- `vim` global
      globals = {"vim"}
    },
    workspace = {
      -- Neovim runtime files
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      }
    }
  }
}

local config = M.make_config()

config.settings = lua_server_settings

require "lspconfig".lua.setup {config}
