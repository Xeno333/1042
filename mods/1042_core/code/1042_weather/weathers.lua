

local hail_timer = 0
weather.register_weather({
    name = "Hail",
    conditions = {
        temp = {
            min = -5,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave
        }
    },
    particlespawner = {
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

        texpool = {
            {
                name = "hail.png",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "hail.png",
                scale = 0.5,
                blend = "alpha"
            },
            {
                name = "hail.png",
                scale = 0.25,
                blend = "alpha"
            }
        }
    },
    on_step = function(player, timer)
        hail_timer = hail_timer + timer
        if hail_timer >= 1 then
            local pos = player:get_pos()
            local clear, pos = core.line_of_sight(vector.new(pos.x, pos.y+1, pos.z), vector.new(pos.x, pos.y+weather.weather_hight, pos.z))

            if clear then
                if core_1042.rand:next(1, 8) == 1 then
                    player:set_hp(player:get_hp()-1, {_1042_reason="hail", _1042_death_msg="got struck by hail"})
                end
            end

            if core_1042.rand:next(1, 20) == 1 then
                player:set_lighting({exposure = {exposure_correction = core_1042.rand:next(10, 20)*0.1}})
                core.after(0.1, function()
                    player:set_lighting({exposure = {exposure_correction = -2}})
                end)
            end

            hail_timer = 0
        end
    end,
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_clouds({
            density = 0.9,
            color = "#333333dd",
            ambient = "#333333",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = core_1042.shared_lib.consts.plain_world_y_levels.sea_level + 120
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#444444",
                day_sky = "#333333",
                dawn_sky = "#b4bafa",
                dawn_horizon = "#bac1f0",
                indoors = "#646464",
                fog_sun_tint = "#f47d1d",
                fog_moon_tint = "#7f99cc",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 40,
                fog_color = "#22222200"
            }
        })
        player:set_lighting({exposure = {exposure_correction = -2}})
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.1,
                count = 6000,
                star_color = "#99aaffff",
                scale = 0.3
            }
        )
        player:set_moon(
            {
                texture = "moon.png^[colorize:#aaaaaa:144",
                visible = true,
                scale = 0.3
            }
        )

        -- Sound
        players_weather.sound_handle = core.sound_play("storm", 
        {
            loop = true,
            to_player = name,
            gain = 0,
            pitch = 0.5
        })
        core.sound_fade(players_weather.sound_handle, 0.1, 1)
    end,
})



weather.register_weather({
    name = "Void",
    conditions = {
        y_level = {
            max = core_1042.shared_lib.consts.void_y_levels.max,
            min = core_1042.shared_lib.consts.void_y_levels.min
        }
    },
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_sky({
            type = "regular",
            clouds = false,
            sky_color = {
                night_sky = "#000000",
                night_horizon = "#000000",
                day_horizon = "#000000",
                day_sky = "#000000",
                dawn_sky = "#000000",
                dawn_horizon = "#000000",
                indoors = "#000000",
                --fog_sun_tint = "#212222ff",
                fog_moon_tint = "#000000",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 100,
                fog_distance = 200,
                fog_color = "#000000"
            }
        })
        player:set_stars(
            {
                visible = false,
            }
        )
        player:set_moon(
            {
                visible = false,
            }
        )
        player:set_lighting({exposure = {exposure_correction = 0}})
    end,
})


