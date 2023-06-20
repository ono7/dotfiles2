require('snippy').setup({
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

local lspkind_status_ok, lspkind = pcall(require, "lspkind")

if not lspkind_status_ok then
  print("lspkind not loaded - plugins/lspkind.lua")
  return
end

lspkind.init({
  symbol_map = {
    Text = "   ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = " ﴲ ",
    Variable = "[]",
    Class = "  ",
    Interface = " ﰮ ",
    Module = "  ",
    Property = " 襁",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    -- Enum = " 練",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = " ﲀ ",
    Struct = " ﳤ ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
  },
})

local cmp_status_ok, cmp = pcall(require, "cmp")

if not cmp_status_ok then
  print("cmp not loaded - plugins/cmp.lua")
  return
end

vim.opt.completeopt = { "menu", "menuone" }
-- vim.opt.completeopt = { "menu", "menuone", "noselect" }

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
  -- virtual_text = {
  --   spacing = 2,
  --   severity_limit = "Warning", -- disable hints...
  --   underline = true,
  -- },
  virtual_text = false,
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

cmp.setup({
  preselect = types.cmp.PreselectMode.None, -- do not randomly select item from menu
  snippet = {
    expand = function(_)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<c-c>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if snippy.can_jump(-1) then
        snippy.previous()
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    -- { name = "nvim_lsp", keyword_length = 3 },
    { name = 'snippy' },
    { name = "nvim_lsp",               keyword_length = 2 },
    { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
    { name = "buffer",                 keyword_length = 2 },
  },
  formatting = {
    format = lspkind.cmp_format({
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
