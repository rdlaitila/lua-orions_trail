local Block = Ecs.Entity()
game.entities.Block = Block

Block:add(game.components.Position)
Block:add(game.components.CameraControlled)