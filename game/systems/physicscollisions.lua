local PhysicsCollisions = Class('PhysicsCollisions', Lecs.System)

function PhysicsCollisions:initialize(PRIORITY)
    Lecs.System.initialize(self, PRIORITY)
    
    G_BOX2DWORLD:setCallbacks(
        self.beginContact, 
        self.endContact, 
        self.preSolve, 
        self.postSolve
    )
    
    G_BOX2DCOLLTEXT = ""
end

function PhysicsCollisions:update(DT)
end

function PhysicsCollisions:draw()
    --love.graphics.print(G_BOX2DCOLLTEXT, 0, 0)
end

function PhysicsCollisions:beginContact(a, b, coll)   
    --G_BOX2DCOLLTEXT = G_BOX2DCOLLTEXT .. "Begin Contact\r\n"
end

function PhysicsCollisions:endContact(a, b, coll)
   --G_BOX2DCOLLTEXT = G_BOX2DCOLLTEXT .. "End Contact\r\n"
end

function PhysicsCollisions:preSolve(a, b, coll)
   --G_BOX2DCOLLTEXT = G_BOX2DCOLLTEXT .. "Pre Solve Contact\r\n"
end

function PhysicsCollisions:postSolve(a, b, coll, normalimpulse1, tangentimpulse1, normalimpulse2, tangentimpulse2)
   --G_BOX2DCOLLTEXT = G_BOX2DCOLLTEXT .. "Post Solve Contact\r\n"
end

game.systems.PhysicsCollisions = PhysicsCollisions