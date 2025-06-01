-- Noirbound: Grid Drawing Utility

local grid = {}
grid.__index = grid

function grid:draw(cellSize)
    love.graphics.setColor(0.2, 0.2, 0.2, 0.5)
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()

    for x = 0, width, cellSize do
        love.graphics.line(x, 0, x, height)
    end

    for y = 0, height, cellSize do
        love.graphics.line(0, y, width, y)
    end

    love.graphics.setColor(1, 1, 1, 1)
end

return grid