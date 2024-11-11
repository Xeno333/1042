-- weather_api.lua
weather = {}



local weather_def = {
    offset = 0,
    scale = 1,
    spread = {x = 600, y = 600, z = 600},
    seed = core.get_mapgen_setting("seed") + 253643,
    octaves = 3,
    persist = 0.3,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

local temp_m = PerlinNoiseMap(weather_def, {x=80, y=80})



function weather.get_temp_map(x, z)
    return temp_m:get_2d_map({z=0,y=x, x=z})
end

function weather.get_temp(pos, temp_map)
    local tempv = temp_map[pos.x][pos.z] * 30
    return tempv
end

