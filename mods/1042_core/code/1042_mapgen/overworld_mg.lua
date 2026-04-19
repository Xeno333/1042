local stone = core.get_content_id("mapgen_stone")
local basalt = core.get_content_id("1042_core:basalt")
local dirt = core.get_content_id("1042_core:dirt")
local sand = core.get_content_id("1042_core:sand")
local turf = core.get_content_id("1042_core:turf")
local water = core.get_content_id("mapgen_water_source")
local snow = core.get_content_id("1042_core:snow")
local lava = core.get_content_id("1042_core:lava_source")
local iron_ore = core.get_content_id("1042_core:iron_ore")
local gold_ore = core.get_content_id("1042_core:gold_ore")

-- Dec
local rock = core.get_content_id("1042_core:rock")
local sticks = core.get_content_id("1042_core:sticks")
local iron_nugget = core.get_content_id("1042_core:iron_nugget")
local gold_nugget = core.get_content_id("1042_core:gold_nugget")

local flint = core.get_content_id("1042_core:flint")
local beryl_top = core.get_content_id("1042_core:beryl_hanging")
local chest = core.get_content_id("1042_core:chest")

local grass_tall = core.get_content_id("1042_core:grass_tall")
local grass_short = core.get_content_id("1042_core:grass_short")
local cave_grass = core.get_content_id("1042_core:cave_grass")
local thin_moss = core.get_content_id("1042_core:thin_moss")
local mushroom = core.get_content_id("1042_core:mushroom")
local digitalis = core.get_content_id("1042_core:digitalis")
local light_bloom = core.get_content_id("1042_core:light_bloom")
local sunflower = core.get_content_id("1042_core:sunflower")
local moss = core.get_content_id("1042_core:moss")



-- trees
local tree_dark = core.get_content_id("1042_core:tree_dark")
local leaves_dark = core.get_content_id("1042_core:leaves_dark")
local tree_light = core.get_content_id("1042_core:tree_light")
local leaves_light = core.get_content_id("1042_core:leaves_light")
local tree = core.get_content_id("1042_core:tree")
local leaves = core.get_content_id("1042_core:leaves")




-- Info

local water_level = mapgen_1042.water_level
local cave_pool_level = mapgen_1042.cave_pool_level
local bedrock_level = mapgen_1042.bedrock_level
local caves_max = mapgen_1042.caves_max
local decorated_caves = mapgen_1042.decorated_caves
local treasure_y = mapgen_1042.water_level - 10


-- Structures

local tower = core.get_content_id("1042_core:tower")



