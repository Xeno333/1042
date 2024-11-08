-- init.lua
mapgen_1042 = {}


local path = core.get_modpath("1042_mapgen")

--dofile(path.."/api.lua")
--dofile(path.."/mapgen.lua")


-- Settings
local T_ymax = 128
local T_ymin = -T_ymax*2
local water_level = -3
local lava_level = -240
local bedrock_level = -256
local caves_max = T_ymax-68
local decorated_caves = -64





-- Mapgen

local map, cave_map, ore_map

local stone = core.get_content_id("1042_nodes:stone")
local dirt = core.get_content_id("1042_nodes:dirt")
local sand = core.get_content_id("1042_nodes:sand")
local turf = core.get_content_id("1042_nodes:turf")
local turf_dry = core.get_content_id("1042_nodes:turf_dry")
local snow = core.get_content_id("1042_nodes:snow")
local bedrock = core.get_content_id("1042_nodes:bedrock")
local lava = core.get_content_id("1042_nodes:lava_source")
local iorn_ore = core.get_content_id("1042_nodes:iorn_ore")

local water = core.get_content_id("1042_nodes:water_source")
local ice = core.get_content_id("1042_nodes:ice")

local rock = core.get_content_id("1042_nodes:rock")
local sticks = core.get_content_id("1042_nodes:sticks")
local iorn_nugget = core.get_content_id("1042_nodes:iorn_nugget")
local beryl = core.get_content_id("1042_nodes:beryl")

local grass_tall = core.get_content_id("1042_nodes:grass_tall")
local grass_short = core.get_content_id("1042_nodes:grass_short")
local grass_snowy = core.get_content_id("1042_nodes:grass_snowy")
local mushroom = core.get_content_id("1042_nodes:mushroom")

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

    ore_map = core.get_perlin_map({
        offset = 0,
        scale = 1,
        spread = {x = 10, y = 10, z = 10},
        seed = 26354,
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



function mapgen_1042.get_spawn_y(x, z)
    local noise = map:get_2d_map({z=0,y=x, x=z})[1][1]
    local ny
    local mountin_top = false

    if noise <= 0.9 then
        if noise > -0.5 then
            -- Normal gen
            ny = (noise * math.abs(noise)) * T_ymax
            if ny < water_level then 
                return false
            end
        else
            return false
        end
    else
        return false
    end
    
    return math.floor(ny)
end




local schematic_path = core.get_modpath("1042_mapgen") .. "/schematics/"


local function stone_gen(noise, y, data, vi)
    if noise < -1.3 then
        data[vi] = iorn_ore
        return
    end
    
    data[vi] = stone
end

local function dec(pr, x, y, z, data, area, place_list, tempv, cave)
    local c = pr:next(1, 1000)
    
    if cave then
        if c <= 30 then
            data[area:index(x, y+1, z)] = rock

        elseif c <= 45 then
            data[area:index(x, y+1, z)] = iorn_nugget

        elseif c <= 60 and y <= decorated_caves then
            data[area:index(x, y+1, z)] = beryl

        end

    -- Land
    elseif y > water_level then
        if tempv > 0 and not (tempv >= 20) then
            -- Grass
            if c <= 20 then
                data[area:index(x, y+1, z)] = grass_tall
            elseif c < 100 then
                data[area:index(x, y+1, z)] = grass_short
                
            elseif c == 100 and y > water_level+3 then
                data[area:index(x, y+1, z)] = sticks

            -- Small tree
            elseif c > 995 and y > water_level+3 then
                place_list[#place_list+1] = 
                    function()
                        core.place_schematic(vector.new(x-4,y,z-4), schematic_path .. "tree_plain_1.mts", "random", nil, true)
                    end

            -- Big tree
            elseif y >= water_level+10 and tempv >= 15 and tempv <= 25 then
                if c == 995 then
                    place_list[#place_list+1] = 
                        function()
                            core.place_schematic(vector.new(x-7,y,z-7), schematic_path .. "big_tree_1.mts", "random", nil, true)
                        end
                end
            end

        elseif tempv >= 20 then
            if c <= 10 then
                data[area:index(x, y+1, z)] = grass_short
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



core.register_on_generated(function(minp, maxp, seed)
    local vm, emin, emax = core.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    local noise_m = map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local m_pos = {z=minp.x,y=minp.y,x=minp.z}
    local cave_noise_m = cave_map:get_3d_map(m_pos)
    local ore_noise_m = ore_map:get_3d_map(m_pos)

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

                if y <= bedrock_level then
                    if  y == bedrock_level then
                        data[vi] = bedrock
                    end
                    vi = vi + 1
                    goto skip
                end

                lx = lx + 1
                -- Get properties of land
                local noise = noise_m[lx][lz]
                local ny, rv
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

                if tempv >= 20 then
                    top = turf_dry
                end

                if mountin_top then
                    top = dirt
                    do_dec = false
                end

                -- Place and handel caves
                if cave_noise_m[lx][ly][lz] > -0.95 or y > caves_max then
                    if y < (ny-1) then
                        stone_gen(ore_noise_m[lx][ly][lz], y, data, vi)

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
                            dec(pr, x, y, z, data, area, place_list, tempv, false)
                        end
                    end
                elseif y <= ny and y<= lava_level then
                    data[vi] = lava
                else
                    if cave_noise_m[lx][ly-1] and cave_noise_m[lx][ly-1][lz] > -0.95 and y <= ny then
                        dec(pr, x, y-1, z, data, area, place_list, tempv, true)
                    end
                end

                if ((y <= water_level) or (mountin_top and y < rv)) and y > ny then
                    if y == water_level then
                        data[vi] = liquid_top
                    else
                        data[vi] = liquid
                    end
                end


                vi = vi + 1
                ::skip::
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
