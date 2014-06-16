local ImageList = {}
game.components.ImageList = ImageList

function ImageList:new()
    local self = {}
    
    self.imageList = {}
    
    return self
end

function ImageList:addImage(IMAGE)
    table.insert(self.imageList, IMAGE)    
end