local function dec(pr, x, y, z, data, area, tempv, humidity, cave, param2_data, grass_color, flags)
    local c = pr:next(1, 1000)
    local c2 = pr:next(1, 1000)
    
    -- Land
    if cave == nil and y > water_level then
        local depth = pr:next(1, 2) - 2
        if flags.sulfer_field then
            if c <= 2 then
                local l = pr:next(depth + 2, 3)
                for i = 1, l-1 do
                    data[area:index(x, y+i, z)] = nodes.limestone
                end
                data[area:index(x, y+l, z)] = nodes.geyser_nozzle
                
            elseif c <= 10 then
                data[area:index(x, y+depth+1, z)] = nodes.gusher_spout
            elseif c == 11 and c2 <= 100 then
                grow_tree(vector.new(x, y-2, z), data, area, {tree = nodes.tree_palm, leaves = nodes.leaves_palm, h = 25, r = 1, down_c = 8, down = 5, lc = {min = 3, max = 5}})
            elseif c == 11 then
                data[area:index(x, y+1, z)] = nodes.short_palm
            end
        else
            if c <= 20 then
                data[area:index(x, y+1, z)] = grass_tall
                param2_data[area:index(x, y+1, z)] = grass_color

            elseif c <= 21 and tempv >= 10 and tempv <= 20 and humidity >= 50 then
                data[area:index(x, y+1, z)] = digitalis
            elseif c <= 22 and tempv >= 10 and tempv <= 20 and humidity >= 50 then
                data[area:index(x, y+1, z)] = nodes.clover
            elseif c <= 23 and tempv >= 0 and tempv <= 15 and humidity >= 45 then
                data[area:index(x, y+1, z)] = nodes.thistles
            elseif c <= 25 and tempv >= 10 and humidity >= 75 then
                data[area:index(x, y+1, z)] = light_bloom
            elseif c <= 25 and tempv >= 20 then
                data[area:index(x, y+1, z)] = sunflower

            elseif c < 75 then
                data[area:index(x, y+1, z)] = grass_short
                param2_data[area:index(x, y+1, z)] = grass_color
            end

            if tempv > 0 and not (tempv > 20) and humidity > 45 then
                if c == 102 and c2 <= 100 and tempv >= 5 then
                    if data[area:index(x, y, z)] == turf and data[area:index(x-10, y, z-10)] == turf and data[area:index(x-10, y, z)] == turf and data[area:index(x, y, z-10)] == turf then
                        data[area:index(x-10, y+1, z-10)] = tower
                    end

                elseif c == 100 and y > water_level+3 then
                    data[area:index(x, y+1, z)] = sticks

                elseif c == 101 and y > water_level+9 then
                    data[area:index(x, y+1, z)] = mushroom
                    param2_data[area:index(x, y+1, z)] = 1

                -- Big tree
                elseif y >= water_level+10 and tempv >= 15 and c == 995 then
                    grow_tree(vector.new(x, y-2, z), data, area, {tree = tree, leaves = leaves, h = 10})

                elseif y >= water_level+5 and tempv >= 5 and c == 999 then
                    grow_tree(vector.new(x, y-2, z), data, area, {tree = tree_dark, leaves = leaves_dark, h = 20, r = 2})
                end

            elseif tempv > 10 then
                if c <= 20 then
                    data[area:index(x, y+1, z)] = grass_short
                    param2_data[area:index(x, y+1, z)] = grass_color
                end

            elseif tempv <= -3 then
                if y >= water_level+3 and c >= 999+(tempv/8) then
                    grow_tree(vector.new(x, y-2, z), data, area, {tree = tree_light, leaves = leaves_light, h = 16, down_c = 8, down = 5})
                else
                    local vi = area:index(x, y+1, z)
                    data[vi] = snow
                    param2_data[vi] = pr:next(8, 16)
                end
            end
        end

    elseif cave == "bottom" then
        if c <= 5 then
            data[area:index(x, y, z)] = flint

        elseif c <= 20 and (tempv >= 10 and tempv <= 20) then
            local v = area:index(x, y, z)
            data[v] = cave_grass
            param2_data[v] = 16 + 32 + 4
            
        elseif c <= 30 then
            data[area:index(x, y, z)] = rock

        elseif c == 45 then
            data[area:index(x, y, z)] = gold_nugget

        elseif c <= 46 then
            data[area:index(x, y, z)] = iron_nugget

        elseif c <= 60 and y <= decorated_caves then
            data[area:index(x, y, z)] = gems[pr:next(1, #gems)]

        elseif c == 100 and y <= treasure_y then
            if pr:next(1, 5) == 1 then
                data[area:index(x, y, z)] = chest
            end

        elseif c <= 200 and (tempv >= 10) then
            local v = area:index(x, y, z)
            data[v] = thin_moss
            param2_data[v] = 1

        end

    elseif cave == "top" then
        if c <= 100 and (tempv >= 10) then
            local v = area:index(x, y, z)
            data[v] = thin_moss
            param2_data[v] = 6

        elseif c <= 105 and y <= decorated_caves then
            data[area:index(x, y, z)] = beryl_top
        end
    
    else
        if c <= 10 and y == water_level then
            data[area:index(x, y+1, z)] = rock
        end
    end

end


local function f(minp, maxp, area, data, param2_data, pr, struct_pr, structs, tm, hm)
    local m_pos = {z=minp.x,y=minp.y,x=minp.z}

    local noise_m = mapgen_1042.map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local rock_noise_m = mapgen_1042.rock_map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local plateau_noise_m = mapgen_1042.plateau_map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local flatness_noise_m = mapgen_1042.flatness_map:get_2d_map({z=0,y=minp.x, x=minp.z})    
    
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
        local cave_v = 0.2
        if y < 0 then
            cave_v = math.abs((y + caves_max) / cave_pool_level)
        end

        local lz = 0
        for z = minp.z, maxp.z do
            lz = lz + 1
            local vi = area:index(minp.x, y, z)
            local lx = 0

            for x = minp.x, maxp.x do
                lx = lx + 1

                local flags = {}

                local tempv = weather.get_temp({x=lx, y=y, z=lz}, tm)
                local humidity = weather.get_humidity({x=lx, y=y, z=lz}, hm)
                local ny, rv, mountin_top, noise = mapgen_1042.get_y(x, z, 
                    ((noise_m[lx][lz] + (math.max(math.min(1, rock_noise_m[lx][lz]) - 0.7, 0) / 4) + (math.max(math.min(1, plateau_noise_m[lx][lz]) - 0.9, 0)))
                    * (flatness_noise_m[lx][lz] / 1.5))
                ,tempv)

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
                        data[vi] = nodes.bedrock
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
                        data[vi] = nodes.bedrock
                    else
                        local d = underworld_density_m[lx][ly][lz]
                        if d < 0.1 and d > -0.1 then
                            d = 0.1 * (d / math.abs(d))
                        end


                        -- Mapgen for underworld
                        if y == mapgen_1042.underworld_ymin then
                            data[vi] = nodes.bedrock

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
                if y == mapgen_1042.d_ymax then
                    data[vi] = nodes.skyrock

                    vi = vi + 1
                    goto skip

                elseif y > mapgen_1042.d_ymax then
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
                        local grass_color = (math.floor((((tempv + 30) / 60)) * 15) * 16) + math.floor((humidity / 100) * 15) -- From weather_api.lua
                        if y > water_level then
                            if mountin_top then
                                data[vi] = dirt
                            elseif tempv >= 20 and humidity >= 60 then
                                flags.sulfer_field = true
                                data[vi] = sand

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
                            dec(pr, x, y, z, data, area, tempv, humidity, nil, param2_data, grass_color, flags)
                        end
                    end
                elseif y <= ny and y<= cave_pool_level then
                    data[vi] = water
                else
                    if cave_noise_m[lx][ly-1] and cave_noise_m[lx][ly-1][lz] > cave_v and y <= ny then
                        if tempv >= 10 then
                            data[area:index(x, y-1, z)] = moss
                        end
                        dec(pr, x, y, z, data, area, tempv, humidity, "bottom", param2_data, nil, flags)
                    elseif cave_noise_m[lx][ly+1] and cave_noise_m[lx][ly+1][lz] > cave_v and y <= ny then
                        dec(pr, x, y, z, data, area, tempv, humidity, "top", param2_data, nil, flags)
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

    return true, true
end


add_mapgen(mapgen_1042.underworld_ymin, mapgen_1042.d_ymax, f)