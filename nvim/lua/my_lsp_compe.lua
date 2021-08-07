require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 2,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  resolve_timeout = 800,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  -- documentation = true,
  documentation = {
    border = {"", "", "", " ", "", "", "", " "}, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1
  },
  source = {
    path = {kind = "", true},
    tags = {kind = "", true},
    buffer = {kind = "﬘", true},
    treesitter = false,
    -- luasnip = {kind = "﬌", true},
    calc = false,
    nvim_lsp = {kind = "", true},
    nvim_lua = true,
    vsnip = false,
    ultisnips = false
  }
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

--- key maps
local m = vim.api.nvim_set_keymap
m("i", "<Tab>", [[v:lua.tab_complete()]], {expr = true, silent = true})
m("s", "<Tab>", [[v:lua.tab_complete()]], {expr = true, silent = true})
m("i", "<S-Tab>", [[v:lua.s_tab_complete()]], {expr = true, silent = true})
m("s", "<S-Tab>", [[v:lua.s_tab_complete()]], {expr = true, silent = true})
m("i", "<C-Space>", "compe#complete()", {expr = true, silent = true})
m("i", "<M-f>", [[compe#scroll({ 'delta': +4 })]], {expr = true, silent = true})
m("i", "<M-d>", [[compe#scroll({ 'delta': -4 })]], {expr = true, silent = true})

-- use built in lsp for things...
local opts = {noremap = true, silent = true}
m("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
m("n", "<leader>g", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
-- m("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
m("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
m("n", "<space>l", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
m("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
m("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

--- diable nvim lsp diagnostics globaly, let ALE handle this
vim.lsp.handlers["textDocument/publishDiagnostics"] = function()
end

-- python ( npm -g install pyright), requires root director object (requirements.txt , .git, setup.py)
require "lspconfig".pyright.setup {}

-- TODO (jlima) : 07-11-2021 | configure lua for vim development
local lua_server_settings = {
  Lua = {
    completion = {
      keywordSnippet = "Disable"
    },
    runtime = {
      version = "LuaJIT",
      path = vim.split(package.path, ";")
    },
    diagnostics = {
      globals = {"vim", "love"}
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
      }
    }
  }
}
