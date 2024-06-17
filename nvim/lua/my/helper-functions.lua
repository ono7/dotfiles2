local MYHOME = os.getenv("HOME")

vim.o.shada = "'12,<1000,s1000,:500,/100,h,n~/.shada"

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  print(vim.fn.fnamemodify(dot_git_path, ":h"))
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

vim.api.nvim_create_user_command("CdGitRoot", function()
  vim.api.nvim_set_current_dir(get_git_root())
end, {})

vim.g.python3_host_prog = MYHOME .. "/.virtualenvs/prod3/bin/python3"

-- Converts selected bytes to a string, useful for debugging
local BytesToString = function(opts)
  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

  -- Normalize column indices (0-based)
  start_col = start_col + 1
  end_col = end_col + 1

  -- Adjust end column for last line
  if start_row == end_row and start_col == end_col then
    end_col = end_col + 1 -- Include the selected character on the same line
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  local selected_text = ""

  for i, line in ipairs(lines) do
    local start = (i == 1 and start_col or 1)
    local finish = (i == #lines and end_col or -1) -- -1 means end of line
    selected_text = selected_text .. line:sub(start, finish)
  end

  -- Remove any whitespace or non-hex characters
  selected_text = selected_text:gsub('[^0-9A-Fa-f]', '')

  if selected_text == '' then
    vim.api.nvim_err_writeln("No valid bytes selected.")
    return
  end

  -- Convert hex to string
  local string_result = ''
  for i = 1, #selected_text, 2 do
    local hex_byte = selected_text:sub(i, i + 1)
    string_result = string_result .. string.char(tonumber(hex_byte, 16))
  end

  -- Display the result in a new buffer
  vim.api.nvim_command('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { string_result })
  vim.api.nvim_command('setlocal buftype=nofile bufhidden=wipe noswapfile')
  vim.api.nvim_command('setlocal filetype=text')
  vim.api.nvim_command('setlocal nonumber norelativenumber')
  vim.api.nvim_win_set_cursor(0, { 1, 0 }) -- Move the cursor to the beginning of the buffer
end

vim.api.nvim_create_user_command('BytesToString', BytesToString, { range = true, nargs = 0 })

vim.cmd([[
function! Esc()
python3 << EOF_
import vim

c_map = {i: '\\' + chr(i) for i in b'()[]{}?*+-|^$\\.&~#\n\r\v\f\'\"'}

def escape(pattern):
    if isinstance(pattern, str):
        return pattern.translate(c_map)
    else:
        pattern = str(pattern, 'latin1')
        return pattern.translate(c_map).encode('latin1')

        vim.current.line = escape(vim.current.line)

EOF_
endfunction
command! -nargs=? -range Esc call Esc()

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register Cm call CopyMatches(<q-reg>)
]])


P = function(x)
  print(vim.inspect(x))
  return x
end


--- shellcode ---
--- m(
--- 	"x",
--- 	"<space>h",
--- 	[[:s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>]],
--- 	silent
--- )
