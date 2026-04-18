

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
