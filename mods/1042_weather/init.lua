dofile(core.get_modpath("1042_weather") .. "/weather_api.lua")

-- Skip weather
if core.settings:get("1042_disable_weather") == "true" then
    weather.is_loaded = false
    return
end

weather.is_loaded = true

dofile(core.get_modpath("1042_weather") .. "/weathers_api.lua")
dofile(core.get_modpath("1042_weather") .. "/weathers.lua")





-- Make it work

local time_between_changes = 60*5
local time_to_next_change = 0
local timer = 0
local weather_hight = weather.weather_hight

core.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer > 1 then
        for _, player in ipairs(core.get_connected_players()) do
            local name = player:get_player_name()
            local the_weather = weather.weathers[weather.get_weather_at_pos(player:get_pos())]

            -- Temp hud:
            local player_huds = core_1042.player_huds[name] or {}
            local id = player_huds.pos_temp
            if id then
                player:hud_remove(id)
                player_huds.pos_temp = nil
            end
            player_huds.pos_temp = player:hud_add({
                type = "text",
                name = "pos_temp",
                text = weather.get_temp_single(player:get_pos()) .. " C",
                position = {x=0.8, y=0.9},
                number = 0x00ffdd,
                style = 3
            })



            local players_weather = weather.players_weather[name]
            -- Only run if player changed weathers
            if players_weather.weather ~= the_weather then
                -- Reset weather defaults
                if the_weather.on_end then
                    the_weather.on_end(player, name, players_weather)
                else
                    weather.default_on_change(player, name, players_weather)
                end


                if players_weather.sound_handle then
                    core.sound_fade(players_weather.sound_handle, 0.25, 0)
                    players_weather.sound_handle = nil -- Deleat old
                end

                if the_weather.on_change then
                    the_weather.on_change(player, name, players_weather)
                end

                -- Update
                players_weather.weather = the_weather
            end

            if the_weather.on_step then
                the_weather.on_step(player)
            end

            local def = the_weather.particlespawner
            if def then
                local pos = player:get_pos()
                def.pos = {
                    min = vector.new(pos.x-16,pos.y+weather_hight,pos.z-16),
                    max = vector.new(pos.x+16,pos.y+weather_hight,pos.z+16),
                    bias = 0
                }
                def.playername = name
                
                core.add_particlespawner(def)
            end
        end

        timer = 0
    end


    -- Make new random index for weather sort to find
    time_to_next_change = time_to_next_change - dtime
    if time_to_next_change <= 0 then
        weather.weather_index = weather.rand:next(1, #weather.weathers)
        time_to_next_change = time_between_changes
    end
end)




core.register_chatcommand("change_weather", {
    privs = {["creative"] = true},
    params = "<weather/help>",
    description = "Change the global weather selection to param or random if none is supplied. May not be the weather desired as that depends on biome.",
    func = function(name, param)
        local index = weather.rand:next(1, #weather.weathers)

        if param then
            if param == "help" then
                local retsrting = ""
                for _, def in ipairs(weather.weathers) do
                    retsrting = retsrting .. def.name .. "\n"
                end

                return true, retsrting

            else
                for i, def in ipairs(weather.weathers) do
                    if def.name == param then
                        index = i
                    end
                end
            end
        end

        weather.weather_index = index
        return true, "Setting weather to " .. weather.weathers[weather.weather_index].name
    end
})

core.register_chatcommand("weather", {
    description = "Show current global weather.",
    func = function()
        return true, "Global weather is " .. weather.weathers[weather.weather_index].name
    end
})