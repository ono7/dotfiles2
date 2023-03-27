= Lua debugging resources =

https://github.com/kikito/inspect.lua

  * This library transforms any Lua value into a human-readable representation.
    It is especially useful for debugging errors in tables. The objective here
    is human understanding (i.e. for debugging), not serialization or
    compactness.


== debug with print/select ==

=== inspecting tables ===
{{{lua
ins = require "inspect"
print(ins(test))
-- {
--   7,
--   {1, 2, 3, 4},
--   a = "lettera"
-- }
}}}


=== varargs ===
{{{lua

function print_args2(...)
  -- works
  for i = 1, select("#", ...) do
    -- (select()) wrapped only returns 1 argument
    print(i, (select(i, ...)))
  end
end
}}}

=== print ===

use print to see what the function returns

{{{lua
tbl1 = {...}
print(ipairs(tbl1))

--[[

  > print(ipairs(tbl1))
  function: 0x104d063a4   nil     0

--]]
}}}
