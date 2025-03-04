-- mapgen.lua

-- Todo Make modable using normal mapgen definitions for biomes and schematics #fixme

dofile(core.get_modpath("1042_mapgen") .. "/mapgen_api.lua")

-- Weather api
dofile(core.get_modpath("1042_weather") .. "/weather_api.lua")



--local path = core.get_modpath("1042_mapgen")

--dofile(path.."/api.lua")
--dofile(path.."/mapgen.lua")


-- Settings
local T_ymax = mapgen_1042.ymax
local T_ymin = mapgen_1042.ymin
local water_level = mapgen_1042.water_level
local lava_level = mapgen_1042.lava_level
local bedrock_level = mapgen_1042.bedrock_level
local caves_max = mapgen_1042.caves_max
local decorated_caves = mapgen_1042.decorated_caves
local treasure_y = mapgen_1042.water_level - 10
local continent_radius = mapgen_1042.continent_radius





-- Mapgen


local stone = core.get_content_id("mapgen_stone")
local dirt = core.get_content_id("1042_nodes:dirt")
local sand = core.get_content_id("1042_nodes:sand")
local turf = core.get_content_id("1042_nodes:turf")
local snow = core.get_content_id("1042_nodes:snow")
local bedrock = core.get_content_id("1042_nodes:bedrock")
local lava = core.get_content_id("1042_nodes:lava_source")
local iron_ore = core.get_content_id("1042_nodes:iron_ore")

local water = core.get_content_id("mapgen_water_source")
local ice = core.get_content_id("1042_nodes:ice")

local rock = core.get_content_id("1042_nodes:rock")
local sticks = core.get_content_id("1042_nodes:sticks")
local iron_nugget = core.get_content_id("1042_nodes:iron_nugget")
local beryl = core.get_content_id("1042_nodes:beryl")
local flint = core.get_content_id("1042_nodes:flint")
local beryl_top = core.get_content_id("1042_nodes:beryl_hanging")

local grass_tall = core.get_content_id("1042_nodes:grass_tall")
local grass_short = core.get_content_id("1042_nodes:grass_short")
local mushroom = core.get_content_id("1042_nodes:mushroom")

local chest = core.get_content_id("1042_nodes:chest")




local schematic_path = core.get_modpath("1042_mapgen") .. "/schematics/"











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
                place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematic_path .. "big_tree_1.mts", rotation="random", replacements=nil, force_placement=true, flags=nil}

            elseif y >= water_level+5 and tempv >= 5 and c == 999 then
                place_list[#place_list+1] = {pos=vector.new(x-11,y-3,z-11), schematic=schematic_path .. "big_tree_dark_1.mts", rotation="random", replacements=nil, force_placement=true, flags=nil}

            end

        elseif tempv > 20 then
            if c <= 10 then
                data[area:index(x, y+1, z)] = grass_short
            end

        else
            if tempv <= -3 then
                local vi = area:index(x, y+1, z)
                data[vi] = snow
                param2_data[vi] = pr:next(8, 16)
            end

            if y >= water_level+3 and c >= 999+(tempv/8) then
                place_list[#place_list+1] = {pos=vector.new(x-7,y-1,z-7), schematic=schematic_path .. "big_tree_light_1.mts", rotation="random", replacements=nil, force_placement=true, flags=nil}

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

        elseif c == 11 and y == water_level and pr:next(1, 100) == 1 then
            data[area:index(x, y+1, z)] = water
        end
    end

end


core.register_on_generated(function(vm, minp, maxp, seed)
    local emin, emax = vm:get_emerged_area()
    local area = VoxelArea(emin, emax)
    local data = vm:get_data()
    local param2_data = vm:get_param2_data()

    local pr = PseudoRandom(seed)

    local noise_m = mapgen_1042.map:get_2d_map({z=0,y=minp.x, x=minp.z})
    local m_pos = {z=minp.x,y=minp.y,x=minp.z}
    local cave_noise_m = mapgen_1042.cave_map:get_3d_map(m_pos)
    local ore_noise_m = mapgen_1042.ore_map:get_3d_map(m_pos)

    local tm = weather.get_temp_map(minp.x, minp.z)

    local place_list = {}

    -- Add for T_ymin just do stone

    if maxp.y >= bedrock_level then
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

                    lx = lx + 1
                    -- Get properties of land
                    local noise = noise_m[lx][lz]
                    local ny, rv
                    local mountin_top = false

                    -- Distance from (0,y,0)
                    local r = math.sqrt(x^2+z^2)
                    if noise <= 0.9 or r > continent_radius then -- make sure always runs if beyond cont range
                        if noise > -0.5 then
                            -- Normal gen
                            ny = (noise * math.abs(noise)) * T_ymax
                        else
                            -- Deep sea Gen
                            ny = (noise) * math.abs(T_ymin) + (0.75*T_ymax) 
                        end

                        -- Border
                        if r > continent_radius then
                            local offset = math.max(0, math.min(T_ymax, (1/3)*(r-continent_radius)))
                            ny = ny - offset
                        end
                    else
                        -- Mountin hole
                        ny = (0.9 * math.abs(0.9)) * T_ymax - (noise * math.abs(noise)) * T_ymax/8 + 4
                        rv = math.floor((0.9 * math.abs(0.9)) * T_ymax - 3)
                        mountin_top = true
                    end
                    
                    ny = math.floor(ny)


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
                            local grass_color = math.floor(((tempv / 30) + 1) * 8 * 16) - 1
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
        if not core.place_schematic_on_vmanip(vm, def.pos, def.schematic, def.rotation, def.replacements, def.force_placement, def.flags) then
            vm:set_data(data)
            vm:set_light_data(light_data)
            vm:set_param2_data(param2_data)
        end
    end
    
    vm:update_liquids()
end)
