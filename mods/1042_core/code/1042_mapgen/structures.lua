structures_1042 = {}


local stone = core.get_content_id("mapgen_stone")
local dirt = core.get_content_id("1042_core:dirt")
local air = core.get_content_id("air")
local glass = core.get_content_id("1042_core:glass")
local chest = core.get_content_id("1042_core:chest")

local woods = {
    core.get_content_id("1042_core:tree_dark"),
    core.get_content_id("1042_core:tree_light")
}


local doors = {
    {node = air, y = {1, 2}, x = {4, 4}, z = {0, 0}},
    {node = air, y = {1, 2}, x = {-4, -4}, z = {0, 0}},
    {node = air, y = {1, 2}, x = {0, 0}, z = {-4, -4}},
    {node = air, y = {1, 2}, x = {0, 0}, z = {4, 4}},
}
local windows = {
}
for y_1 = 2, 3 do
    for y_2 = 2, 3 do
        for r = 0, 2 do
            local y = {y_1, y_2}
            
            windows[#windows+1] = {node = glass, y = y, x = {-r, r}, z = {4, 4}}
            windows[#windows+1] = {node = glass, y = y, x = {-r, r}, z = {-4, -4}}
            windows[#windows+1] = {node = glass, y = y, x = {-4, -4}, z = {-r, r}}
            windows[#windows+1] = {node = glass, y = y, x = {4, 4}, z = {-r, r}}
        end
    end
end

function structures_1042.place_village(buildings, minp, maxp, data, area, struct_pr)
    local num = #buildings

    if num > 0 then
        local count = num / 500
        local places = {buildings[#buildings]}
        buildings[#buildings] = nil

        local size = 16
        local t = {}
        for i = 1, #buildings do
            local p = struct_pr:next(1, #buildings)
            t[i] = buildings[p]
            table.remove(buildings, p)
        end

        for _, v in ipairs(t) do
            local wood = woods[struct_pr:next(1, #woods)]

            local valid = true
            if (v.x <= minp.x + size or v.x >= maxp.x - size) or (v.z <= minp.z + size or v.z >= maxp.z - size) then
                valid = false
            else
                for _, n in pairs(places) do
                    if (n.x + size >= v.x and n.x <= v.x + size) and (n.z + size >= v.z and n.z <= v.z + size) then
                        valid = false
                    end
                end
            end

            if valid then
                places[#places+1] = v
                local ns = {
                    {node = stone, y = {-2, 2}},
                    {node = air, y = {1, 6}},

                    {node = wood,y = {1, 5}, x = {4, 4}, z = {-4, 4}},
                    {node = wood, y = {1, 5}, x = {-4, -4}, z = {-4, 4}},
                    {node = wood, y = {1, 5}, x = {-4, 4}, z = {-4, -4}},
                    {node = wood, y = {1, 5}, x = {-4, 4}, z = {4, 4}},
                }

                if struct_pr:next(1, 2) == 1 then
                    for i = 1, 3 do
                        ns[#ns+1] = {node = wood, y = {5 + i, 5 + i}, x = {-(5 - i), 5 - i}, z = {-4, 4}}
                    end
                    for i = 2, 3 do
                        ns[#ns+1] = {node = air, y = {4 + i, 4 + i}, x = {-(5 - i), 5 - i}, z = {-3, 3}}
                    end
                else
                    for i = 1, 3 do
                        ns[#ns+1] = {node = wood, y = {5 + i, 5 + i}, x = {-4, 4}, z = {-(5 - i), 5 - i}}
                    end
                    for i = 2, 3 do
                        ns[#ns+1] = {node = air, y = {4 + i, 4 + i}, x = {-3, 3}, z = {-(5 - i), 5 - i}}
                    end
                end

                for i = 1, struct_pr:next(2, 6) do
                    ns[#ns+1] = windows[struct_pr:next(1, #windows)]
                end
                ns[#ns+1] = doors[struct_pr:next(1, #doors)]

                local function place(l)
                    local n = l.node
                    l.x = l.x or {-6, 6}
                    l.z = l.z or {-6, 6}
                    for y = v.y+l.y[1], v.y+l.y[2] do
                        for x = v.x+l.x[1], v.x+l.x[2] do
                            for z = v.z+l.z[1], v.z+l.z[2] do
                                data[area:index(x, y, z)] = n
                            end
                        end
                    end
                end

                for _, l in ipairs(ns) do
                    place(l)
                end
                if struct_pr:next(1, 4) then
                    place({node = chest, y = {1, 1}, x = {3, 3}, z = {3, 3}})
                end

                if #places > count then
                    break
                end
            end
        end
    end
end