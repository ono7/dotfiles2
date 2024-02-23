-- ["]M"] = "@function.outer",
-- ["[M"] = "@function.outer",
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Open float" })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = true, border = 'rounded' })<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = true, border = 'rounded' })<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.diagnostic.config {
  float = { border = "rounded" },
}


local on_attach = function(client, bufnr)
  local k = function(keys, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- null-ls handles this for now
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  -- Mappings.
  k("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "[G]oto [D]eclaration")
  k("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  k("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  k("K", vim.lsp.buf.hover, "Hover Documentation")
  k("<space>l", "<cmd>lua vim.diagnostic.set_loclist()<CR>", "set_loclist")
  k("<space>i", "<cmd>lua vim.lsp.buf.implementation()<cr>", "implementation")
  k("<space><space>", vim.lsp.buf.code_action, "[<code action>]")
  k("go", vim.lsp.buf.type_definition, "[type definition]")
  -- k("<c-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  k("gn", vim.lsp.buf.rename, "[R]e[n]ame")
  -- nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
end

local handle_lsp = function(opts1, override)
  if override ~= nil then
    -- force: keys from the far right table win during merge
    return vim.tbl_deep_extend("force", override, opts1)
  end
  return opts1
end

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_nvim_lsp.default_capabilities()

-- true needed for html/css
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- print(vim.inspect(capabilities))

local mason_status, mason = pcall(require, "mason")

if not mason_status then
  print("mason not loaded in cmp.lua")
  return
end

mason.setup()
-- require("mason-nvim-dap").setup({
--     ensure_installed = { "python", "delve" }
-- })

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")

if not mason_lspconfig_status then
  print("mason_lspconfig not loaded in cmp.lua")
  return
end

local servers = {
  gopls = {},
  pyright = {},
  -- yamlls = {},
  ansiblels = {},
  html = {},
  jsonls = {},
  cssls = {},
  terraformls = {},
  lua_ls = {},
  ruff_lsp = {},
}


mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

local neodev_ok, neodev_config = pcall(require, "neodev")

if not neodev_ok then
  print("Error in pcall neodev -> ~/.dotfiles/nvim/lua/plugins/lsp/mason.lua")
  return
end

neodev_config.setup({
  library = { plugins = { "nvim-dap-ui" }, types = true }
})


local nvim_lsp_status, nvim_lsp = pcall(require, "lspconfig")

if not nvim_lsp_status then
  print("lspconfig not loaded in cmp.lua")
  return
end

local lsp_opts = {
  root_dir = nvim_lsp.util.root_pattern(".git"),
  on_attach = on_attach,
  init_options = { hostInfo = "neovim" },
  capabilities = capabilities,
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
  },
}

nvim_lsp.gopls.setup({
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  autostart = true,
  root_dir = nvim_lsp.util.root_pattern("go.mod", "main.go", "go.work", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      -- experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = false,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})

-- local ts_opts = { root_dir = nvim_lsp.util.root_pattern("yarn.lock", "lerna.json", ".git") }
-- nvim_lsp.tsserver.setup(handle_lsp(lsp_opts, ts_opts))

local pyright_opts = {
  root_dir = nvim_lsp.util.root_pattern(".git", "venv", "requirements.txt", "setup.py"),
  settings = {
    pyright = {
      autoImportCompletion = true, },
    python = {
      analysis = {
        autoSearchPaths        = true,
        diagnosticMode         = 'openFilesOnly',
        useLibraryCodeForTypes = true,
        typeCheckingMode       = 'off',
      }
    }
  },
}

-- nvim_lsp.pyright.setup(handle_lsp(lsp_opts, pyright_opts))


nvim_lsp.pyright.setup {
  on_attach = on_attach,
  root_dir = nvim_lsp.util.root_pattern(".git", "venv", "requirements.txt", "setup.py"),
  settings = {
    pyright = {
      -- autoImportCompletion = true
      disableOrganizeImports = true
    },
    python = {
      analysis = {
        ignore = { '*' },
        -- autoSearchPaths = true,
        -- diagnosticMode = 'openFilesOnly',
        -- useLibraryCodeForTypes = true,
        typeCheckingMode = 'off'
      }
    }
  }
}

-- require("lspconfig").terraformls.setup({})

nvim_lsp.lua_ls.setup({
  Lua = {
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
    diagnostics = {
      globals = { "vim" },
    },
  },
})

nvim_lsp.ansiblels.setup({
  ansible = {
    validation = {
      lint = {
        enabled = false
      }
    }
  },
})


nvim_lsp.cssls.setup(handle_lsp(lsp_opts))
nvim_lsp.html.setup {
  filetypes = { 'html' },
}

-- nvim_lsp.yamlls.setup(handle_lsp(lsp_opts))
nvim_lsp.ansiblels.setup(handle_lsp(lsp_opts))

nvim_lsp.jsonls.setup(handle_lsp(lsp_opts))

-- nvim_lsp.omnisharp.setup(handle_lsp(lsp_opts))


nvim_lsp.ruff_lsp.setup {
  on_attach = on_attach,
  init_options = {
    settings = {
      -- Any extra CLI arguments for `ruff` go here.
      args = {},
      run = { "onSave" }
    }
  },
}
