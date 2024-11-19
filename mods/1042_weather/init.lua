dofile(core.get_modpath("1042_weather") .. "/weather_api.lua")


-- Skip weather
if core.settings:get("1042_disable_weather") == "true" then
    return
end

core.register_alias("mapgen_stone", "air")
core.register_alias("mapgen_water_source", "air")
core.register_alias("mapgen_river_water_source", "air")


weather.weathers = {
    {
        name = "Plain",
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
        name = "Hail",
        sound = {
            name = "storm",
            gain = 1,
            pitch = 0.5
        },
        conditions = {
            temp = {
                min = -5,
            }
        },
        clouds = {
            density = 0.9,
            color = "#333333dd",
            ambient = "#333333",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = 120
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
            amount = 500,
            time = 1,

            collisiondetection = true,
            object_collision = true,

            vel = {
                min = vector.new(-2, -16, -2),
                max = vector.new(2, -32, 2),
                bias = 0
            },

            acc = vector.new(0, -9.8, 0),

            size = {
                min = 0.5,
                max = 4
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

            texture = "1042_plain_node.png^[colorize:#dddddd:144"
        }
    },
    {
        name = "Storm",
        sound = {
            name = "storm",
            gain = 0.75
        },
        conditions = {
            temp = {
                min = 5,
            }
        },
        clouds = {
            density = 0.9,
            color = "#333333dd",
            ambient = "#333333",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = 120
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
            amount = 8000,
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
        name = "Light storm",
        sound = {
            name = "rain",
            gain = 0.5
        },
        conditions = {
            temp = {
                min = 0,
            }
        },
        clouds = {
            density = 0.7,
            color = "#555555dd",
            ambient = "#555555",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = 120
        },
        sky = {
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#444444",
                day_sky = "#556666"
            },
            fog = {
                fog_start = 0,
                fog_distance = 40,
                fog_color = "#44444400"
            }
        },
        exposure = {
            exposure_correction = -1
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
        name = "Drizzle",
        sound = {
            name = "rain",
            gain = 0.25
        },
        conditions = {
            temp = {
                min = 0,
            }
        },
        clouds = {
            density = 0.7,
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
        },
        exposure = {
            exposure_correction = -0.3
        },
        particlespawner = 
        {
            amount = 500,
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
                min = 0.2,
                max = 0.5
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
            amount = 500,
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
                min = 6,
                max = 8
            },

            bounce = {
                min = 0,
                max = 0.3
            },

            glow = 8,

            texture = "1042_plain_node.png^[colorize:#ddddff:144"
        }
    }
}


local weather_index = weather.rand:next(1, #weather.weathers)


-- Index for caching current weather to skip sky changes
local players_weather = {}


local function get_weather(pos)
    local i = weather_index
    local temp = weather.get_temp_single(pos)

    while true do
        local weather_t = weather.weathers[i]
        if not weather_t.conditions then
            return i
        elseif weather_t.conditions.temp.max and weather_t.conditions.temp.max >= temp then
            if not weather_t.conditions.temp.min or weather_t.conditions.temp.min >= temp then
                return i
            end
        elseif weather_t.conditions.temp.min and weather_t.conditions.temp.min <= temp then
            if not weather_t.conditions.temp.max or weather_t.conditions.temp.max <= temp then
                return i
            end
        end

        i = i + 1
        if i > #weather.weathers then
            i = 1
        end
    end
end



local time_between_changes = 60*5
local time_to_next_change = 0
local timer = 0

core.register_globalstep(function(dtime)
    timer = timer + dtime
    if timer > 1 then
        for _, player in ipairs(core.get_connected_players()) do
            local name = player:get_player_name()
            local the_weather = weather.weathers[get_weather(player:get_pos())]

            -- Only run if player changed weathers
            if players_weather[name].weather ~= the_weather then
                -- Something seems off here #FIXME
                if the_weather.sound then
                    -- Kill current
                    if players_weather[name].sound_handle then
                        core.sound_fade(players_weather[name].sound_handle, 0.25, 0)
                    end

                    players_weather[name].sound_handle = core.sound_play(the_weather.sound.name, 
                    {
                        loop = true,
                        to_player = name,
                        gain = 0,
                        pitch = the_weather.sound.pitch or 1
                    })
                    -- Fade in new
                    core.sound_fade(players_weather[name].sound_handle, 0.1, the_weather.sound.gain)

                else
                    -- Kill current
                    if players_weather[name].sound_handle then
                        core.sound_fade(players_weather[name].sound_handle, 0.25, 0)
                    end
                end


                player:set_clouds(the_weather.clouds)
                player:set_sky(the_weather.sky)
                player:set_lighting({exposure = (the_weather.exposure or {exposure_correction = 0})})

                -- Set
                players_weather[name].weather = the_weather
            end

            local def = the_weather.particlespawner
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

        timer = 0
    end


    -- Make new random index for weather sort to find
    time_to_next_change = time_to_next_change - dtime
    if time_to_next_change <= 0 then
        weather_index = weather.rand:next(1, #weather.weathers)
        time_to_next_change = time_between_changes
    end
end)


-- For caches values

core.register_on_joinplayer(function(player)
    players_weather[player:get_player_name()] = {}
end)

core.register_on_leaveplayer(function(player)
    players_weather[player:get_player_name()] = nil
end)


core.register_chatcommand("change_weather", {
    privs = {["creative"] = true},
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

        weather_index = index
        return true, "Setting weather to " .. weather.weathers[weather_index].name
    end
})