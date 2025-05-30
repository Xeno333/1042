-- mapgen.lua

-- Todo Make modable using normal mapgen definitions for biomes and schematics #fixme

dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/mapgen_api.lua")

-- Weather api
dofile(core_1042.get_core_mod_path("1042_weather") .. "/weather_api.lua")

-- schematics api
dofile(core_1042.get_core_mod_path("1042_schematics") .. "/schematics_api.lua")


-- register schematics
local schematic_path = core_1042.get_core_mod_path("1042_mapgen") .. "/schematics/"

local schem = schematics_1042.load_schematic(schematic_path .. "/big_tree_1")
schematics_1042.register_schematic("big_tree_1", schem)

schem = schematics_1042.load_schematic(schematic_path .. "/big_tree_dark_1")
schematics_1042.register_schematic("big_tree_dark_1", schem)

schem = schematics_1042.load_schematic(schematic_path .. "/big_tree_light_1")
schematics_1042.register_schematic("big_tree_light_1", schem)



-- Settings
local T_ymax = mapgen_1042.ymax
local T_ymax_Real = mapgen_1042.d_ymax
local T_ymin = mapgen_1042.ymin
local water_level = mapgen_1042.water_level
local lava_level = mapgen_1042.lava_level
local bedrock_level = mapgen_1042.bedrock_level
local caves_max = mapgen_1042.caves_max
local decorated_caves = mapgen_1042.decorated_caves
local treasure_y = mapgen_1042.water_level - 10





-- Mapgen


local bedrock = core.get_content_id("1042_core:bedrock")
local skyrock = core.get_content_id("1042_core:skyrock")


local stone = core.get_content_id("mapgen_stone")
local dirt = core.get_content_id("1042_core:dirt")
local sand = core.get_content_id("1042_core:sand")
local turf = core.get_content_id("1042_core:turf")
local snow = core.get_content_id("1042_core:snow")
local lava = core.get_content_id("1042_core:lava_source")
local iron_ore = core.get_content_id("1042_core:iron_ore")

local water = core.get_content_id("mapgen_water_source")
local ice = core.get_content_id("1042_core:ice")

local rock = core.get_content_id("1042_core:rock")
local sticks = core.get_content_id("1042_core:sticks")
local iron_nugget = core.get_content_id("1042_core:iron_nugget")
local beryl = core.get_content_id("1042_core:beryl")
local flint = core.get_content_id("1042_core:flint")
local beryl_top = core.get_content_id("1042_core:beryl_hanging")

local grass_tall = core.get_content_id("1042_core:grass_tall")
local grass_short = core.get_content_id("1042_core:grass_short")
local mushroom = core.get_content_id("1042_core:mushroom")

local chest = core.get_content_id("1042_core:chest")
local air = core.get_content_id("air")



local node2 = core.get_content_id("1042_core:node2")
local water2 = core.get_content_id("1042_core:water_source2")