weather.register_weather({
    name = "Sky Plain",
    conditions = {
        y_level = {
            max = core_1042.shared_lib.consts.sky_world_y_levels.max,
            min = core_1042.shared_lib.consts.sky_world_y_levels.min
        }
    },
    particlespawner = {
        y_spawn = {
            min = -16,
            max = 16
        },

        amount = 100,
        time = 2,

        collisiondetection = true,
        object_collision = true,

        vel = {
            min = vector.new(-16, -16, -16),
            max = vector.new(16, 16, 16),
            bias = 0
        },

        acc = vector.new(0, -9.8, 0),

        size = {
            min = 0.5,
            max = 2
        },

        exptime = {
            min = 2,
            max = 3
        },

        glow = 14,

        texpool = {
            {
                name = "1042_plain_node.png^[colorize:#440088:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#004488:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#008888:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#888888:144",
                scale = 1,
                blend = "alpha"
            }
        }
    },

    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_clouds({
            density = 0.5,
            color = "#003366",
            ambient = "#007777",
            shadow = "#0099aa",
            thickness = 64,
            speed = {x=32, y=32},
            height = 2048 + 64
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#003366",
                night_horizon = "#003366",
                day_horizon = "#007799",
                day_sky = "#005577",
                dawn_sky = "#007777",
                dawn_horizon = "#008877",
                indoors = "#005544",
                --fog_sun_tint = "#212222ff",
                fog_moon_tint = "#0099cc",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 40,
                fog_color = "#223355"
            }
        })
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.6,
                count = 2000,
                star_color = "#22aa88ff",
                scale = 0.2
            }
        )
        player:set_moon(
            {
                texture = "moon.png^[colorize:#00aacc:144",
                visible = true,
                scale = 1
            }
        )
        player:set_lighting({exposure = {exposure_correction = -2}})

        players_weather.sound_handle = core.sound_play("water", 
        {
            loop = true,
            to_player = name,
            gain = 0,
            pitch = 0.05
        })
        core.sound_fade(players_weather.sound_handle, 0.25, 4)
    end,
})

weather.register_weather({
    name = "Underworld",
    conditions = {
        y_level = {
            max = core_1042.shared_lib.consts.underworldworld_y_levels.max,
            min = core_1042.shared_lib.consts.underworldworld_y_levels.min
        }
    },
    particlespawner = {
        y_spawn = {
            min = -16,
            max = 16
        },

        amount = 100,
        time = 2,

        collisiondetection = true,
        object_collision = true,

        vel = {
            min = vector.new(-16, -16, -16),
            max = vector.new(16, 16, 16),
            bias = 0
        },

        acc = vector.new(0, -9.8, 0),

        size = {
            min = 0.5,
            max = 2
        },

        exptime = {
            min = 2,
            max = 3
        },

        glow = 14,

        texpool = {
            {
                name = "1042_plain_node.png^[colorize:#440000:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#221111:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#666600:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#886666:144",
                scale = 1,
                blend = "alpha"
            }
        }
    },

    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_clouds({
            density = 0.5,
            color = "#bb2200",
            ambient = "#774400",
            shadow = "#993300",
            thickness = 32,
            speed = {x=16, y=16},
            height = core_1042.shared_lib.consts.underworldworld_y_levels.max - 100
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#bb4400",
                night_horizon = "#bb4400",
                day_horizon = "#bb2200",
                day_sky = "#bb2200",
                dawn_sky = "#bb2200",
                dawn_horizon = "#bb2200",
                indoors = "#bb2200",
                fog_sun_tint = "#222222ff",
                fog_moon_tint = "#222222ff",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 100,
                fog_color = "#bb4400"
            }
        })
        player:set_stars(
            {
                visible = false,
            }
        )
        player:set_moon(
            {
                visible = false,
            }
        )
        player:set_lighting({exposure = {exposure_correction = 2}})
    end,
})

