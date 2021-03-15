= Contents =
  - [[#metatables|metatables]]
    - [[#metatables#creating modules|creating modules]]
    - [[#metatables#clearing tables|clearing tables]]
    - [[#metatables#tables remove elements|tables remove elements]]
    - [[#metatables#table sort|table sort]]
    - [[#metatables#name space / create module|name space / create module]]
    - [[#metatables#using tables for object oriented programming (OOP)|using tables for object oriented programming (OOP)]]
    - [[#metatables#create objects using tables|create objects using tables]]
    - [[#metatables#define functions using :|define functions using :]]
    - [[#metatables#factory functions page 68|factory functions page 68]]
    - [[#metatables#Extending Tables with Metatables|Extending Tables with Metatables]]
    - [[#metatables#metamethods, are methods assinged to a metatable|metamethods, are methods assinged to a metatable]]
      - [[#metatables#metamethods, are methods assinged to a metatable#`__tostring` metamethod|`__tostring` metamethod]]
      - [[#metatables#metamethods, are methods assinged to a metatable#`__index` metamethod|`__index` metamethod]]
      - [[#metatables#metamethods, are methods assinged to a metatable#bypassing metatables|bypassing metatables]]

= metatables =






- setmetatable() first parameter is the table it self and also the return value
- second parameter is the metatable being set

```lua
meta = { a = 1 }
t = setmetatable({}, meta)

-- define a backup table for failed key lookups

backup = { mykey = 100 }
meta.__index = backup
t.mytest

nil
 t.mykey
100

```

== creating modules ==

```lua
-- Create an example file mymodule.lua with the following content:

local mymodule = {}

function mymodule.foo()
  print("Hello World!")
end

return mymodule

-- Now to use this new module in the interactive interpreter, just do:

> mymodule = require "mymodule"
> mymodule.foo()
Hello World!

-- Deep copy a table
local function table_copy(t)
  local copy = {}
  for n,v in pairs(t) do
    if type(v) == 'table' then
             v = table_copy(v)
    end
    copy[n] = v
  end
  return copy
end
```

== clearing tables ==

clear entry on table by assigning nil

```lua
test = {}
test.x = "test"
test.x = nil
```

== tables remove elements ==

remove last element from the table

```lua
table.remove()
```

== table sort ==

sorts in place

```lua
table.sort(tbl)
```

== name space / create module ==

```lua
mod = {}

function mod.factorial(num)
  local total = 1
  for i = 1, num do
    total = total * i
  end
  return total
end

return mod
```

== using tables for object oriented programming (OOP) ==

```lua
counter = {
  count = 0
}

function counter.get(self)
  return self.count
end

function counter.inc(self)
  self.count = self.count + 1
  return self.count
end
```

== create objects using tables ==

```lua
-- call using: x = new_counter()

-- inc and get need to be called with x:get() not x.get()
do
  local function get(self)
    return self.count
  end

  local function inc(self)
    self.count = self.count + 1
  end

  function new_counter(value)
    if type(value) ~= "number" then
      value = 0
    end
    local obj = {
      count = value,
      get = get,
      inc = inc
    }
    return obj
  end
end
-- using obj:get() makes automatically
-- passes self as the first argument

x = {}

function x:get()
  self.val = 9
  return self
end
```

Instead of typing counter.get(counter), you can call counter:get(). Lua
translates counter:get() into counter.get(counter), saving you a bit of typing
and making code easier to read.

== define functions using : ==

Defining Functions Using :
You can use the : operator to define functions, making this type of program- ming even more natural. When this happens, Lua includes an implicit first argument called self. That’s why you used the variable name self in the previous example.
Redefine the earlier functions by typing the following into your interpreter:

```lua
counter = {
  count = 0
}

function counter:get()
  return self.count
end

function counter:inc()
  self.count = self.count + 1
end
```

== factory functions page 68 ==

return new objects when they are called

== Extending Tables with Metatables ==

- Each table in Lua is capable of having a metatable attached to it. A metatable
  is a secondary table that gives Lua extra information about how that table
  should be treated when it is used. For example, by default, when you try to
  print a table you are given as tring that looks something like table:
  0x30d470,which isn’t extremely readable.

== metamethods, are methods assinged to a metatable ==

- they begin with two `__` underscores, e.g. `__index and __newindex`

```
___add        - behavior when used in addition
___mul        - behavior when used in multiplication
___div        - behavior when used in division
___sub        - behavior when used in subtraction
___unm        - behavior when negated (unary minus).
___tostring   - argument to tostring(). This also affects the print() function, which calls tostring() directly.
___concat     - Defines the behavior when used with the concatenation operator (..)
___index      - Defines the behavior when the table is indexed with a key that doesn’t exist in that table.
___newindex   - Defines the behavior when a previously unset key in the table is being set.
```

```lua
-- tbl = regular table
-- mtable = metatable
tbl = {"a", "b", "c"}
mtable = {}
setmetable(tbl, mtable)
```

- setmetatble returns the table passed as the first argument

- getmetable(tbl) returns the metatable or nil

```lua
-- test to see if mt is set
print(getmetatable(tbl) == mt)
```

=== `__tostring` metamethod ===

```lua
-- prints table to stdout, affects tostring and print functions
function mt.__tostring(tbl)
  -- mt = metatable
  local result = "{"

  for i = 1, #tbl do
    if i > 1 then
      result = result .. ", "
    end
    result = result .. tostring(tbl[i])
  end

  result = result .. "}"
  return result
end
```

=== `__index` metamethod ===

Normally, when a table does not have a value associated with a given key, nil is
returned. That makes sense for run-of-the-mill tables, but at times it is more
appropriate to take other action instead. The index metamethod allows that to
happen, following this procedure:

1. Code tries to access an unassociated key in a table.

2. If the table has an
   index metatable entry that is another table, look
   up the same key in that table and return it (or nil if it doesn't exist).
   This may
   possibly trigger the `__index` metamethod of the second table,
   making a chain.

3. If the table has an
   index metatable entry that is a function, call the
   function with the table and the key as arguments, and return the result.

=== bypassing metatables ===

{{{lua
-- used to bypass metatable __index and __newindex
rawget()
rawset()
}}}