local function dec(pr, x, y, z, data, area, place_list, tempv, cave, param2_data, grass_color)
    local c = pr:next(1, 1000)
    
    
    -- Land
    if cave == nil and y > water_level then
        if c <= 20 then
            data[area:index(x, y+1, z)] = grass_tall
            param2_data[area:index(x, y+1, z)] = grass_color
        elseif c < 100 then
            data[area:index(x, y+1, z)] = grass_short
            param2_data[area:index(x, y+1, z)] = grass_color
        end

        if tempv > 0 and not (tempv > 20) then
                
            if c == 100 and y > water_level+3 then
                data[area:index(x, y+1, z)] = sticks

            elseif c == 101 and y > water_level+9 then
                data[area:index(x, y+1, z)] = mushroom
                param2_data[area:index(x, y+1, z)] = 1

            -- Big tree
            elseif y >= water_level+10 and tempv >= 15 and c == 995 then
                place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematics_1042.get_schematic("big_tree_1"), force=false}

            elseif y >= water_level+5 and tempv >= 5 and c == 999 then
                place_list[#place_list+1] = {pos=vector.new(x-11,y-3,z-11), schematic=schematics_1042.get_schematic("big_tree_dark_1"), force=true}
            end

        elseif tempv > 20 then
            if c <= 10 then
                data[area:index(x, y+1, z)] = grass_short
            end

        elseif tempv <= -3 then
            if y >= water_level+3 and c >= 999+(tempv/8) then
                place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematics_1042.get_schematic("big_tree_light_1"), force=true}
            else
                local vi = area:index(x, y+1, z)
                data[vi] = snow
                param2_data[vi] = pr:next(8, 16)
            end

        end

    elseif cave == "bottom" then
        if c <= 5 then
            data[area:index(x, y+1, z)] = flint
            
        elseif c <= 30 then
            data[area:index(x, y+1, z)] = rock

        elseif c <= 45 then
            data[area:index(x, y+1, z)] = iron_nugget

        elseif c <= 60 and y <= decorated_caves then
            data[area:index(x, y+1, z)] = beryl

        elseif c == 100 and y <= treasure_y then
            if pr:next(1, 5) == 1 then
                data[area:index(x, y+1, z)] = chest
            end
            
        end

    elseif cave == "top" then
        if c <= 5 and y <= decorated_caves then
            data[area:index(x, y+1, z)] = beryl_top

        end
    
    else
        if c <= 10 and y == water_level then
            data[area:index(x, y+1, z)] = rock
        end
    end

end