weather.register_weather({
    name = "Lower Cave",
    conditions = {
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave - 20
        }
    },
    particlespawner = {
        y_spawn = {
            min = -16,
            max = 16
        },

        amount = 25,
        time = 2,

        collisiondetection = true,
        object_collision = true,

        vel = {
            min = vector.new(-16, -16, -16),
            max = vector.new(16, 16, 16),
            bias = 0
        },

        acc = vector.new(0, -9.8, 0),

        size = {
            min = 0.5,
            max = 2
        },

        exptime = {
            min = 2,
            max = 3
        },

        glow = 14,

        texpool = {
            {
                name = "1042_plain_node.png^[colorize:#222222:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#111111:144",
                scale = 1,
                blend = "alpha"
            },
        }
    },

    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_sky({
            type = "regular",
            clouds = false,
            sky_color = {
                night_sky = "#2f5c4f",
                night_horizon = "#2f5c4f",
                day_horizon = "#2f5c4f",
                day_sky = "#2f5c4f",
                dawn_sky = "#2f5c4f",
                dawn_horizon = "#2f5c4f",
                indoors = "#2f5c4f",
                fog_sun_tint = "#2f5c4f",
                fog_moon_tint = "#2f5c4f",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 100,
                fog_color = "#2f5c4f"
            }
        })
        player:set_stars(
            {
                visible = false,
            }
        )
        player:set_moon(
            {
                visible = false,
            }
        )
        player:set_lighting({exposure = {exposure_correction = -2}})
    end,
})

weather.register_weather({
    name = "Deep Cave",
    conditions = {
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave - 20,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
        }
    },
    particlespawner = {
        y_spawn = {
            min = -16,
            max = 16
        },

        amount = 25,
        time = 2,

        collisiondetection = true,
        object_collision = true,

        vel = {
            min = vector.new(-16, -16, -16),
            max = vector.new(16, 16, 16),
            bias = 0
        },

        acc = vector.new(0, -9.8, 0),

        size = {
            min = 0.5,
            max = 2
        },

        exptime = {
            min = 2,
            max = 3
        },

        glow = 14,

        texpool = {
            {
                name = "1042_plain_node.png^[colorize:#222222:144",
                scale = 1,
                blend = "alpha"
            },
            {
                name = "1042_plain_node.png^[colorize:#111111:144",
                scale = 1,
                blend = "alpha"
            },
        }
    },

    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_sky({
            type = "regular",
            clouds = false,
            sky_color = {
                night_sky = "#203f36",
                night_horizon = "#203f36",
                day_horizon = "#203f36",
                day_sky = "#203f36",
                dawn_sky = "#203f36",
                dawn_horizon = "#203f36",
                indoors = "#203f36",
                fog_sun_tint = "#203f36",
                fog_moon_tint = "#203f36",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 100,
                fog_color = "#203f36"
            }
        })
        player:set_stars(
            {
                visible = false,
            }
        )
        player:set_moon(
            {
                visible = false,
            }
        )
        player:set_lighting({exposure = {exposure_correction = -4}})
    end,
})

local storm_timer = 0
weather.register_weather({
    name = "Storm",
    conditions = {
        temp = {
            min = 5,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave
        }
    },
    particlespawner = {
        amount = 8000,
        time = 1,

        collisiondetection = true,
        object_collision = true,
        vertical = true,

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

        texture = {
            name = "1042_rain.png",
            scale = {x=0.25, y=1}
        }
    },
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_sun(
            {
                visible = false
            }
        )
        player:set_clouds({
            density = 0.9,
            color = "#333333dd",
            ambient = "#333333",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = core_1042.shared_lib.consts.plain_world_y_levels.sea_level + 120
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#333333",
                night_horizon = "#333333",
                day_horizon = "#333333",
                day_sky = "#333333",
                dawn_sky = "#333333",
                dawn_horizon = "#333333",
                indoors = "#646464",
                fog_sun_tint = "#333333",
                fog_moon_tint = "#333333",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 40,
                fog_color = "#22222200"
            }
        })
        player:set_lighting({exposure = {exposure_correction = -2}})
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.1,
                count = 6000,
                star_color = "#99aaffff",
                scale = 0.3
            }
        )
        player:set_moon(
            {
                texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
                visible = true,
                scale = 0.3
            }
        )


        -- Sound
        players_weather.sound_handle = core.sound_play("storm", 
        {
            loop = true,
            to_player = name,
            gain = 0,
            pitch = 1
        })
        core.sound_fade(players_weather.sound_handle, 0.1, 0.75)
    end,
    on_step = function(player, timer)
        storm_timer = storm_timer + timer

        local function map(value, inMin, inMax, outMin, outMax)
            return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin)
        end

        local light = core.get_node_light(player:get_pos(), core.get_timeofday()) or 7
        local brightness = map(light, 0, 15, 0, 100)

        local s = core_1042.rand:next(1, 30) / 100
        local id = player:hud_add({
            type = "image",
            name = "rain",
            text = "rain_on_hud.png^[hsl:0:255:" .. brightness,
            position = {x = core_1042.rand:next(1, 1000) / 1000, y = core_1042.rand:next(1, 1000) / 1000},
            scale = {x = s, y = s},
        })

        core.after(core_1042.rand:next(2, 6), function()
            player:hud_remove(id)
        end)

        if storm_timer >= 1 then
            if core_1042.rand:next(1, 40) == 1 then
                player:set_lighting({exposure = {exposure_correction = core_1042.rand:next(10, 20)*0.1}})
                core.after(0.1, function()
                    player:set_lighting({exposure = {exposure_correction = -2}})
                end)
            end
            storm_timer = 0
        end
    end
})


