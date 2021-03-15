tb = {}

table.insert(tb, {name = "testb"})
table.insert(tb, {name = "testd"})
table.insert(tb, {name = "testc"})
table.insert(tb, {name = "testa"})

function sortName(a, b)
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
