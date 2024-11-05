-- init.lua
weather = {}

local temp_m

local weather_def = {
    offset = 0,
    scale = 1,
    spread = {x = 600, y = 600, z = 600},
    seed = 33464573,
    octaves = 3,
    persist = 0.3,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = true,
        defaults = false
    }
}

core.after(0,function()
    temp_m = core.get_perlin_map(weather_def, {x=80, y=80})
end)


function weather.get_temp_map(x, z)
    return temp_m:get_2d_map({z=0,y=x, x=z})
end

function weather.get_temp(pos, temp_map)
    local tempv = temp_map[pos.x][pos.z] * 30
    return tempv
end




-- Skip weather
if core.settings:get("1042_disable_weather") ~= "true" then



    weather.weathers = {
        {
            name = "Plain",
            time = {
                min = 30,
                max = 60*5
            },
            clouds = {
                density = 0.35,
                color = "#f0faffaa",
                ambient = "#006699",
                thickness = 128,
                speed = {x=1, y=1},
                shadow = "#cccccc",
                height = 120
            },
            sky = {
                type = "regular",
                clouds = true,
                sky_color = {
                    night_sky = "#0066ff",
                    night_horizon = "#0088ff",
                    day_horizon = "#90d3f6",
                    day_sky = "#61b5f5"
                },
                fog = {
                    fog_start = 0,
                    fog_distance = 270,
                    fog_color = "#ffffff00"
                }
            }
        },
        {
            name = "Light storm",
            conditions = {
                temp = {
                    min = -2,
                }
            },
            clouds = {
                density = 0.7,
                color = "#333333dd",
                ambient = "#333333",
                shadow = "#aaaaaa",
                thickness = 128,
                speed = {x=2, y=2},
                height = 120
            },
            time = {
                min = 30,
                max = 60*5
            },
            sky = {
                type = "regular",
                clouds = true,
                sky_color = {
                    night_sky = "#0066ff",
                    night_horizon = "#0088ff",
                    day_horizon = "#444444",
                    day_sky = "#333333"
                },
                fog = {
                    fog_start = 0,
                    fog_distance = 40,
                    fog_color = "#22222200"
                }
            },
            exposure = {
                exposure_correction = -2
            },
            particlespawner = 
            {
                amount = 2000,
                time = 1,

                collisiondetection = true,
                object_collision = true,

                vel = {
                    min = vector.new(-2, -10, -2),
                    max = vector.new(2, -20, 2),
                    bias = 0
                },

                acc = vector.new(0, -9.8, 0),

                size = {
                    min = 0.5,
                    max = 1
                },

                exptime = {
                    min = 0.5,
                    max = 1
                },

                bounce = {
                    min = 0,
                    max = 0.3
                },

                glow = 2,

                texture = "1042_plain_node.png^[colorize:#004499:144"
            }
        },
        {
            name = "Light snow",
            conditions = {
                temp = {
                    max = 0
                }
            },
            clouds = {
                density = 0.35,
                color = "#f0faffaa",
                ambient = "#006699",
                thickness = 128,
                speed = {x=1, y=1},
                shadow = "#cccccc",
                height = 120
            },
            time = {
                min = 30,
                max = 60*5
            },
            sky = {
                type = "regular",
                clouds = true,
                sky_color = {
                    night_sky = "#0066ff",
                    night_horizon = "#0088ff",
                    day_horizon = "#90d3f6",
                    day_sky = "#61b5f5"
                },
                fog = {
                    fog_start = 0,
                    fog_distance = 90,
                    fog_color = "#ddddddaa"
                }
            },
            particlespawner = 
            {
                amount = 4000,
                time = 1,

                collisiondetection = true,
                object_collision = true,
                collision_removal = true,

                vel = {
                    min = vector.new(-2, -1, -2),
                    max = vector.new(2, -4, 2),
                    bias = 0
                },

                size = {
                    min = 0.5,
                    max = 1
                },

                exptime = {
                    min = 4.5,
                    max = 5
                },

                bounce = {
                    min = 0,
                    max = 0.3
                },

                glow = 8,

                texture = "1042_plain_node.png^[colorize:#aaaaff:144"
            }
        }
    }


    local player_weather = {}


    local function get_weather(pos)
        local i = math.random(1, #weather.weathers)
        
        local m = weather.get_temp_map(math.ceil(pos.x), math.ceil(pos.z))
        local temp = weather.get_temp({x=1,z=1}, m)

        while true do
            local weather_t = weather.weathers[i]
            if not weather_t.conditions then
                return weather_t
            elseif weather_t.conditions.temp.max and weather_t.conditions.temp.max >= temp then
                if not weather_t.conditions.temp.min or weather_t.conditions.temp.min >= temp then
                    return weather_t
                end
            elseif weather_t.conditions.temp.min and weather_t.conditions.temp.min <= temp then
                if not weather_t.conditions.temp.max or weather_t.conditions.temp.max <= temp then
                    return weather_t
                end
            end

            i = i + 1
            if i > #weather.weathers then
                i = 1
            end
        end
    end

    local function change_weather(player)
        local name = player:get_player_name()
        if core.get_player_by_name(name) ~= nil then
            player_weather[name].weather = get_weather(player:get_pos())
            player:set_clouds(player_weather[name].weather.clouds)
            player:set_sky(player_weather[name].weather.sky)
            player:set_lighting({exposure = (player_weather[name].weather.exposure or {exposure_correction = 0})})

            player_weather[name].time = math.random(player_weather[name].weather.time.min, player_weather[name].weather.time.max)

            return player_weather[name].weather.name
        end
    end


    core.register_chatcommand("change_weather", {
        privs = {
        },
        func = function(name)
            local player = core.get_player_by_name(name)
            if core_1042.is_creative(player) then
                return true, "Set to "..change_weather(player).."."
            end
        end
    })

    local timer = 0

    core.register_globalstep(function(dtime)
        timer = timer + dtime
        if timer > 1 then
            for _, player in ipairs(core.get_connected_players()) do
                local name = player:get_player_name()
                
                if player_weather[name] then
                    player_weather[name].time = player_weather[name].time - timer
                    if player_weather[name].time <= 0 then
                        change_weather(player)
                    end

                    local def = player_weather[name].weather.particlespawner
                    if def then
                        local pos = player:get_pos()
                        def.pos = {
                            min = vector.new(pos.x-16,pos.y+16,pos.z-16),
                            max = vector.new(pos.x+16,pos.y+16,pos.z+16),
                            bias = 0
                        }
                        def.playername = name
                        
                        core.add_particlespawner(def)
                    end
                end
            end

            timer = 0
        end
    end)


    core.register_on_joinplayer(function(player)
        player_weather[player:get_player_name()] = {}
        change_weather(player)
    end)

    core.register_on_leaveplayer(function(player)
        player_weather[player:get_player_name()] = nil
    end)

end