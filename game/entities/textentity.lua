function game.entities.Textentity(TEXT, POSX, POSY, CAMERA_CONTROLLED)
    return Secs.entity(
        {"position",            {x = POSX, y = POSY} },
        {"text",                {text = TEXT} },
        {"cameraControlled",    {isCameraControlled = CAMERA_CONTROLLED} }
    )
end