-- weather_api.lua
--[[
    Core API meant to be shared in both mapgen enviorment and main.
]]
weather = {}

weather.rand = PcgRandom(math.random(1, 2048))


-- Single vector to be used once so as to not make a whole bunch
local v = vector.new(0, 0, 0)


-- humidity

local humidity_def = {
    offset = 1,
    scale = 1,
    spread = {x = 1000, y = 1000, z = 1000},
    seed = core.get_mapgen_setting("seed") + 253663243,
    octaves = 1,
    persist = 0,
    lacunarity = 0,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

local humidity_m = PerlinNoiseMap(humidity_def, {x=80, y=80, z=0})
local humidity_s = PerlinNoise(humidity_def)
local humidity_percent_meter = 0.004


function weather.get_humidity_map(x, z)
    v.x = z
    v.y = x
    return humidity_m:get_2d_map(v)
end


function weather.get_humidity(pos, humidity_map)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        return math.max(math.min((humidity_map[pos.x][pos.z] + (-pos.y * humidity_percent_meter)) * 50, 100), 0)

    else
        return 0
    end
end

function weather.get_humidity_single(pos)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        v.x = pos.z
        v.y = pos.x

        return math.max(math.min((humidity_s:get_2d(v) + (-pos.y * humidity_percent_meter)) * 50, 100), 0)
    else
        return 0
    end
end




-- temp

local temp_def = {
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

local temp_m = PerlinNoiseMap(temp_def, {x=80, y=80, z=0})
local temp_s = PerlinNoise(temp_def)
local temp_percent_meter = 0.005


function weather.get_temp_map(x, z)
    v.x = z
    v.y = x
    return temp_m:get_2d_map(v)
end


function weather.get_temp(pos, temp_map)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        return math.max(math.min((temp_map[pos.x][pos.z] + (-pos.y * temp_percent_meter)) * 30, 30), -30)

    elseif pos.y <= core_1042.shared_lib.consts.underworldworld_y_levels.max and pos.y >= core_1042.shared_lib.consts.underworldworld_y_levels.min then
        return 30

    elseif pos.y <= core_1042.shared_lib.consts.sky_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.sky_world_y_levels.min then
        return -30
    else
        return 0
    end
end


function weather.get_temp_single(pos)
    if pos.y <= core_1042.shared_lib.consts.plain_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.plain_world_y_levels.min then
        v.x = pos.z
        v.y = pos.x
        return math.max(math.min((temp_s:get_2d(v) + (-pos.y * temp_percent_meter)) * 30, 30), -30)

    elseif pos.y <= core_1042.shared_lib.consts.underworldworld_y_levels.max and pos.y >= core_1042.shared_lib.consts.underworldworld_y_levels.min then
        return 30

    elseif pos.y <= core_1042.shared_lib.consts.sky_world_y_levels.max and pos.y >= core_1042.shared_lib.consts.sky_world_y_levels.min then
        return -30
    else
        return 0
    end
end


-- This equation is hard coded in mapgen!
function weather.get_biome_palette_index(temp, humidity)
    --print(temp, math.floor((((temp + 30) / 60)) * 15))
    --print(humidity, math.floor((humidity / 100) * 15))
    --print((math.floor((((temp + 30) / 60)) * 15) * 16) + math.floor((humidity / 100) * 15))

    return (math.floor((((temp + 30) / 60)) * 15) * 16) + math.floor((humidity / 100) * 15)
end