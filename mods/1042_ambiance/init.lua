

core.register_on_joinplayer(function(player)
    local saturation = 1.8
    if core_1042.get("playersetting_"..player:get_player_name().."_greyscale") == "true" then
        saturation = 0
    end

    player:set_lighting(
        {
            volumetric_light = {
                strength = 0.1
            },
            shadows = {
                intensity = 0.15
            },
            bloom = {
                intensity = 0.07,
                strength_factor = 1.0,
                radius = 1.0
            },
            saturation = saturation
        }
    )
    player:set_sky(
        {
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff"
            },
            fog = {
                fog_start = 0
            }
        }
    )
    player:set_clouds(
        {
            density = 0.35,
            color = "#f0faffaa",
            ambient = "#006699",
            thickness = 128,
            speed = {x=1, y=1},
            shadow = "#cccccc"
        }
    )
    player:set_sun(
        {
            texture = "1042_plain_node.png^[colorize:#ddaa66:144",
            scale = 0.5
        }
    )
    player:set_moon(
        {
            texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
            visible = true,
            scale = 0.3
        }
    )
    player:set_stars(
        {
            visible = true,
            day_opacity = 0.1,
            count = 6000,
            star_color = "#99aaffff",
            scale = 0.3
        }
    )

    --[[local pos = player:get_pos()

    core.add_particlespawner(
        {
            amount = 1000,
            time = 0,

            minpos = {x=pos.x-10, y=pos.y-10, z=pos.z-10},
            maxpos = {x=pos.x+10, y=pos.y+10, z=pos.z+10},
            
            minvel = {x = -2, y = -8, z = -2},
            maxvel = {x = 2, y = -16, z = 2},
            minacc = {x = 0, y = -9.8, z = 0},  -- Gravity pulls particles down
            minexptime = 2,
            maxexptime = 5,
            minsize = 0.5,
            maxsize = 1.5,

            glow = 2,

            texture = "1042_plain_node.png^[colorize:#004499:144"
        }
    )]]

    core.chat_send_player(player:get_player_name(), "It is day " .. core.get_day_count() .. " of being lost.")
end)


-- Add sounds