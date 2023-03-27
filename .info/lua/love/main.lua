local tbl = {}
tbl.subject = "science"
local message = "hello bubbah!!"

function love.draw()
  love.graphics.setFont(love.graphics.newFont(40))
  love.graphics.print(message .. " " .. tostring(tbl.subject))
end
