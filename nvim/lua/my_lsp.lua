-- lsp

vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

function _G.check_back_space()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")) and true
end

-- diable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    update_in_insert = false
  }
)

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function()
-- end

-- require("lspconfig").python.setup {
--   handlers = {
--     ["textDocument/publishDiagnostics"] = vim.lsp.with(
--       vim.lsp.diagnostic.on_publish_diagnostics,
--       {
--         -- Disable virtual_text
--         virtual_text = false,
--         update_in_insert = false
--       }
--     )
--   }
-- }

if vim.g.loaded_paq then
  local lua_server_settings = {
    Lua = {
      runtime = {
        -- LuaJIT -> Neovim
        version = "LuaJIT",
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        globals = {"vim"} -- `vim` global
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

-- lsp install

-- local function setup_servers()
--   require "lspinstall".setup()

--   local servers = require "lspinstall".installed_servers()

--   for _, server in pairs(servers) do
--     local config = make_config()

--     if server == "lua" then
--       config.settings = lua_server_settings
--     end

--     -- if server == "clangd" then
--     --   config.filetypes = {"c", "cpp"}
--     -- end

--     require "lspconfig"[server].setup(config)
--   end
-- end

-- setup_servers()

-- local nvim_lsp = require "nvim_lsp"

-- Disable Diagnostcs globally
-- local nvim_lsp = require "nvim_lsp"
-- -- Disable Diagnostcs globally
-- vim.lsp.callbacks["textDocument/publishDiagnostics"] = function()
-- end
end
