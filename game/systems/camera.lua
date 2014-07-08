local CameraSystem = Class('CameraSystem', Lecs.System)

function CameraSystem:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
end

 function CameraSystem:update(DT)
    if love.keyboard.isDown("down") then 
        G_CAMERA.y = G_CAMERA.y + 10 / (G_CAMERA.scale)
    end
    if love.keyboard.isDown("up") then 
        G_CAMERA.y = G_CAMERA.y - 10 / (G_CAMERA.scale)
    end
    if love.keyboard.isDown("right") then 
        G_CAMERA.x = G_CAMERA.x + 10 / (G_CAMERA.scale)
    end
    if love.keyboard.isDown("left") then 
        G_CAMERA.x = G_CAMERA.x - 10 / (G_CAMERA.scale)
    end
end

function CameraSystem:mousepressed( x, y, mb )
   if mb == "wu" then              
      G_CAMERA.scale = G_CAMERA.scale + 0.1    
   end

   if mb == "wd" then
        if G_CAMERA.scale > 0 then
            if G_CAMERA.scale < 1 then            
                G_CAMERA.scale = G_CAMERA.scale * G_CAMERA.scale
            else
                G_CAMERA.scale = G_CAMERA.scale - 0.1
            end
        end
   end
end

game.systems.CameraSystem = CameraSystem