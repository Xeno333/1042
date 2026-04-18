
local function f(minp, maxp, area, data, param2_data, pr, struct_pr, structs, tm)
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
                        data[area:index(x, y, z)] = gems[pr:next(1, #gems)]
                    end
                end
            end
        end
    end
    return false, true
end


add_mapgen(core_1042.shared_lib.consts.sky_world_y_levels.min, core_1042.shared_lib.consts.sky_world_y_levels.max, f)