local light_storm_timer = 0
weather.register_weather({
    name = "Light storm",
    conditions = {
        temp = {
            min = 0,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave
        }
    },
    particlespawner = {
        amount = 2000,
        time = 1,

        collisiondetection = true,
        object_collision = true,
        vertical = true,

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

        texture = {
            name = "1042_plain_node.png^[colorize:#004499:144",
            scale = {x=0.25, y=1}
        }
    },
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_clouds({
            density = 0.7,
            color = "#555555dd",
            ambient = "#555555",
            shadow = "#aaaaaa",
            thickness = 128,
            speed = {x=2, y=2},
            height = core_1042.shared_lib.consts.plain_world_y_levels.sea_level + 120
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#444444",
                day_sky = "#556666",
                dawn_sky = "#b4bafa",
                dawn_horizon = "#bac1f0",
                indoors = "#646464",
                fog_sun_tint = "#f47d1d",
                fog_moon_tint = "#7f99cc",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 40,
                fog_color = "#44444400"
            }
        })
        player:set_lighting({exposure = {exposure_correction = -1}})
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.1,
                count = 6000,
                star_color = "#99aaffff",
                scale = 0.3
            }
        )
        player:set_moon(
            {
                texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
                visible = true,
                scale = 0.3
            }
        )


        -- Sound
        players_weather.sound_handle = core.sound_play("rain", 
        {
            loop = true,
            to_player = name,
            gain = 0,
            pitch = 1
        })
        core.sound_fade(players_weather.sound_handle, 0.1, 0.5)
    end,

    on_step = function(player, timer)
        light_storm_timer = light_storm_timer + timer
        if light_storm_timer >= 0.5 then
            local function map(value, inMin, inMax, outMin, outMax)
                return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin)
            end
    
            local light = core.get_node_light(player:get_pos(), core.get_timeofday()) or 7
            local brightness = map(light, 0, 15, 0, 100)
    
            local s = core_1042.rand:next(1, 20) / 100
            local id = player:hud_add({
                type = "image",
                name = "rain",
                text = "rain_on_hud.png^[hsl:0:255:" .. brightness,
                position = {x = core_1042.rand:next(1, 1000) / 1000, y = core_1042.rand:next(1, 1000) / 1000},
                scale = {x = s, y = s},
            })

            core.after(core_1042.rand:next(2, 6), function()
                player:hud_remove(id)
            end)
            light_storm_timer = 0
        end
    end,
})


