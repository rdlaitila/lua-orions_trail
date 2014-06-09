Secs.rendersystem("renderer_textentities", 1, function()
    for e in pairs(Secs.query("textEntities")) do
        if e.isCameraControlled then
            Camera:attach()
            love.graphics.print(e.text.text, e.position.x, e.position.y)
            Camera:detach()
        else
            love.graphics.print(e.text.text, e.position.x, e.position.y)
        end
    end
end)