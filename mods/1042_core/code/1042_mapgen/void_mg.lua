local function f(minp, maxp, area, data, _, _, _, _, _)
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
                    data[vi] = nodes._1042_core__black
                end
            end
        end
    end

    return false, false
end

add_mapgen(mapgen_1042.void_ymin, mapgen_1042.void_ymax, f, true, true)