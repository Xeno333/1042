-- mapgen.lua

-- Todo Make modable using normal mapgen definitions for biomes and schematics #fixme

dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/mapgen_api.lua")
dofile(core_1042.get_core_mod_path("1042_mapgen") .. "/structures.lua")

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
local white = core.get_content_id("1042_core:white")
local black = core.get_content_id("1042_core:black")


local stone = core.get_content_id("mapgen_stone")
local basalt = core.get_content_id("1042_core:basalt")

local dirt = core.get_content_id("1042_core:dirt")
local sand = core.get_content_id("1042_core:sand")
local turf = core.get_content_id("1042_core:turf")
local ice = core.get_content_id("1042_core:ice")
local water = core.get_content_id("mapgen_water_source")

local snow = core.get_content_id("1042_core:snow")

local lava = core.get_content_id("1042_core:lava_source")
local iron_ore = core.get_content_id("1042_core:iron_ore")
local gold_ore = core.get_content_id("1042_core:gold_ore")

-- Dec
local rock = core.get_content_id("1042_core:rock")
local sticks = core.get_content_id("1042_core:sticks")
local iron_nugget = core.get_content_id("1042_core:iron_nugget")
local beryl = core.get_content_id("1042_core:beryl")
local flint = core.get_content_id("1042_core:flint")
local beryl_top = core.get_content_id("1042_core:beryl_hanging")
local chest = core.get_content_id("1042_core:chest")

local grass_tall = core.get_content_id("1042_core:grass_tall")
local grass_short = core.get_content_id("1042_core:grass_short")
local mushroom = core.get_content_id("1042_core:mushroom")
local digitalis = core.get_content_id("1042_core:digitalis")
local light_bloom = core.get_content_id("1042_core:light_bloom")
local sunflower = core.get_content_id("1042_core:sunflower")

local air = core.get_content_id("air")


-- Dimension

local node2 = core.get_content_id("1042_core:node2")
local water2 = core.get_content_id("1042_core:water_source2")




local tree_dark = core.get_content_id("1042_core:tree_dark")
local leaves_dark = core.get_content_id("1042_core:leaves_dark")
local tree_light = core.get_content_id("1042_core:tree_light")
local leaves_light = core.get_content_id("1042_core:leaves_light")
local tree = core.get_content_id("1042_core:tree")
local leaves = core.get_content_id("1042_core:leaves")


function grow_tree(pos, data, area, def)
    local pr = PseudoRandom(pos.x + pos.y + pos.z)
    local h = def.h
    local used = {}

    for i = 1, h do
        local l1 = pr:next(1, 3) - 2
        local l2 = pr:next(1, 3) - 2
        pos = pos + vector.new(l1, 1, l2)
        for l = 0, pr:next(2, 4) do
            for x = -1, 1 do
                for y = -1, 1 do
                    local v = vector.new(x, l, y) + pos
                    data[area:index(v.x, v.y, v.z)] = def.tree
                    used[v] = true
                end
            end
        end
    end
    for i = 1, h/2 do
        local l1 = pr:next(1, 3) - 2
        local l2 = pr:next(1, 3) - 2
        pos = pos + vector.new(l1, 1, l2)
        for l = 0, pr:next(2, 4) do
            for x = -pr:next(1, 2), pr:next(1, 2) do
                for y = -pr:next(1, 2), pr:next(1, 2) do
                    local v = vector.new(x, l, y) + pos
                    if not used[v] then
                        data[area:index(v.x, v.y, v.z)] = def.leaves
                    end
                end
            end
        end
    end

    local c = pos

    for n = 1, pr:next(1, 4) do
        pos = c
        for i = 1, pr:next(4, def.down_c or 6) do
            local l1 = pr:next(1, 7) - 4
            local l2 = pr:next(1, 7) - 4
            pos = pos + vector.new(l1, -pr:next(1, def.down or 2), l2)
            for l = 0, pr:next(2, 4) do
                for x = -pr:next(1, 3), pr:next(1, 3) do
                    for y = -pr:next(1, 3), pr:next(1, 3) do
                        local v = vector.new(x, l, y) + pos
                        if not used[v] then
                            data[area:index(v.x, v.y, v.z)] = def.leaves
                        end
                    end
                end
            end
        end
    end
end



