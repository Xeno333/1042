

weather.register_weather({
    name = "Hail",
    conditions = {
        temp = {
            min = -5,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
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
                blend = "clip"
            },
            {
                name = "hail.png",
                scale = 0.5,
                blend = "clip"
            },
            {
                name = "hail.png",
                scale = 0.25,
                blend = "clip"
            }
        }
    },
    on_step = function(player)
        local pos = player:get_pos()
        local clear, pos = core.line_of_sight(vector.new(pos.x, pos.y+1, pos.z), vector.new(pos.x, pos.y+weather.weather_hight, pos.z))

        if clear then
            if core_1042.rand:next(1, 4) == 1 then
                player:set_hp(player:get_hp()-1, "Hail")
            end
        end

        if core_1042.rand:next(1, 10) == 1 then
            player:set_lighting({exposure = {exposure_correction = core_1042.rand:next(10, 20)*0.1}})
            core.after(0.1, function()
                player:set_lighting({exposure = {exposure_correction = -2}})
            end)
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
            height = 120
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
    name = "Storm",
    conditions = {
        temp = {
            min = 5,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
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
            name = "1042_plain_node.png^[colorize:#0044aa:144",
            scale = {x=0.25, y=1}
        }
    },
    on_step = function(player)
        if core_1042.rand:next(1, 40) == 1 then
            player:set_lighting({exposure = {exposure_correction = core_1042.rand:next(10, 20)*0.1}})
            core.after(0.1, function()
                player:set_lighting({exposure = {exposure_correction = -2}})
            end)
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
            height = 120
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
})



weather.register_weather({
    name = "Light storm",
    conditions = {
        temp = {
            min = 0,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
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
            height = 120
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
})


weather.register_weather({
    name = "Drizzle",
    conditions = {
        temp = {
            min = 0,
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
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
            height = 120
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
})


weather.register_weather({
    name = "Light snow",
    conditions = {
        temp = {
            max = 0
        },
        y_level = {
            max = core_1042.shared_lib.consts.plain_world_y_levels.max,
            min = core_1042.shared_lib.consts.plain_world_y_levels.min
        }
    },
    particlespawner = {
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

        glow = 10,

        texpool = {
            {
                name = "snowflake1.png",
                blend = "clip"
            },
            {
                name = "snowflake2.png",
                blend = "clip"
            },
            {
                name = "snowflake3.png",
                blend = "clip"
            },
            {
                name = "snowflake4.png",
                blend = "clip"
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
            height = 120
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
    end,
})


