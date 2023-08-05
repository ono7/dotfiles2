local status_ok, dap = pcall(require, "dap")
local v_status_ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
local dapui_status_ok, dapui = pcall(require, "dapui")

if not status_ok then
  print("dap not loaded - plugins/dap.lua")
  return
end

if not v_status_ok then
  print("nvim-dap-virtual-text not loaded - nvim-dap-virtual-text")
else
  dap_virtual_text.setup()
end

if not dapui_status_ok then
  print("dapui not loaded - plugin/dapui")
end

local opt = {noremap = true, silent = true}

------------------------------------------------------------------------
--                          DAP/CORE CONFIG                           --
------------------------------------------------------------------------

vim.keymap.set("n", "<F4>", ":lua require'dap'.continue()<CR>", opt) -- run until end of program/start debugging
vim.keymap.set("n", "<F5>", ":lua require'dap'.step_over()<CR>", opt) -- run again one more step
vim.keymap.set("n", "<F6>", ":lua require'dap'.step_into()<CR>", opt) -- step into method or function else behave like step_over
vim.keymap.set("n", "<F7>", ":lua require'dap'.step_out()<CR>", opt) -- step out of a function or method if possible
vim.keymap.set("n", "<leader>bb", ":lua require'dap'.toggle_breakpoint()<CR>", opt)
vim.keymap.set("n", "<leader>bB", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)

--- integrate dapui with dap automatically (opens and closes dapui)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

------------------------------------------------------------------------
--                               DAPUI                                --
------------------------------------------------------------------------

if not dapui_status_ok then
  print("dapui not loaded - plugins/dapui.lua")
else
  -- ref: https://github.com/rcarriga/nvim-dap-ui
  require("dapui").setup(
    {
      icons = {expanded = "▾", collapsed = "▸"},
      mappings = {
        -- Use a table to apply multiple mappings
        expand = {"<CR>", "<2-LeftMouse>"},
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t"
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has("nvim-0.7"),
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            {id = "scopes", size = 0.25},
            "breakpoints",
            "stacks",
            "watches"
          },
          size = 40, -- 40 columns
          position = "left"
        },
        {
          elements = {
            "repl",
            "console"
          },
          size = 0.25, -- 25% of total lines
          position = "bottom"
        }
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = {"q", "<Esc>"}
        }
      },
      windows = {indent = 1},
      render = {
        max_type_length = nil -- Can be integer or nil.
      }
    }
  )
end

------------------------------------------------------------------------
--                             dap/python                             --
------------------------------------------------------------------------

local MYHOME = os.getenv("HOME")
local MY_VENV_BIN = MYHOME .. "/.virtualenvs/prod3/bin/python"

--- adapter
dap.adapters.python = {
  type = "executable",
  command = MY_VENV_BIN,
  args = {"-m", "debugpy.adapter"}
}

--- adapter configuration
-- ref: https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Python
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = "launch",
    name = "Launch file",
    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}", -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
        return cwd .. "/venv/bin/python"
      elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
        return cwd .. "/.venv/bin/python"
      else
        return MY_VENV_BIN
      end
    end
  }
}
