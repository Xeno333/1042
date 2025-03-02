-- weathers_api.lua
--[[
    The 1042 weather API, not needed for mapgen and only loaded if enabled.
]]




-- Weathers


weather.players_weather = {}
weather.weather_hight = 16

core.register_on_joinplayer(function(player)
    weather.players_weather[player:get_player_name()] = {}
end)

core.register_on_leaveplayer(function(player)
    weather.players_weather[player:get_player_name()] = nil
end)



-- Add default sky, clouds, lighting, sun AND add moon definitions so they can be re-used by mods. #fixme





function weather.default_on_change(player, name, players_weather)
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
            day_horizon = "#70d3f6",
            day_sky = "#41b5f5",
            dawn_sky = "#b4bafa",
            dawn_horizon = "#bac1f0",
            indoors = "#646464",
            fog_sun_tint = "#f47d1d",
            fog_moon_tint = "#7f99cc",
            fog_tint_type = "custom"
        },
        fog = {
            fog_start = 0,
            fog_distance = 360,
            fog_color = "#ffffff00"
        }
    })
    player:set_sun(
        {
            visible = true,
            texture = "1042_plain_node.png^[colorize:#ddaa66:144",
            scale = 0.5
        }
    )
    
    local saturation = 1.8
    if core_1042.get("playersetting_"..name.."_greyscale") == "true" then
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
            saturation = saturation,
            exposure = {
                exposure_correction = 0.75
            }
        }
    )
end





weather.weathers = {
    {
        name = "Plain",
        conditions = {
            y_level = {
                max = core_1042.shared_lib.consts.plain_world_y_levels.max,
                min = core_1042.shared_lib.consts.plain_world_y_levels.min
            }
        },
        on_change = weather.default_on_change
    }
}

core.register_on_mods_loaded(function()
    weather.weather_index = weather.rand:next(1, #weather.weathers)
end)


function weather.register_weather(def)
    weather.weathers[#weather.weathers+1] = def
end






-- Weather
function weather.get_weather_at_pos(pos)
    local i = weather.weather_index
    local temp = weather.get_temp_single(pos)

    for n=1,#weather.weathers do -- Avoid inf loop
        local weather_t = weather.weathers[i]
        if not weather_t.conditions then
            return i
        end

        -- If there is no value then skip it but other wise make sure in range
        if (not weather_t.conditions.y_level) or (((not weather_t.conditions.y_level.max) or weather_t.conditions.y_level.max >= pos.y) and ((not weather_t.conditions.y_level.max) or weather_t.conditions.y_level.max >= pos.y)) then
            if weather_t.conditions.temp then
                if weather_t.conditions.temp.max and weather_t.conditions.temp.max >= temp then
                    if not weather_t.conditions.temp.min or weather_t.conditions.temp.min >= temp then
                        return i
                    end
                elseif weather_t.conditions.temp.min and weather_t.conditions.temp.min <= temp then
                    if not weather_t.conditions.temp.max or weather_t.conditions.temp.max <= temp then
                        return i
                    end
                end
            else
                return i
            end
        end

        i = i + 1
        if i > #weather.weathers then
            i = 1
        end
    end

    -- If none found leave as is, or it will not work
    return weather.weather_index
end

