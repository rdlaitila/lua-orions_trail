function requiredir(DIR)
    local files = love.filesystem.enumerate(DIR)
    for k, file in ipairs(files) do   
        if love.filesystem.isFile(DIR.."/"..file) then                
            local match, num = file:gsub("%.lua", "")
            engine.log("Requiring "..tostring(DIR).."/"..tostring(file))
            require(tostring(DIR).."/"..tostring(match))
        end        
    end   
end