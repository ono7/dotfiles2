= tables =


== table.sort() ==

* allows sorting a table, can take a function to use for sorting
* CAN NOT sort tables containing other tables, only %s %d, you can however pass
  a sorting function to handle this

{{{lua
tb = {"b", "c", "a"}

table.sort(tb)

--[[

  > for k,v in pairs(tb) do print(k,v) end
  1       a
  2       b
  3       c
  >

--]]
tb = {}

table.insert(tb, {name = "testb"})
table.insert(tb, {name = "testd"})
table.insert(tb, {name = "testc"})
table.insert(tb, {name = "testa"})

function sortName(a, b)
  -- a.name < b.name works on letters and numbers in lua
  return a.name < b.name
end

--[[

  > for k,v in pairs(tb) do print(k,v.name) end
  1       testb
  2       testd
  3       testc
  4       testa
  >

  > table.sort(tb, sortName)

  > for k,v in pairs(tb) do print(k,v.name) end
  1       testa
  2       testb
  3       testc
  4       testd
  >

--]]
}}}

== table.remove(table, [,pos]) ==

removes elemets from table if no pos is given, it removes #table, which is the
last element on the table
