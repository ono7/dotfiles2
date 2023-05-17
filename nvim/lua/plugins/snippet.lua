local ls = require("luasnip")

local snip = ls.s --> snippet
local i = ls.i    --> insert node
local t = ls.t    --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node                    -- snippet node, used to return from dynamic node
local fmt = require("luasnip.extras.fmt").fmt --format snips
local rep = require("luasnip.extras").rep     --repeat

--- parse simple snippets ---
local simple = ls.parser.parse_snippet

-- require("luasnip.loaders.from_vscode").lazy_load()
-- require("luasnip.loaders.from_lua").load({paths = "~/.dotfiles/nvim/snippets/"})

require("luasnip").config.setup({ store_selection_keys = "<c-a>" })

-- vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

local types = require("luasnip.util.types")

vim.keymap.set(
  { "i", "s" }, -- insert and select mode
  "<c-k>",
  function()
    if ls.expand_or_jumpable() then
      ls.expand_or_jump()
    end
  end,
  { silent = true }
)

vim.keymap.set(
  { "i", "s" }, -- insert and select mode
  "<c-j>",
  function()
    if ls.jumpable(-1) then
      ls.jump(-1) -- jump back
    end
  end,
  { silent = true }
)

vim.keymap.set(
  { "i", "s" }, -- insert and select mode
  "<c-l>",      -- list, cycles through snip options if configured
  function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end,
  { silent = true }
)

ls.config.set_config({
  history = true,                            --keep around last snippet local to jump back
  updateevents = "TextChanged,TextChangedI", --update changes as you type
  enable_autosnippets = false,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<-", "Error" } },
      },
    },
  },
})

--- snippet helper functions ---
local date = function()
  return os.date("%Y-%m-%d")
end

local datetime = function()
  -- os.date "%D - %H:%M"
  return os.date("%Y-%m-%d %H:%M:%S")
end

local function split(inputstr, sep)
  if sep == nil then
    sep = "%%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local same = function(index)
  --- this can be used to debug lua tables, using vim.inspect()
  return f(function(arg)
    -- todo
    -- print(vim.inspect(arg))
    print(vim.inspec(vim.api.nvim_eval("&commentstring")))
    -- return arg[1]
    return ""
  end, { index })
end

local get_comment = function(pos)
  local r = vim.fn.split(vim.api.nvim_buf_get_option(0, "commentstring"), "%s", true)
  -- if pos < 0 then
  --   return r[2] == "" and " " .. vim.trim(r[1]) or " " .. vim.trim(r[2])
  -- else
  return vim.trim(r[1])
  -- end
end

--- snippets ---
ls.add_snippets("all", {
  snip({ trig = "dt" }, { f(datetime, {}) }),
  snip({ trig = "d" }, { f(date, {}) }),
  snip("xxxxxtest", fmt([[example: {}, function: {}]], { i(1), same(1) })), --- testing
  snip("ins", fmt([[print(vim.inspect({}))]], { i(1) })),
  snip(
    "todo",
    fmt([[{} TODO: ({}) ~ {}{}]], {
      f(function()
        return get_comment(1)
      end),
      -- f(function()
      -- 	return os.date("%Y-%m-%d")
      -- end),
      f(function()
        return os.getenv("USER")
      end),
      -- i(1, os.getenv("USER")),
      i(0),
      f(function()
        return get_comment(-1)
      end),
    })
  ),
}, {
  key = "all snippets", -- unique key needed to source this file properly, in cmds.lua
})

-- local get_test_result = function(position)
-- 	return d(position, function()
-- 		return sn(nil, t("example"))
-- 	end)
-- end
--

ls.add_snippets("lua", {
  simple("!", "#!/usr/bin/lua\n\n"),
  simple("mf", "$1.$2 = function($3)\n  $0\nend"),
  snip("r", fmt('local {} = require "{}"', { i(1), rep(1) })), -- repeat node
  simple("f", "function($1)\n  $0\nend"),
  simple("lf", "local $1 = function($2)\n  $0\nend"),
  snip(
    "req",
    fmt([[local {} = require"{}"]], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", true)
        print(vim.inspect(import_name)) -- can be used to debug
        return parts[#parts] or ""
      end, { 1 }),
      i(1),
    })
  ),
  snip("forp", {
    t("for "),
    i(1, "k"),
    t(", "),
    i(2, "v"),
    t(" in pairs("),
    i(3, "table"),
    t({ ") do", "\t" }),
    i(4),
    t({ "", "end", "" }),
    i(0),
  }),
  snip("fori", {
    t("for "),
    i(1, "k"),
    t(", "),
    i(2, "v"),
    t(" in ipairs("),
    i(3, "table"),
    t({ ") do", "\t" }),
    i(4),
    t({ "", "end", "" }),
    i(0),
  }),
  snip("if", {
    t("if "),
    i(1),
    t({ " then", "\t" }),
    i(2),
    t({ "", "end", "" }),
    i(0),
  }),
  snip("M", {
    t({ "local M = {}", "", "" }),
    i(0),
    t({ "", "", "return M" }),
  }),
}, {
  key = "lua snippets",
})

