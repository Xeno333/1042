mapgen_1042 = {}


if not core_1042 then core_1042 = {} end
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



function mapgen_1042.get_spawn_y(x, z)
    local noise = mapgen_1042.map_single:get_2d(vector.new(z, x, 0))
    local ny

    local r = math.sqrt(x^2+z^2)
    
    if noise <= 0.9 and noise > -0.5 then
        -- Normal gen
        ny = (noise * math.abs(noise)) * mapgen_1042.ymax

        -- Border
        if r > mapgen_1042.continent_radius then
            local offset = math.max(0, math.min(T_ymax, (1/3)*(r-mapgen_1042.continent_radius)))
            ny = ny - offset
        end

        -- Under water
        if ny < mapgen_1042.water_level then 
            return false
        end

        return math.floor(ny)
    end
    
    return false
end