-- init.lua
mapgen_1042 = {}


local path = core.get_modpath("1042_mapgen")

dofile(path.."/api.lua")


-- Settings
local T_ymax = 128
local T_ymin = -T_ymax*2
local water_level = -3
local caves_max = T_ymax-68


local dirt_n = "1042_nodes:dirt"
local turf_n = "1042_nodes:turf"
local snow_n = "1042_nodes:snow"
local sand_n = "1042_nodes:sand"
local stone_n = "1042_nodes:stone"
local rock_n = "1042_nodes:rock"
local sticks_n = "1042_nodes:sticks"
local water_n = "1042_nodes:water_source"
local grass_tall_n = "1042_nodes:grass_tall"
local grass_short_n = "1042_nodes:grass_short"
local mushroom_n = "1042_nodes:mushroom"
local ice_n = "1042_nodes:ice"
local grass_snowy_n = "1042_nodes:grass_snowy"




-- Mapgen

local map, cave_map
local stone = core.get_content_id(stone_n)
local turf = core.get_content_id(turf_n)
local snow = core.get_content_id(snow_n)
local sand = core.get_content_id(sand_n)
local dirt = core.get_content_id(dirt_n)
local sticks = core.get_content_id(sticks_n)
local rock = core.get_content_id(rock_n)
local water = core.get_content_id(water_n)
local grass_tall = core.get_content_id(grass_tall_n)
local grass_short = core.get_content_id(grass_short_n)
local grass_snowy = core.get_content_id(grass_snowy_n)
local mushroom = core.get_content_id(mushroom_n)
local ice = core.get_content_id(ice_n)

core.after(0,function()
    map = core.get_perlin_map({
        offset = 0,
        scale = 1,
        spread = {x = 800, y = 800, z = 800},
        seed = 3754634652,
        octaves = 5,
        persist = 0.5,
        lacunarity = 2,
        flags = {
            eased = true,
            absvalue = false,
            defaults = false
        }
    }, {x=80, y=80})

    cave_map = core.get_perlin_map({
        offset = 0,
        scale = 1,
        spread = {x = 50, y = 20, z = 50},
        seed = 34634,
        octaves = 3,
        persist = 0.7,
        lacunarity = 2,
        flags = {
            eased = true,
            absvalue = false,
            defaults = false
        }
    }, {x=80, y=80, z=80})
end)


local schematic_path = core.get_modpath("1042_mapgen") .. "/schematics/"

local function dec(pr, x, y, z, data, area, place_list, tempv)
    local c = pr:next(1, 1000)
    
    -- Land
    if y > water_level then
        if tempv > 0 then
            -- Grass
            if c <= 20 then
                data[area:index(x, y+1, z)] = grass_tall
            elseif c <= 100 then
                data[area:index(x, y+1, z)] = grass_short

            if c == 100 then
                data[area:index(x, y+1, z)] = rock
            end

            -- Small tree
            elseif c >= 995 and y > water_level+3 then
                place_list[#place_list+1] = 
                    function()
                        core.place_schematic({x=x-4,y=y,z=z-4}, schematic_path .. "tree_plain_1.mts", "random", nil, true)
                    end

            -- Big tree
            elseif y >= water_level+10 and tempv >= 15 and tempv <= 25 then
                if c == 995 then
                    place_list[#place_list+1] = 
                        function()
                            core.place_schematic({x=x-7,y=y,z=z-7}, schematic_path .. "big_tree_1.mts", "random", nil, true)
                        end
                end
            end
        else
            -- Snow grass
            if c >= 990 then
                data[area:index(x, y+1, z)] = grass_snowy
            end
        end

    else
        if c <= 10 and y == water_level then
            data[area:index(x, y+1, z)] = rock
        end
    end

end



-- Example usage: generating terrain height
core.register_on_generated(function(minp, maxp, seed)
    local vm, emin, emax = core.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    local noise_m = map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local cave_noise_m = cave_map:get_3d_map({z=minp.x,y=minp.y,x=minp.z})

    local tm = weather.get_temp_map(minp.x, minp.z)

    local place_list = {}

    -- Add for T_ymin just do stone

    local ly = 81
    for y = maxp.y, minp.y, -1 do
        ly = ly - 1
        local lz = 0
        for z = minp.z, maxp.z do
            lz = lz + 1
            local vi = area:index(minp.x, y, z)
            local lx = 0
            for x = minp.x, maxp.x do
                lx = lx + 1

                -- Get properties of land
                local noise = noise_m[lx][lz]
                local ny
                local rv = nil
                local mountin_top = false

                if noise <= 0.9 then
                    if noise > -0.5 then
                        -- Normal gen
                        ny = (noise * math.abs(noise)) * T_ymax
                    else
                        -- Deep sea Gen
                        ny = (noise * 4) * T_ymax + (1.75 * T_ymax)
                    end
                else
                    -- Mountin hole
                    ny = (0.9 * math.abs(0.9)) * T_ymax - (noise * math.abs(noise)) * T_ymax/8 + 4
                    rv = (0.9 * math.abs(0.9)) * T_ymax - 3
                    mountin_top = true
                end
                
                ny = math.floor(ny)


                local tempv = weather.get_temp({x=lx, y=y, z=lz}, tm)

                local mid = dirt
                local low = stone
                local top_2 = sand

                local top = turf
                local liquid = water
                local liquid_top = water
                local do_dec = true

                if tempv <= 0 then
                    liquid_top = ice
                    liquid = water
                    top = snow
                end
                if mountin_top then
                    top = dirt
                    do_dec = false
                end

                -- Place and handel caves
                if cave_noise_m[lx][ly][lz] > -0.95 or y > caves_max then
                    if y < (ny-1) then
                        data[vi] = stone

                    elseif y == (ny-1) then
                        data[vi] = mid

                    elseif y == ny then
                        if y > water_level then
                            data[vi] = top

                        elseif y < water_level then
                            data[vi] = mid

                        else
                            data[vi] = top_2

                        end

                        if do_dec then
                            dec(pr, x, y, z, data, area, place_list, tempv)
                        end
                    end
                end

                if (y <= water_level and y > ny) or (noise > 0.9 and (y < rv and y > ny))then
                    if y == water_level then
                        data[vi] = liquid_top
                    else
                        data[vi] = liquid
                    end
                end

                vi = vi + 1
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_liquids()

    for _, func in ipairs(place_list) do
        func()
    end

    core.fix_light(minp, maxp)
end)

