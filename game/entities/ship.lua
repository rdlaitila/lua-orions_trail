local Ship = class("Ship", game.entities.BlockGroup)

function Ship:initialize(X,Y,ROT)
    game.entities.BlockGroup.initialize(self, X, Y, ROT)
    
    self:addTag("ship")
    
    self.thrustMultiplier = 20
    
    self.isThrustingAhead = false
    self.isThrustingStern = false
    self.isThrustingPort = false
    self.isThrustingStarboard = false
end

function Ship:thrustAhead()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStern()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local thrust_x = -1*math.cos(self.box2dBody:getAngle())*thrust_force
    local thrust_y = -1*math.sin(self.box2dBody:getAngle())*thrust_force        
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustPort()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = -1*math.cos(rad)*(thrust_force)
    local thrust_y = -1*math.sin(rad)*(thrust_force)
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustStarboard()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    local deg = math.deg(self.box2dBody:getAngle()) + 90
    local rad = math.rad(deg)
    local thrust_x = math.cos(rad)*(thrust_force)
    local thrust_y = math.sin(rad)*(thrust_force)   
    self.box2dBody:applyForce(thrust_x, thrust_y)
end

function Ship:thrustYawLeft()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( -1*(thrust_force*4) )    
end

function Ship:thrustYawRight()
    local thrust_force = self.box2dBody:getMass() * self.thrustMultiplier
    self.box2dBody:applyAngularImpulse( (thrust_force*4) )
end

game.entities.Ship = Ship