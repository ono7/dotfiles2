-- lsp

vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

function _G.check_back_space()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match("%s")) and true
end

-- nvim-compe (completion)

require "compe".setup {
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = "enable",
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true
    -- vsnip = true
  }
}

if vim.g.loaded_paq then
  -- lsp package manager
  local on_attach = function(client, bufnr)
    _ = client
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local ens = {expr = true, noremap = true, silent = true}

    --[[

      " compe unmapped
      inoremap <silent><expr> <CR>      compe#confirm('<CR>')
      inoremap <silent><expr> <C-e>     compe#close('<C-e>')

    --]]
    buf_set_keymap(
      "i",
      "<tab>",
      [[pumvisible() ? "<C-n>" : v:lua.check_back_space() ? '<Tab>' : compe#complete()]],
      ens
    )
    -- buf_set_keymap("i", "c-f", "compe#scroll({ 'delta': +4 })", ens)
    -- buf_set_keymap("i", "c-d", "compe#scroll({ 'delta': -4 })", ens)
  end

  -- config that activates keymaps and enables snippet support
  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return {
      capabilities = capabilities,
      -- map buffer local keybindings when the language server attaches
      on_attach = on_attach
    }
  end

  -- configure lua for nvim development
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

  local function setup_servers()
    require "lspinstall".setup()

    local servers = require "lspinstall".installed_servers()

    for _, server in pairs(servers) do
      local config = make_config()

      if server == "lua" then
        config.settings = lua_server_settings
      end

      -- if server == "clangd" then
      --   config.filetypes = {"c", "cpp"}
      -- end

      require "lspconfig"[server].setup(config)
    end
  end

  setup_servers()
end