local drizzle_timer = 0
weather.register_weather({
    name = "Drizzle",
    conditions = {
        temp = {
            min = 0,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave
        }
    },
    particlespawner = {
        amount = 500,
        time = 1,

        collisiondetection = true,
        object_collision = true,
        vertical = true,

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

        texture = {
            name = "1042_plain_node.png^[colorize:#004499:144",
            scale = {x=0.25, y=1}
        }
    },
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_clouds({
            density = 0.7,
            color = "#f0faffaa",
            ambient = "#006699",
            thickness = 128,
            speed = {x=1, y=1},
            shadow = "#cccccc",
            height = core_1042.shared_lib.consts.plain_world_y_levels.sea_level + 120
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#90d3f6",
                day_sky = "#61b5f5",
                dawn_sky = "#b4bafa",
                dawn_horizon = "#bac1f0",
                indoors = "#646464",
                fog_sun_tint = "#f47d1d",
                fog_moon_tint = "#7f99cc",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 270,
                fog_color = "#ffffff00"
            }
        })
        player:set_lighting({exposure = {exposure_correction = -0.3}})
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.1,
                count = 6000,
                star_color = "#99aaffff",
                scale = 0.3
            }
        )
        player:set_moon(
            {
                texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
                visible = true,
                scale = 0.3
            }
        )


        -- Sound
        players_weather.sound_handle = core.sound_play("rain", 
        {
            loop = true,
            to_player = name,
            gain = 0,
            pitch = 1
        })
        core.sound_fade(players_weather.sound_handle, 0.1, 0.25)
    end,

    on_step = function(player, timer)
        drizzle_timer = drizzle_timer + timer
        if drizzle_timer >= 1 then
            local function map(value, inMin, inMax, outMin, outMax)
                return outMin + (value - inMin) * (outMax - outMin) / (inMax - inMin)
            end
    
            local light = core.get_node_light(player:get_pos(), core.get_timeofday()) or 7
            local brightness = map(light, 0, 15, 0, 100)
    
            local s = core_1042.rand:next(1, 10) / 100
            local id = player:hud_add({
                type = "image",
                name = "rain",
                text = "rain_on_hud.png^[hsl:0:255:" .. brightness,
                position = {x = core_1042.rand:next(1, 1000) / 1000, y = core_1042.rand:next(1, 1000) / 1000},
                scale = {x = s, y = s},
            })

            core.after(core_1042.rand:next(2, 6), function()
                player:hud_remove(id)
            end)

            drizzle_timer = 0
        end
    end,
})


weather.register_weather({
    name = "Light snow",
    conditions = {
        temp = {
            max = -3
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.deep_cave
        }
    },
    particlespawner = {
        amount = 1000,
        time = 1,
        _1042_weather_box_distance = 32,

        collisiondetection = true,
        object_collision = true,
        collision_removal = true,

        vel = {
            min = vector.new(-2, -4, -2),
            max = vector.new(2, -6, 2),
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

        glow = 10,

        texpool = {
            {
                name = "snowflake1.png",
                blend = "alpha"
            },
            {
                name = "snowflake2.png",
                blend = "alpha"
            },
            {
                name = "snowflake3.png",
                blend = "alpha"
            },
            {
                name = "snowflake4.png",
                blend = "alpha"
            }
        }
    },
    on_change = function(player, name, players_weather)
        -- Sky changes
        player:set_clouds({
            density = 0.35,
            color = "#f0faffaa",
            ambient = "#006699",
            thickness = 128,
            speed = {x=1, y=1},
            shadow = "#cccccc",
            height = core_1042.shared_lib.consts.plain_world_y_levels.sea_level + 120
        })
        player:set_sky({
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#90d3f6",
                day_sky = "#61b5f5",
                dawn_sky = "#b4bafa",
                dawn_horizon = "#bac1f0",
                indoors = "#646464",
                fog_sun_tint = "#f47d1d",
                fog_moon_tint = "#7f99cc",
                fog_tint_type = "custom"
            },
            fog = {
                fog_start = 0,
                fog_distance = 270,
                fog_color = "#ddddddaa"
            }
        })
        player:set_lighting({exposure = {exposure_correction = 0.3}})
        player:set_stars(
            {
                visible = true,
                day_opacity = 0.1,
                count = 6000,
                star_color = "#99aaffff",
                scale = 0.3
            }
        )
        player:set_moon(
            {
                texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
                visible = true,
                scale = 0.3
            }
        )
    end,
})