local function dec(pr, x, y, z, data, area, place_list, tempv, cave, param2_data, grass_color)
    local c = pr:next(1, 1000)
    
    
    -- Land
    if cave == nil and y > water_level then
        if c <= 20 then
            data[area:index(x, y+1, z)] = grass_tall
            param2_data[area:index(x, y+1, z)] = grass_color
        elseif c == 21 and tempv >= 10 and tempv <= 20 then
            data[area:index(x, y+1, z)] = digitalis
        elseif c <= 25 and tempv >= 5 and tempv <= 15 and y >= water_level+5 then -- be with dark trees
            data[area:index(x, y+1, z)] = light_bloom
        elseif c <= 25 and tempv >= 20 then
            data[area:index(x, y+1, z)] = sunflower
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
                --place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematics_1042.get_schematic("big_tree_1"), force=false}
                grow_tree(vector.new(x, y-2, z), data, area, {tree = tree, leaves = leaves, h = 10})

            elseif y >= water_level+5 and tempv >= 5 and c == 999 then
                --place_list[#place_list+1] = {pos=vector.new(x-11,y-3,z-11), schematic=schematics_1042.get_schematic("big_tree_dark_1"), force=true}
                grow_tree(vector.new(x, y-2, z), data, area, {tree = tree_dark, leaves = leaves_dark, h = 12})
            end

        elseif tempv > 20 then
            if c <= 10 then
                data[area:index(x, y+1, z)] = grass_short
            end

        elseif tempv <= -3 then
            if y >= water_level+3 and c >= 999+(tempv/8) then
                --place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematics_1042.get_schematic("big_tree_light_1"), force=true}
                grow_tree(vector.new(x, y-2, z), data, area, {tree = tree_light, leaves = leaves_light, h = 16, down_c = 8, down = 5})
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

    local pr = PseudoRandom(seed + minp.x + minp.y + minp.z)
    local struct_pr = PseudoRandom(seed + 13572126 + minp.x + minp.y + minp.z)
    local structs = {}

    local tm = weather.get_temp_map(minp.x, minp.z)
    local place_list = {}

    -- Both overworld and underworld
    if maxp.y >= mapgen_1042.void_ymin and minp.y <= mapgen_1042.void_ymax then
        local ly = 0
        for y = minp.y, maxp.y do
            ly = ly + 1
            local lz = 0
            for z = minp.z, maxp.z do
                lz = lz + 1
                local lx = 0
                for x = minp.x, maxp.x do
                    lx = lx + 1

                    if x % 25 == 0 or z % 25 == 0 or y % 25 == 0 or y == mapgen_1042.void_ymin then
                        local vi = area:index(x, y, z)
                        data[vi] = black
                    end
                end
            end
        end

    elseif maxp.y >= mapgen_1042.underworld_ymin and minp.y <= T_ymax_Real then
        local m_pos = {z=minp.x,y=minp.y,x=minp.z}

        local noise_m = mapgen_1042.map:get_2d_map({z=0,y=minp.x, x=minp.z})
        local cave_noise_m = mapgen_1042.cave_map:get_3d_map(m_pos)
        local ore_noise_m = mapgen_1042.ore_map:get_3d_map(m_pos)
        local gold_ore_noise_m = mapgen_1042.ore_map_gold:get_3d_map(m_pos)
        local underworld_noise_m = mapgen_1042.underworld:get_3d_map(m_pos)
        local underworld_density_m = mapgen_1042.underworld_density:get_3d_map(m_pos)

        -- Structures
        local village = false
        if struct_pr:next(1, 10) == 1 then
            village = true
            --return
        end

        local buildings = {}
        local special = nil
        
        local y_avr = 0
        local y_avr_c = 0

        local ly = 0
        for y = minp.y, maxp.y do
            ly = ly + 1
            local cave_v = math.abs((y + caves_max) / lava_level)

            local lz = 0
            for z = minp.z, maxp.z do
                lz = lz + 1
                local vi = area:index(minp.x, y, z)
                local lx = 0

                for x = minp.x, maxp.x do
                    lx = lx + 1

                    local tempv = weather.get_temp({x=lx, y=y, z=lz}, tm)
                    local ny, rv, mountin_top, noise = mapgen_1042.get_y(x, z, noise_m[lx][lz], tempv)

                    if x == mapgen_1042.portal_room.x and z == mapgen_1042.portal_room.z and y == mapgen_1042.portal_room.y then
                        structs[#structs+1] = function(d)
                            structures_1042.place_portal(minp, maxp, d, area, struct_pr, vector.new(x, y, z))
                        end

                    elseif y >= bedrock_level and mapgen_1042.underworld_entrences[x .. " " .. z] ~= nil then
                        if special ~= {} then
                            special = {}
                            for j = -1, 1 do
                                special[x + j] = {}
                                for i = -1, 1 do
                                    special[x + j][z + i] = true
                                end
                            end
                        end
                        vi = vi + 1
                        goto skip
                    end
                    if special and (special[x] or {})[z] and y >= bedrock_level - 4 then
                        if pr:next(0, (math.abs((ny - y) / 32) or 5)) == 0 then
                            data[vi] = bedrock
                        else
                            if pr:next(1, 10) == 1 then
                                data[vi] = gold_ore
                            else
                                data[vi] = basalt
                            end
                        end
                        vi = vi + 1
                        goto skip
                    end

                    if y <= bedrock_level then
                        if y == bedrock_level then
                            data[vi] = bedrock
                        else
                            local d = underworld_density_m[lx][ly][lz]
                            if d < 0.1 and d > -0.1 then
                                d = 0.1 * (d / math.abs(d))
                            end


                            -- Mapgen for underworld
                            if y == mapgen_1042.underworld_ymin then
                                data[vi] = bedrock

                            elseif underworld_noise_m[lx][ly][lz] <= d then
                                if pr:next(1, 1000) == 1 then
                                    data[vi] = lava
                                else
                                    data[vi] = basalt
                                end
                            elseif y <= mapgen_1042.underworld_lava_sea then
                                data[vi] = lava
                            end
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

                    -- Place and handel caves
                    if cave_noise_m[lx][ly][lz] > cave_v or y > caves_max then
                        if y < (ny-1) then
                            if ore_noise_m[lx][ly][lz] < -1.3 then
                                data[vi] = iron_ore
                            elseif gold_ore_noise_m[lx][ly][lz] < -1.6 then
                                data[vi] = gold_ore
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

                                    y_avr = y_avr + y
                                    y_avr_c = y_avr_c + 1

                                    if village then
                                        buildings[#buildings+1] = {x = x, y = y, z = z, vi = vi}
                                    end
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
                        if cave_noise_m[lx][ly-1] and cave_noise_m[lx][ly-1][lz] > cave_v and y <= ny then
                            dec(pr, x, y-1, z, data, area, place_list, tempv, "bottom", param2_data)
                        elseif cave_noise_m[lx][ly+1] and cave_noise_m[lx][ly+1][lz] > cave_v and y <= ny then
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

        if y_avr_c > 0 then
            y_avr = y_avr / y_avr_c
        else
            y_avr = 0
        end

        -- Village code
        if village and y_avr > 2 and y_avr < 20 then
            structs[#structs+1] = function(d)
                structures_1042.place_village(buildings, minp, maxp, d, area, struct_pr)
            end
        end


    -- New demension
    elseif maxp.y <= core_1042.shared_lib.consts.sky_world_y_levels.max and maxp.y >= core_1042.shared_lib.consts.sky_world_y_levels.min then
        local noise_m = mapgen_1042.map2:get_2d_map({z=0,y=minp.x, x=minp.z})
        local noise_m_1 = mapgen_1042.map2_1:get_2d_map({z=0,y=minp.x, x=minp.z})
        local complex_lands = mapgen_1042.complex_lands:get_3d_map({z=minp.x,y=minp.y,x=minp.z})

        local main_y = core_1042.shared_lib.consts.sky_world_y_levels.main_level

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
                    local y_max = main_y + (noise - 0.3)^(1/3) * 10

                    if noise_1 > 0.5 and y == math.floor(y_max) then
                        data[area:index(x, y, z)] = ice
                    elseif noise_1 > 0.35 and (y == math.floor(y_max) or (noise - 0.3 <= 0 and y == main_y)) then
                        if noise_1 > 0.5 then
                            data[vi] = air
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
                                        y_max = main_y + (noise - 0.3)^(1/3) * 10

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

                    elseif noise >= 0.3 and y <= y_max and y >= main_y - (noise - 0.3)^(3/5) * 30 then
                        data[vi] = node2

                    elseif complex_lands[lx][ly][lz] >= 0.8 and complex_lands[lx][ly][lz] <= 0.9 then
                        if complex_lands[lx][ly][lz] <= 0.85 then
                            data[vi] = ice
                        else
                            data[vi] = node2
                        end

                    elseif y == math.floor(y_max)+1 and noise_1 <= 0.5 then
                        if pr:next(1, 200) == 1 then
                            data[area:index(x, y, z)] = beryl
                        end
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:set_param2_data(param2_data)


    -- (OLD) #fixme this just skips chunks with overlaps, probably should make my own format and API for this to allow checking for fits
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

    -- Structs
    if #data > 0 then
        data = vm:get_data()

        for _, func in pairs(structs) do
            func(data)
        end

        vm:set_data(data)
    end
    
    vm:update_liquids()
end)
