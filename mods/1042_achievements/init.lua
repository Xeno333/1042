achievements_1042 = {
    achievements = {}
}



-- Achievement API

function achievements_1042.achieve(player, achievement_name)
    local achievement_definition = achievements_1042.achievements[achievement_name]
    if not achievement_definition then return nil end

    local metaref = player:get_meta()
    if metaref:get_string("1042_achievements_achievement_"..achievement_name) ~= "true" then
        metaref:set_string("1042_achievements_achievement_"..achievement_name, "true")

        local id = player:hud_add({
            type = "image",
            name = "achievement_"..achievement_name.."img",
            text = "1042_plain_node.png^[colorize:"..achievement_definition.colour..":128",
            position = {x=0.2, y=0.85},
            scale = {x=128,y=80},
        })
        
        local id2 = player:hud_add({
            type = "text",
            name = "achievement_"..achievement_name.."_txt",
            text = achievement_definition.achievement,
            position = {x=0.2, y=0.85},
        })

        core.after(6, function()
            if player:is_valid() then
                player:hud_remove(id)
                player:hud_remove(id2)
            end
        end)
        
        return true
    end

    return false
end

function achievements_1042.register_achievement(achievement_name, achievement_definition)
    if achievements_1042.achievements[achievement_name] then return false end

    achievements_1042.achievements[achievement_name] = achievement_definition
    return true
end




-- Core achievements


achievements_1042.register_achievement("first_life", {
    achievement = core.colorize("#ddffdd", "First life!"),
    colour = "#00ffaa"
})

achievements_1042.register_achievement("oooo_fire", {
    achievement = core.colorize("#ff7755", "Oooo, Fire!"),
    colour = "#ffccaa"
})

achievements_1042.register_achievement("smelter", {
    achievement = core.colorize("#ddcc55", "Smelter!"),
    colour = "#ffddaa"
})


core.register_on_joinplayer(function(player, last_join)
    achievements_1042.achieve(player, "first_life")
end)
