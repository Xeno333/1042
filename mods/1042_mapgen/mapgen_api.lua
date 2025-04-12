mapgen_1042 = {}


if rawget(_G, "core_1042") == nil then core_1042 = {} end
if not core_1042.shared_lib then
    dofile(core.get_modpath("1042_core").."/src/shared_lib.lua")
end

local map_noise_params = {
    offset = 0,
    scale = 1,
    spread = {x = 800, y = 800, z = 800},
    seed = core.get_mapgen_setting("seed") + 3754634652,
    octaves = 5,
    persist = 0.5,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

mapgen_1042.map = PerlinNoiseMap(map_noise_params, {x=80, y=80})
mapgen_1042.map_single = PerlinNoise(map_noise_params)


local map_noise_params_2 = {
    offset = 0,
    scale = 1,
    spread = {x = 40, y = 40, z = 40},
    seed = core.get_mapgen_setting("seed") + 3754634652,
    octaves = 5,
    persist = 0.5,
    lacunarity = 1,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

mapgen_1042.map2 = PerlinNoiseMap(map_noise_params_2, {x=80, y=80})
mapgen_1042.map_single2 = PerlinNoise(map_noise_params_2)

local map_noise_params_2_1 = {
    offset = 0,
    scale = 1,
    spread = {x = 20, y = 20, z = 20},
    seed = core.get_mapgen_setting("seed") + 354634652,
    octaves = 5,
    persist = 0.5,
    lacunarity = 1,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}

mapgen_1042.map2_1 = PerlinNoiseMap(map_noise_params_2_1, {x=80, y=80})
mapgen_1042.map_single2_1 = PerlinNoise(map_noise_params_2_1)


--[[local map_noise_params_tectonics = {
    offset = 0,
    scale = 1,
    spread = {x = 2000, y = 2000, z = 2000},
    seed = core.get_mapgen_setting("seed") + 2363673,
    octaves = 5,
    persist = 0.5,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}
mapgen_1042.map_tectonics = PerlinNoiseMap(map_noise_params_tectonics, {x=80, y=80})
mapgen_1042.map_single_tectonics = PerlinNoise(map_noise_params_tectonics)]]


mapgen_1042.cave_map = PerlinNoiseMap({
    offset = 0,
    scale = 1,
    spread = {x = 50, y = 30, z = 50},
    seed = core.get_mapgen_setting("seed") + 34634,
    octaves = 3,
    persist = 0.7,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}, {x=80, y=80, z=80})

mapgen_1042.ore_map = PerlinNoiseMap({
    offset = 0,
    scale = 1,
    spread = {x = 10, y = 10, z = 10},
    seed = core.get_mapgen_setting("seed") + 26354,
    octaves = 3,
    persist = 0.7,
    lacunarity = 2,
    flags = {
        eased = true,
        absvalue = false,
        defaults = false
    }
}, {x=80, y=80, z=80})


mapgen_1042.ymax = core_1042.shared_lib.consts.plain_world_y_levels.max
mapgen_1042.ymin = core_1042.shared_lib.consts.plain_world_y_levels.min
mapgen_1042.water_level = 0
mapgen_1042.lava_level = -240
mapgen_1042.bedrock_level = -256
mapgen_1042.caves_max = mapgen_1042.ymax-68
mapgen_1042.decorated_caves = -64
mapgen_1042.continent_radius = 30000




local T_ymax = mapgen_1042.ymax
local T_ymin = mapgen_1042.ymin
local continent_radius = mapgen_1042.continent_radius

function mapgen_1042.get_y(x, z, noisei)
    local noise = noisei
    if not noise then
        noise = mapgen_1042.map_single:get_2d(vector.new(z, x, 0))
    end

    local ny
    local mountin_top = false

    -- Distance from (0,y,0)
    local r = math.sqrt(x^2+z^2)
    if noise <= 0.9 or r > continent_radius then -- make sure always runs if beyond cont range
        if noise > -0.5 then
            -- Normal gen
            ny = math.floor((noise * math.abs(noise)) * T_ymax)
        else
            -- Deep sea Gen
            ny = math.floor((noise) * math.abs(T_ymin) + (0.75*T_ymax) )
        end

        -- Border
        if r > continent_radius then
            local offset = math.floor(math.max(0, math.min(T_ymax, (1/3)*(r-continent_radius))))
            ny = ny - offset
        end
    else
        -- Mountin hole
        ny = math.floor((0.9 * math.abs(0.9)) * T_ymax - (noise * math.abs(noise)) * T_ymax/8 + 4)
        local rv = math.floor((0.9 * math.abs(0.9)) * T_ymax - 3)
        return math.floor(ny), rv, true, noise
    end
    

    return ny, nil, false, noise
end







function mapgen_1042.get_spawn_y(x, z)
    local temp = weather.get_temp_single(vector.new(x, 0, z))
    if not (temp >= 10 and temp <= 20) then -- Temp range
        return false
    end

    local y, _, _, noise = mapgen_1042.get_y(x, z, nil)

    if noise <= 0.9 and noise > -0.5 then
        -- Under water
        if y <= mapgen_1042.water_level then 
            return false
        end

        return y
    end

    return false
end