ls.add_snippets("sh", {
  simple("!", "#!/usr/bin/env bash"),
  simple(
    "h",
    [[#!/usr/bin/env bash

# author: Lima

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # script cleanup here

  exit 1
}

msg() {
  echo >&2 -e "${1-}"
}
]]
  ),
}, {
  key = "sh/bash snippets",
})

--- python
local transform = function(p)
  -- dymamic snip wip
  return d(p, function()
    return sn(
      nil,
      f(function()
        return vim.inspect(p)
      end)
    )
  end, {})
end

ls.add_snippets("python", {
  simple("!", "#!/usr/bin/env python\n\n"),
  snip( --header
    "h",
    fmt(
      [[
#!/usr/bin/env python
""" {}
    {}
    {}

    __author__ = 'Jose Lima'

"""
{}
]],
      { i(1), i(2, ""), f(datetime), i(0) }
    )
  ),
  snip({ trig = "test (.*)", regTrig = true }, {
    t("def "),
    f(function(_, node) -- transformation f() node
      if type(node.captures[1]) == "string" then
        -- print(vim.inspect(node.captures[1]))
        return "test_" .. node.captures[1]:gsub("%s+", "_")
      end
      return ""
    end),
    t("("),
    i(1),
    t({ "):", "\t" }),
    i(0),
  }),
  snip("pdb", t("import pdb;pdb.set_trace()")),
  snip("rpdb", t("import rpdb;rpdb.set_trace()")),
  snip(
    "filter",
    fmt(
      [[
def {1}({4}):
    {5}
    return

class FilterModule:
    def filters(self):
        return {{ "{2}" : {3} }}
    ]],
      { i(1), rep(1), rep(1), i(2), i(0) }
    )
  ),
}, {
  key = "python snippets",
})

ls.add_snippets("yaml", {
  snip(
    "h",
    fmt(
      [[
---
- name: "{}"
  hosts: {}
  gather_facts: false


  tasks:

    - name: "{}"
      register: response
]],
      { i(1), i(2, "localhost"), i(0) }
    )
  ),
}, {
  key = "yaml snippets",
})

ls.add_snippets("go", {
  snip("h", {
    t("package "),
    i(1, "main"),
    t({ "", "", "import (", "\t" }),
    i(2, { '"fmt"' }),
    t({ "", ")", "" }),
    t({ "", "func " }),
    i(3, "main"),
    t({ "() " }),
    i(4, ""),
    t({ " {", "\t" }),
    i(0),
    t({ "", "}" }),
  }),
  snip(
    "v",
    fmt(
      [[
 var (
     {}
	)
  ]],
      { i(0) }
    )
  ),
  -- snip(-- function
  --   "f",
  --   {
  --     t("func "),
  --     i(1, "main"),
  --     t("("),
  --     i(2),
  --     t(") "),
  --     i(3),
  --     t({ " {", "\t" }),
  --     i(0),
  --     t({ "", "}", "" }),
  --   }
  -- ),
  snip( -- package
    "p",
    {
      t("package "),
      i(1, "main"),
      t(""),
      i(0),
    }
  ),
  snip(
    "e",
    fmt(
      [[
	if err != nil {{
     {}("{}%v\n", err)
	}}
]],
      { i(1, "log.Fatalf"), i(0)}
    )
  ),
  -- snip(-- error
  --   "err",
  --   {
  --     t("if "),
  --     i(1, "err != "),
  --     i(2, "nil"),
  --     t({ " {", "" }),
  --     t("\t"),
  --     c(3, { i(nil, ""), t("log.Fatal(err)") }),
  --     t({ "", "}" }),
  --   }
  -- ),
  snip( -- error
    "er",
    {
      t("if "),
      t("err != "),
      t("nil"),
      t({ " {", "" }),
      t('\tlog.Fatal("'),
      i(0),
      t('%v\n", err)'),
      t({ "", "}" }),
    }
  ),
  snip(
    "el",
    {
      t("else"),
      t({ " {", "" }),
      t("\t"),
      i(0),
      t({ "", "}" }),
    }
  ),
}, {
  key = "go snippets",
})

ls.add_snippets("markdown", { snip(
  "c",
  fmt(
    [[
```{}
```]],
    { i(0) }
  )
) }, { key = "markdown snippets" })
