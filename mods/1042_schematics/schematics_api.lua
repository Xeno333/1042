schematics_1042 = {
    registered_schematics = {}
}


local schematic_ignore_node = core.get_content_id("1042_schematics:schematic_ignore")
local air_node = core.get_content_id("air")
local ignore_node = core.get_content_id("ignore")


function schematics_1042.new_schematic(x, y, z)
    return {
        replacements = {},
        data = {},
        size = vector.new(x or 0, y or 0, z or 0),
        center = false
    }
end



-- Register a global schamtic
function schematics_1042.register_schematic(name, schem)
    -- Check if it exists and return fals if it does
    if schematics_1042.registered_schematics[name] then return false end

    schematics_1042.registered_schematics[name] = schem
    return true
end

-- Get a global schamtic
function schematics_1042.get_schematic(name, schem)
    -- Check if it exists and return false if it doesn't
    if not schematics_1042.registered_schematics[name] then return nil end

    return schematics_1042.registered_schematics[name]
end





function schematics_1042.is_schamatic(schem)
    if schem.replacements ~= nil and type(schem.replacements) ~= "table" then return false end
    if type(schem.data) ~= "table" then return false end
    if type(schem.size) ~= "table" then return false end
    if type(schem.center) ~= "boolean" then return false end
    if not next(schem.data) then return false end

    return true
end









-- WIP

-- Load a schamtic from a file
function schematics_1042.load_schematic(path)
    local file = io.open(path..".1042_schem", "r")
    if not file then return nil end

    local schem = core.parse_json(file:read("*all") or "{}") or {}
    file:close()

    if not schematics_1042.is_schamatic(schem) then return nil end

    for i1, l1 in pairs(schem.data) do
        for i2, l2 in pairs(l1) do
            for i3, name in pairs(l2) do
                schem.data[i1][i2][i3] = core.get_content_id(name)
            end
        end
    end

    return schem
end


function schematics_1042.place_schematic(posin, schematic, force)
    local size = schematic.size
    local pos = vector.new(math.floor(posin.x), math.floor(posin.y), math.floor(posin.z))
    local pos_min
    local pos_max

    if schematic.center == true then
        pos_min = vector.new(pos.x-math.floor(size.x/2), pos.y-math.floor(size.y/2), pos.z-math.floor(size.z/2))
        pos_max = vector.new(pos.x+math.floor(size.x/2), pos.y+math.floor(size.y/2), pos.z+math.floor(size.z/2))
    else
        pos_min = pos
        pos_max = vector.new(pos.x+math.floor(size.x)-1, pos.y+math.floor(size.y)-1, pos.z+math.floor(size.z)-1)
    end

    core.emerge_area(pos_min, pos_max, function()
        local vm = VoxelManip(pos_min, pos_max)
        local emin, emax = vm:read_from_map(pos_min, pos_max)
        local data = vm:get_data()
        local area = VoxelArea(emin, emax)

        local ly = 0
        for y=pos_min.y,pos_max.y do
            ly = ly + 1

            local lz = 0
            for z=pos_min.z,pos_max.z do
                lz = lz + 1

                local lx = 0
                for x=pos_min.x,pos_max.x do
                    lx = lx + 1
                    
                    local vi = area:index(x,y,z)
                    local current_node = data[vi]

                    if current_node == ignore_node or current_node == air_node or force then
                        local node = schematic.data[ly][lz][lx]
                        if node ~= schematic_ignore_node then
                            data[vi] = node
                        end
                    end
                end
            end
        end

        vm:set_data(data)
        vm:write_to_map()

    end)

    return "Qeued..."
end


-- Save schematic to file
function schematics_1042.save_schematic(pos1, pos2, path, ignore_air)
    core.emerge_area(pos1, pos2, function()
        local vm = VoxelManip(pos1, pos2)
        local emin, emax = vm:read_from_map(pos1, pos2)
        local data = vm:get_data()
        local area = VoxelArea(emin, emax)

        local schematic = schematics_1042.new_schematic(math.abs(pos1.x - pos2.x)+1, math.abs(pos1.y - pos2.y)+1, math.abs(pos1.z - pos2.z)+1)

        local xrange = {min = pos1.x, max = pos2.x}
        if pos1.x > pos2.x then xrange = {max = pos1.x, min = pos2.x} end
        local yrange = {min = pos1.y, max = pos2.y}
        if pos1.y > pos2.y then yrange = {max = pos1.y, min = pos2.y} end
        local zrange = {min = pos1.z, max = pos2.z}
        if pos1.z > pos2.z then zrange = {max = pos1.z, min = pos2.z} end

        local ly = 0
        for y=yrange.min,yrange.max do
            ly = ly + 1
            schematic.data[ly] = {}

            local lz = 0
            for z=zrange.min,zrange.max do
                lz = lz + 1
                schematic.data[ly][lz] = {}

                local lx = 0
                for x=xrange.min,xrange.max do
                    lx = lx + 1

                    local node = data[area:index(x,y,z)]
                    if ignore_air and node == air_node then
                        node = schematic_ignore_node
                    end
                    schematic.data[ly][lz][lx] = core.get_name_from_content_id(node)
                end
            end
        end

        core.safe_file_write(path..".1042_schem", core.write_json(schematic, true))
    end)

    return "Queued..."
end



function schematics_1042.place_schematic_on_vmanip(posin, schematic, vm, force)
    local size = schematic.size
    local pos = vector.new(math.floor(posin.x), math.floor(posin.y), math.floor(posin.z))
    local pos_min
    local pos_max

    if schematic.center == true then
        pos_min = vector.new(pos.x-math.floor(size.x/2), pos.y-math.floor(size.y/2), pos.z-math.floor(size.z/2))
        pos_max = vector.new(pos.x+math.floor(size.x/2), pos.y+math.floor(size.y/2), pos.z+math.floor(size.z/2))
    else
        pos_min = pos
        pos_max = vector.new(pos.x+math.floor(size.x)-1, pos.y+math.floor(size.y)-1, pos.z+math.floor(size.z)-1)
    end

    local emin, emax = vm:get_emerged_area()
    -- if can place in area
    if (emin.x > pos_min.x or emin.y > pos_min.y or emin.z > pos_min.z) or (emax.x < pos_max.x or emax.y < pos_max.y or emax.z < pos_max.z) then return false end
    local data = vm:get_data()
    local area = VoxelArea(emin, emax)

    local ly = 0
    for y=pos_min.y,pos_max.y do
        ly = ly + 1

        local lz = 0
        for z=pos_min.z,pos_max.z do
            lz = lz + 1

            local lx = 0
            for x=pos_min.x,pos_max.x do
                lx = lx + 1
                
                local vi = area:index(x,y,z)
                local current_node = data[vi]

                if current_node == ignore_node or current_node == air_node or force then
                    local node = schematic.data[ly][lz][lx]
                    if node ~= schematic_ignore_node then
                        data[vi] = node
                    end
                end
            end
        end
    end

    vm:set_data(data)

    return true
end