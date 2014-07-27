local Starfield = class('Starfield', lecs.System)

function Starfield:initialize(PRIORITY)
    lecs.System.initialize(self, PRIORITY)
    
    self.stars = {}
    
    self.lastCameraX = G_CAMERA.x
    self.lastCameraY = G_CAMERA.y
end

function Starfield:update(DT)
    local camerax, cameray = G_CAMERA.x, G_CAMERA.y
    local cboundx1, cboundy1 = G_CAMERA:worldCoords(0, 0)
    local cboundx2, cboundy2 = G_CAMERA:worldCoords(love.graphics.getWidth(), love.graphics.getHeight())
    local cameraboxwidth = cboundx2 - cboundx1
    local cameraboxheight = cboundy2 - cboundy1
    
    for a=#self.stars, 1, -1 do
        if self.stars[a].x < cboundx1 or 
           self.stars[a].x > cboundx2 or
           self.stars[a].y < cboundy1 or
           self.stars[a].y > cboundy2 then
            table.remove(self.stars, a)
        end
    end
    
    if G_CAMERA.x ~= self.lastCameraX or G_CAMERA.y ~= self.lastCameraY then
        local camxdiff = camerax - self.lastCameraX
        local camydiff = cameray - self.lastCameraY
        
        local starx = math.random(cboundx1, cboundx2)
        local stary = math.random(cboundy1, cboundy2)
        local starz = 0
        local starrgb = {255,255,255}
        
        if camxdiff < 0 then
            starx = math.random(cboundx1-20/G_CAMERA.scale, cboundx1)
        end        
        if camxdiff > 0 then
            starx = math.random(cboundx2, cboundx2+20/G_CAMERA.scale)
        end        
        if camydiff < 0 then
            stary = math.random(cboundy1-20/G_CAMERA.scale, cboundy1)
        end        
        if camydiff > 0 then
            stary = math.random(cboundy2, cboundy2+20/G_CAMERA.scale)
        end
        
        table.insert(self.stars, {x=starx, y=stary, z=starz, rgb=starrgb})
    end
    
    self.lastCameraX = G_CAMERA.x
    self.lastCameraY = G_CAMERA.y
end

function Starfield:draw()
    love.graphics.print(#self.stars, 0, 0)
    
    G_CAMERA:attach()    
    for a=1, #self.stars do
        love.graphics.circle('fill', self.stars[a].x, self.stars[a].y, 3)
    end
    G_CAMERA:detach()
end

function Starfield:newStar(X, Y, Z, RGB)
    local star = {
        x=X,
        y=Y,
        z=Z,
        rgb = RGB
    }
    
    return star
end

game.systems.Starfield = Starfield