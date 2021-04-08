-- :LspInstall lua, tssserver, python, bash, yaml

vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

-- diable nvim lsp diagnostics globaly
vim.lsp.handlers["textDocument/publishDiagnostics"] = function()
end

if vim.g.loaded_paq then
  -- lsp package manager
  local on_attach = function(client, bufnr)
    _ = client
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- set local buffer mappings
    local opts = {noremap = true, silent = true}
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "<leader>g", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>l", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<c-p>", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts) -- ale routed
    -- buf_set_keymap("n", "<c-n>", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts) -- ale routed
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  end

  -- config that activates keymaps and enables snippet support
  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end

  -- configure lua for vim development
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
        globals = {"vim"}
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
        }
      }
    }
  }

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
