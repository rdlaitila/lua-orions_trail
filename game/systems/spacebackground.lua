local SpaceBackground = Class('SpaceBackground', Lecs.System)

SpaceBackground.sprite = love.graphics.newImage("game//assets//backgrounds//nebula01.png")

function SpaceBackground:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
    
    self.stars = {}
    for i = 1, 1024 do
       self.stars[i] = {}
       
       self.stars[i].x = math.random(0, love.graphics.getWidth())
       self.stars[i].y = math.random(0, love.graphics.getHeight())
       self.stars[i].n = math.random(0, 255)
    end
end

function SpaceBackground:update(DT)      
    for k, _ in ipairs(self.stars) do   
      local m = math.random(-8, 8)
   
      self.stars[k].n = self.stars[k].n + m
      
      if self.stars[k].n < 16 then
      
         self.stars[k].n = 16
         
      elseif self.stars[k].n > 255 then
      
         self.stars[k].n = 255
      end
   end
end

function SpaceBackground:draw() 
    G_CAMERA:attach()     
    G_CAMERA:detach()
    
    love.graphics.draw(SpaceBackground.sprite, 0, 0)    
    
    for k, _ in ipairs(self.stars) do      
        love.graphics.circle("fill", self.stars[k].x, self.stars[k].y, 1)
    end
end

game.systems.SpaceBackground = SpaceBackground