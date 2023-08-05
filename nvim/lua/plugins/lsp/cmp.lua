local snippy_status_ok, snippy_setup = pcall(require, "snippy")

if not snippy_status_ok then
  print("snippy not loaded - plugins/snippy.lua")
  return
end

snippy_setup.setup({
  snippet_dirs = '~/.dotfiles/nvim/snippets',
  mappings = {
    is = {
      ['<Tab>'] = 'expand_or_advance',
      ['<S-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>d'] = 'cut_text',
    },
  },
})

local snippy = require("snippy")

local lspkind_status_ok, lspkind_config = pcall(require, "lspkind")

if not lspkind_status_ok then
  print("lspkind not loaded - plugins/lspkind.lua")
  return
end

lspkind_config.init({})

local cmp_status_ok, cmp_config = pcall(require, "cmp")

if not cmp_status_ok then
  print("cmp not loaded - plugins/cmp.lua")
  return
end

vim.opt.completeopt = { "menu", "menuone" }

-- view defined symbols :echo sign_getdefined()
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "WildMenu" })
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "Error" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "Normal" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "CursorLineNr" })
vim.fn.sign_define("DiagnosticsVirtualTextHint", { text = "", texthl = "Normal" })
-- 

--- virtual text
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

vim.diagnostic.config({
  float = {
    border = "rounded",
  },
})

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append("c")

local types = require("cmp.types")
-- local luasnip = require("luasnip")

cmp_config.setup({
  preselect = types.cmp.PreselectMode.None, -- do not randomly select item from menu
  snippet = {
    expand = function(_)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp_config.config.window.bordered(),
  },
  mapping = {
    ["<C-n>"] = cmp_config.mapping.select_next_item({ behavior = cmp_config.SelectBehavior.Insert }),
    ["<C-p>"] = cmp_config.mapping.select_prev_item({ behavior = cmp_config.SelectBehavior.Insert }),
    ["<C-d>"] = cmp_config.mapping.scroll_docs(4),
    ["<C-b>"] = cmp_config.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp_config.mapping.complete(),
    ["<c-c>"] = cmp_config.mapping.close(),
    ["<CR>"] = cmp_config.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp_config.mapping(function(fallback)
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif cmp_config.visible() then
        cmp_config.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp_config.mapping(function(fallback)
      if snippy.can_jump(-1) then
        snippy.previous()
      elseif cmp_config.visible() then
        cmp_config.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    -- { name = "nvim_lsp", keyword_length = 3 },
    -- { name = 'snippy' },
    { name = "nvim_lsp",               keyword_length = 2 },
    -- { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
    { name = "buffer",                 keyword_length = 2 },
  },
  formatting = {
    format = lspkind_config.cmp_format({
      with_text = false,
      maxwidth = 50,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        -- luasnip = "[snip]",
        gh_issues = "[issues]",
        tn = "[TabNine]",
      },
    }),
  },
})
