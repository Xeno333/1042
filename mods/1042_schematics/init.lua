core.log("action", "Loading 1042_schematics...")

schematics_1042 = {
    registered_schematics = {}
}


function schematics_1042.new_schematic()
    return {
        replacements = {},
        data = {},
        size = vector.new(0, 0, 0),
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
    if type(schem.replacements) ~= "table" then return false end
    if type(schem.data) ~= "table" then return false end
    if type(schem.size) ~= "table" then return false end
    if type(schem.center) ~= "boolean" then return false end

    return true
end


function schematics_1042.place_schematic(pos, schem)
    if not schematics_1042.is_schamatic(schem) then return false end

    local pos_min
    local pos_max

    local mid_point = vector.new(schem.size.x/2, schem.size.y/2, schem.size.z/2)

    local vm = core.get_voxel_manip(pos - mid_point, pos + mid_point)
end




tests_1042.register_test("1042_schematics:test_1", function()
    local schem = schematics_1042.new_schematic()
    return schematics_1042.is_schamatic(schem)
end, true)



core.log("action", "1042_schematics loaded.")
