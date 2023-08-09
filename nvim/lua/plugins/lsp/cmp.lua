local snippy_ok, snippy_setup = pcall(require, "snippy")

if not snippy_ok then
  print("Error in pcall snippy -> ~/.dotfiles/nvim/lua/plugins/lsp/cmp.lua")
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

local lspkind_ok, lspkind_config = pcall(require, "lspkind")

if not lspkind_ok then
  print("Error in pcall lspkind -> ~/.dotfiles/nvim/lua/plugins/lsp/cmp.lua")
  return
end



lspkind_config.init({})

local cmp_status_ok, cmp_config = pcall(require, "cmp")

if not cmp_status_ok then
  print("cmp not loaded - plugins/cmp.lua")
  return
end

vim.opt.completeopt = { "menu", "menuone" }


local plugins_lsp_diag_ok, _ = pcall(require, "plugins.lsp.diag")

if not plugins_lsp_diag_ok then
  print("Error in pcall plugins.lsp.diag -> ~/.dotfiles/nvim/lua/plugins/lsp/cmp.lua")
  return
end

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
    { name = "nvim_lsp",               keyword_length = 2 },
    { name = "nvim_lsp_signature_help" },
    { name = "path" },
    { name = "buffer", },
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
        -- gh_issues = "[issues]",
        -- tn = "[TabNine]",
      },
    }),
  },
})
