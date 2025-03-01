schematics_1042 = {
    registered_schematics = {}
}


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
    if not schematics_1042.registered_schematics[name] then return false, nil end

    return true, schematics_1042.registered_schematics[name]
end





function schematics_1042.is_schamatic(schem)
    if schem.replacements ~= nil and type(schem.replacements) ~= "table" then return false end
    if type(schem.data) ~= "table" then return false end
    if type(schem.size) ~= "table" then return false end
    if type(schem.center) ~= "boolean" then return false end

    return true
end









-- WIP

-- Load a schamtic from a file
function schematics_1042.load_schematic(path)
    local file = io.open(path, "r")
    if not file then return false, nil end

    local schem = core.parse_json(file:read("*all") or "{}") or {}
    file:close()

    if not schematics_1042.is_schamatic(schem) then return false, nil end

    for i1, l1 in pairs(schem.data) do
        for i2, l2 in pairs(l1) do
            for i3, name in pairs(l2) do
                schem.data[i1][i2][i3] = core.get_content_id(name)
            end
        end
    end

    return true, schem
end


function schematics_1042.place_schematic(pos, schematic)
    local pos1 = pos
    local pos2 = vector.new(pos.x + schematic.size.x-1, pos.y + schematic.size.y-1, pos.z + schematic.size.z-1)

    core.emerge_area(pos1, pos2, function()
        local vm = VoxelManip(pos1, pos2)
        local emin, emax = vm:read_from_map(pos1, pos2)
        local data = vm:get_data()
        local area = VoxelArea(emin, emax)

        local ly = 0
        for y=pos1.y,pos2.y do
            ly = ly + 1

            local lz = 0
            for z=pos1.z,pos2.z do
                lz = lz + 1

                local lx = 0
                for x=pos1.x,pos2.x do
                    lx = lx + 1
                    data[area:index(x,y,z)] = schematic.data[ly][lz][lx]
                end
            end
        end

        vm:set_data(data)
        vm:write_to_map()

    end)

    return "Qeued..."
end


-- Save schematic to file
function schematics_1042.save_schematic(pos1, pos2, path)
    core.emerge_area(pos1, pos2, function()
        local vm = VoxelManip(pos1, pos2)
        local emin, emax = vm:read_from_map(pos1, pos2)
        local data = vm:get_data()
        local area = VoxelArea(emin, emax)

        local schematic = schematics_1042.new_schematic(math.abs(pos1.x-pos2.x)+1, math.abs(pos1.x-pos2.x)+1, math.abs(pos1.x-pos2.x)+1)


        local ly = 0
        for y=pos1.y,pos2.y do
            ly = ly + 1
            schematic.data[ly] = {}

            local lz = 0
            for z=pos1.z,pos2.z do
                lz = lz + 1
                schematic.data[ly][lz] = {}

                local lx = 0
                for x=pos1.x,pos2.x do
                    lx = lx + 1

                    schematic.data[ly][lz][lx] = core.get_name_from_content_id(data[area:index(x,y,z)])
                end
            end
        end

        core.safe_file_write(path, core.write_json(schematic, true))
    end)

    return "Qeued..."
end
