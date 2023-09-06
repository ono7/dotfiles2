-- local signs = {
--   Error = "󰯆 ",
--   Warn = " ",
--   Hint = "󰛨 ",
--   Info = " ",
-- }


-- vim.diagnostic.config {
--   float = { source = "always" },
--   signs = true,
--   virtual_text = false,
--   severity_sort = true,
--   current_line_virt = true,
-- }

-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- local util = require "vim.lsp.util"
-- local api = vim.api
-- local log = require "vim.lsp.log"

-- local function location_handler(_, result, ctx, _)
--   if result == nil or vim.tbl_isempty(result) then
--     local _ = log.info() and log.info(ctx.method, "No location found")
--     return nil
--   end
--   local client = vim.lsp.get_client_by_id(ctx.client_id)

--   if vim.tbl_islist(result) then
--     util.jump_to_location(result[1], client.offset_encoding)

--     if #result > 1 then
--       vim.fn.setloclist(0, {}, " ", {
--         title = "LSP locations",
--         items = util.locations_to_items(result, client.offset_encoding),
--       })
--       api.nvim_command "lopen"
--     end
--   else
--     util.jump_to_location(result, client.offset_encoding)
--   end
-- end

-- vim.lsp.handlers["textDocument/declaration"] = location_handler
-- vim.lsp.handlers["textDocument/definition"] = location_handler
-- vim.lsp.handlers["textDocument/typeDefinition"] = location_handler
-- vim.lsp.handlers["textDocument/implementation"] = location_handler

-- vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "WildMenu" })
-- vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "Error" })
-- vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "Normal" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "CursorLineNr" })
-- vim.fn.sign_define("DiagnosticsVirtualTextHint", { text = "", texthl = "Normal" })

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

--- old config for reference



-- view defined symbols :echo sign_getdefined()
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "WildMenu" })
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "Error" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "Normal" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "CursorLineNr" })
vim.fn.sign_define("DiagnosticsVirtualTextHint", { text = "", texthl = "Normal" })

-- virtual text

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  signs = true,
  -- signs = {
  -- 	severity_limit = "Warning",
  -- },
  virtual_text = {
    spacing = 2,
    severity_limit = "Warning", -- disable hints...
    underline = true,
  },
  virtual_lines = { only_current_line = true },
  update_in_insert = false,
  underline = true,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
