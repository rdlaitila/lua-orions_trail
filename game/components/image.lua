local function Image(IMAGEDATA)
    local self = {}
    
    self.image = love.graphics.newImage(IMAGEDATA)  
    
    return self
end
game.components.Image = Image