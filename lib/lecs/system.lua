local System = class("System")

function System:initialize(PRIORITY)
    self._ecsManager = nil
    self._priority = PRIORITY or 0    
end

function System:update(DT)
end

function System:draw()
end

function System:keypressed(KEY, ISREPEAT)
end

function System:keyreleased(KEY)
end

function System:mousepressed(X, Y, MB)   
end

return System