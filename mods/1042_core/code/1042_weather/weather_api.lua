-- weather_api.lua
--[[
    Core API meant to be shared in both mapgen enviorment and main.
]]
weather = {}

weather.rand = PcgRandom(math.random(1, 2048))


local weather_def = {
    offset = 0,
    scale = 1,
    spread = {x = 1000, y = 1000, z = 1000},
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

local temp_m = PerlinNoiseMap(weather_def, {x=80, y=80, z=0})
local temp_s = PerlinNoise(weather_def)

-- Single vector to be used once so as to not make a whole bunch
local v = vector.new(0, 0, 0)


function weather.get_temp_map(x, z)
    v.x = z
    v.y = x
    return temp_m:get_2d_map(v)
end

-- max temp = 30, min = -10

function weather.get_temp(pos, temp_map)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        return math.max(math.min(temp_map[pos.x][pos.z] * 30, 30), -30)

    elseif pos.y <= core_1042.shared_lib.consts.underworldworld_y_levels.max and pos.y >= core_1042.shared_lib.consts.underworldworld_y_levels.min then
        return 30

    elseif pos.y <= core_1042.shared_lib.consts.sky_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.sky_world_y_levels.min then
        return -30
    end
end


function weather.get_temp_single(pos)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        v.x = pos.z
        v.y = pos.x
        local tempv = math.max(math.min(temp_s:get_2d(v) * 30, 30), -30)
        return tempv

    elseif pos.y <= core_1042.shared_lib.consts.underworldworld_y_levels.max and pos.y >= core_1042.shared_lib.consts.underworldworld_y_levels.min then
        return 30

    elseif pos.y <= core_1042.shared_lib.consts.sky_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.sky_world_y_levels.min then
        return -30
    end
end


-- This equation is hard coded in mapgen!
function weather.get_biome_palette_index(temp)
    return math.max(math.min(math.floor(((temp / 30) + 1) * 8 * 16) - 1, 255), 0)
end