core.register_on_generated(function(vm, minp, maxp, seed)
    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local data = vm:get_data()
    local param2_data = vm:get_param2_data()

    local pr = PseudoRandom(seed)
    local tm = weather.get_temp_map(minp.x, minp.z)
    local place_list = {}

    -- Add for T_ymin just do stone

    if maxp.y >= bedrock_level and minp.y <= T_ymax_Real then
        local noise_m = mapgen_1042.map:get_2d_map({z=0,y=minp.x, x=minp.z})
        local m_pos = {z=minp.x,y=minp.y,x=minp.z}
        local cave_noise_m = mapgen_1042.cave_map:get_3d_map(m_pos)
        local ore_noise_m = mapgen_1042.ore_map:get_3d_map(m_pos)

        local ly = 0
        for y = minp.y, maxp.y do
            ly = ly + 1
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
                    if y == T_ymax_Real then
                        data[vi] = skyrock

                        vi = vi + 1
                        goto skip
                    end
                    if y >= T_ymax then
                        vi = vi + 1
                        goto skip
                    end

                    lx = lx + 1
                    local ny, rv, mountin_top, noise = mapgen_1042.get_y(x, z, noise_m[lx][lz])


                    local tempv = weather.get_temp({x=lx, y=y, z=lz}, tm)


                    -- Place and handel caves
                    if cave_noise_m[lx][ly][lz] > -0.95 or y > caves_max then
                        if y < (ny-1) then
                            if noise < -1.3 then
                                data[vi] = iron_ore
                            else
                                data[vi] = stone
                            end
                            

                        elseif y == (ny-1) then
                            data[vi] = dirt

                        elseif y == ny then
                            local grass_color = math.min(math.floor(((tempv / 30) + 1) * 8 * 16) - 1, 255) -- From weather_api.lua
                            if y > water_level then
                                if mountin_top then
                                    data[vi] = dirt
                                else
                                    data[vi] = turf
                                    param2_data[vi] = grass_color
                                end

                            elseif y < water_level then
                                data[vi] = dirt

                            else
                                data[vi] = sand

                            end

                            if not mountin_top then
                                dec(pr, x, y, z, data, area, place_list, tempv, nil, param2_data, grass_color)
                            end
                        end
                    elseif y <= ny and y<= lava_level then
                        data[vi] = lava
                    else
                        if cave_noise_m[lx][ly-1] and cave_noise_m[lx][ly-1][lz] > -0.95 and y <= ny then
                            dec(pr, x, y-1, z, data, area, place_list, tempv, "bottom", param2_data)
                        elseif cave_noise_m[lx][ly+1] and cave_noise_m[lx][ly+1][lz] > -0.95 and y <= ny then
                            dec(pr, x, y-1, z, data, area, place_list, tempv, "top", param2_data)
                        end
                    end

                    if ((y <= water_level) or (mountin_top and y <= rv)) and y > ny then
                        if y == water_level or (mountin_top and y == rv) then
                            if tempv <= 0 then
                                data[vi] = ice
                            else
                                data[vi] = water
                            end
                        else
                            data[vi] = water
                        end
                    end


                    vi = vi + 1
                    ::skip::
                end
            end
        end

    -- New demension
    elseif maxp.y <= 4096 and maxp.y >= 1024 then
        local noise_m = mapgen_1042.map2:get_2d_map({z=0,y=minp.x, x=minp.z})
        local noise_m_1 = mapgen_1042.map2_1:get_2d_map({z=0,y=minp.x, x=minp.z})
        local ly = 0
        for y = minp.y, maxp.y do
            ly = ly + 1
            local lz = 0
            for z = minp.z, maxp.z do
                lz = lz + 1
                local lx = 0
                for x = minp.x, maxp.x do
                    lx = lx + 1
                    local vi = area:index(x, y, z)

                    local noise = noise_m[lx][lz]
                    local noise_1 = noise_m_1[lx][lz]
                    local y_max = 2048 + (noise - 0.3)^(1/3) * 10

                    --[[if noise_1 > 0.5 and y == math.floor(y_max) then
                            data[area:index(x, y, z)] = ice]]
                    if noise_1 > 0.35 and (y == math.floor(y_max) or (noise - 0.3 <= 0 and y == 2048)) then
                        if noise_1 > 0.5 then
                            data[area:index(x, y, z)] = air
                            data[area:index(x, y-1, z)] = water2
                            data[area:index(x, y-2, z)] = node2

                            for y = y-1,y do
                                local x = x-2
                                for lx = lx-1, lx+1 do
                                    x = x + 1
                                    local z = z-2
                                    for lz = lz-1, lz+1 do
                                        z = z + 1

                                        noise = (noise_m[lx] or {})[lz] or 1
                                        noise_1 = (noise_m_1[lx] or {})[lz] or 1
                                        y_max = 2048 + (noise - 0.3)^(1/3) * 10

                                        if not (noise_1 > 0.5) and not (math.floor(y_max) == 1) then
                                            data[area:index(x, y, z)] = node2
                                        end
                                    end
                                end
                            end

                        else
                            data[area:index(x, y, z)] = node2
                            data[area:index(x, y-1, z)] = node2
                        end

                    elseif noise >= 0.3 then
                        local y_min = 2048 - (noise - 0.3)^(3/5) * 30
                        if y <= y_max and y >= y_min then
                            data[vi] = node2
                        end
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:set_param2_data(param2_data)


    -- #fixme this just skips chunks with overlaps, probably should make my own format and API for this to allow checking for fits
    --[[
        format_voxel_manip_data = {}
        format_voxel_manip_data:fits_in(<format_voxel_manip_data>)
        format_voxel_manip_data:add(<format_voxel_manip_data>)
        etc.
    ]]

    local light_data = vm:get_light_data()
    for _, def in ipairs(place_list) do
        schematics_1042.place_schematic_on_vmanip(def.pos, def.schematic, vm, def.force)
        --if not core.place_schematic_on_vmanip(vm, def.pos, def.schematic, def.rotation, def.replacements, def.force_placement, def.flags) then
        --    vm:set_data(data)
        --    vm:set_light_data(light_data)
        --    vm:set_param2_data(param2_data)
        --end
    end
    
    vm:update_liquids()
end)
