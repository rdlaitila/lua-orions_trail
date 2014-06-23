local System = Class("System")

function System:initialize(PRIORITY)
    self._ecsManager = nil
    self._priority = PRIORITY or 0    
end

function System:update(DT)
end

function System:draw()
end

return System