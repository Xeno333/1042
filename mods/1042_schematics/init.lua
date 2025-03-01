core.log("action", "Loading 1042_schematics...")

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


function schematics_1042.place_schematic(pos, schem)
    if not schematics_1042.is_schamatic(schem) then return false end

    local pos_min
    local pos_max

    local mid_point = vector.new(schem.size.x/2, schem.size.y/2, schem.size.z/2)

    local vm = core.get_voxel_manip(pos - mid_point, pos + mid_point)

    -- Add more
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



tests_1042.register_test("1042_schematics:test_1", function()
    local schem = schematics_1042.new_schematic()
    return schematics_1042.is_schamatic(schem)
end, true)


tests_1042.register_test("1042_schematics:test_2", function()
    local path = core.get_worldpath() .. "/1042_schematics_exports/"
    tests_1042.print("1042_schematics:test_2: " .. tostring(core.mkdir(path)))
    return schematics_1042.save_schematic(vector.new(-2,-2,-2), vector.new(2,2,2), path.."1042_schematics__test_2_result")
end, false)

tests_1042.register_test("1042_schematics:test_3", function()
    local path = core.get_worldpath() .. "/1042_schematics_exports/"
    local rc, val = schematics_1042.load_schematic(path.."1042_schematics__test_2_result")
    return dump({rc, val})
end, false)




core.register_chatcommand("save_schematic", {
    description = "Save a schematic from world.",
    params = "", -- Add size here later
    privs = {["admin"] = true},

    func = function(name)
        return false, "Command is only a placeholder"
    end
})


core.log("action", "1042_schematics loaded.")
