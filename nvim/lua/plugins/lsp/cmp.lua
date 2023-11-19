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
    x = {
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
    completion = {
      border = 'rounded',
      -- scrollbar = '║',
      scrollbar = false,
      winhighlight = "Normal:Normal,FloatBorder:cmpBorder,CursorLine:cmpSelect,Search:None"
    },
    documentation = {
      border = 'rounded',
      scrollbar = false,
      -- winhighlight = "Comment:cmpDoc",
      winhighlight = "Normal:Normal,FloatBorder:cmpBorder,CursorLine:cmpSelect,Search:None"
    }
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
    { name = "nvim_lsp",                priority = 1,        group_index = 1,   max_item_count = 200, keyword_length = 1 },
    { name = "nvim_lsp_signature_help", max_item_count = 20, priority = 3,      keyword_length = 6 },
    { name = "path",                    max_item_count = 20, keyword_length = 6 },
    { name = "buffer",                  max_item_count = 20, keyword_length = 6 },
  },
  performance = {
    trigger_debounce_time = 500,
    throttle = 550,
    fetching_timeout = 80,
  },
  formatting = {
    format = lspkind_config.cmp_format({
      with_text = false,
      maxwidth = 50,
      menu = {
        buffer = "[B]",
        nvim_lsp = "[L]",
        -- nvim_lua = "[api]",
        -- path = "[path]",
      },
    }),
  },
})
