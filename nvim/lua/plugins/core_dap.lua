--[[
* MACOS
  brew install llvm
  ln -s $(brew --prefix)/opt/llvm/bin/lldb-vscode $(brew --prefix)/bin/

* Debian

  sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" # Instructions from https://apt.llvm.org/

* check the version of lldb installed *

  cd $(dirname $(which lldb-17))
  sudo ln -s lldb-vscode-17 lldb-vscode

]]


-- You can open, close and toggle the windows with corresponding functions:
-- require("dapui").open()
-- require("dapui").close()
-- require("dapui").toggle()

local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
  print("Error in pcall dap -> ~/.dotfiles/nvim/lua/plugins/core_dap.lua")
  return
end


local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
  print("Error in pcall dapui -> ~/.dotfiles/nvim/lua/plugins/core_dap.lua")
  return
end

dapui.setup()

function DapDebug()
  dap.configurations.go = {
    {
      type = "delve",
      name = "Debug (Remote binary)",
      request = "launch",
      mode = "exec",
      hostName = "127.0.0.1",
      port = "7777",
      program = function()
        local argument_string = vim.fn.input "Path to binary: "
        vim.notify("Debugging binary: " .. argument_string)
        return vim.fn.split(argument_string, " ", true)[1]
      end,
    },
  }

  -- we want to run delve manually
  dap.adapters.delve = {
    type = "server",
    host = "127.0.0.1",
    port = 7777,
  }
  require("dap").continue()
end

--- keymaps ---
local opt = { silent = true }
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  opt)

vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", opt)
vim.keymap.set("n", '<F6>', function() require('dap').continue() end)
vim.keymap.set("n", '<F7>', function() require('dap').step_out() end)
vim.keymap.set("n", '<F8>', function() require('dap').step_into() end)
vim.keymap.set("n", '<F9>', function() require('dap').step_over() end)
vim.keymap.set("n", '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set("n", '<leader>do', function() require('dapui').toggle() end)
vim.keymap.set("n", '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set("n", '<leader>dus', function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end)

vim.keymap.set("n", "<leader>dvv", function()
  local types_enabled = true
  local toggle_types = function()
    types_enabled = not types_enabled
    dapui.update_render({ max_type_length = types_enabled and -1 or 0 })
  end
end)


-- --- dapgui ---
-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end

dap.adapters.lldb = {
  type = "executable",
  command = "/opt/homebrew/bin/lldb-vscode", -- adjust as needed
  name = "lldb",
}

local lldb = {
  name = "Launch lldb",
  type = "lldb",      -- matches the adapter
  request = "launch", -- could also attach to a currently running process
  program = function()
    return vim.fn.input(
      "Path to executable: ",
      vim.fn.getcwd() .. "/",
      "file"
    )
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}

require('dap-go').setup {
  -- :help dap-configuration
  dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = "dlv",
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port
    port = "${port}",
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    build_flags = "all=-N -l",
  },
}

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      return '/usr/bin/python'
    end,
  },
}

------------------------------------------------------------------------
--                          DAP/CORE CONFIG                           --
------------------------------------------------------------------------

--- integrate dapui with dap automatically (opens and closes dapui)

-- local dap, dapui = require("dap"), require("dapui")

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--   dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--   dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--   dapui.close()
-- end


------------------------------------------------------------------------
--                             dap/python                             --
------------------------------------------------------------------------

local MYHOME = os.getenv("HOME")
local MY_VENV_BIN = MYHOME .. "/.virtualenvs/prod3/bin/python"

--- adapter
-- dap.adapters.python = {
--   type = "executable",
--   command = MY_VENV_BIN,
--   args = { "-m", "debugpy.adapter" }
-- }

--- adapter configuration
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python
-- dap.configurations.python = {
--   {
--     -- The first three options are required by nvim-dap
--     type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
--     request = "launch",
--     name = "Launch file",
--     -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

--     program = "${file}", -- This configuration will launch the current file if used.
--     pythonPath = function()
--       -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--       -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--       -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--       local cwd = vim.fn.getcwd()
--       if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
--         return cwd .. "/venv/bin/python"
--       elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
--         return cwd .. "/.venv/bin/python"
--       else
--         return MY_VENV_BIN
--       end
--     end
--   }
-- }
