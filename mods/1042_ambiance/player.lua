

core.register_on_joinplayer(function(player, last_join)
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
                intensity = 0.4,
                tint = {r=0x99, g=0x99, b=0x99}
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


    local zoom_time = 0
    if last_join == nil then
        zoom_time = 1

        core.chat_send_player(player:get_player_name(), core.colorize("#00ff00", "It is the year 1042 and you are lost."))
        
    else
        core.chat_send_player(player:get_player_name(), "It is day " .. core.get_day_count() .. " of being lost.")
    end

    player:set_fov(100, false, zoom_time)
end)


-- Add sounds