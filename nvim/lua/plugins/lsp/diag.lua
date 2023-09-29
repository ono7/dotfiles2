-- view defined symbols :echo sign_getdefined()
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "ModeMsg" })
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
