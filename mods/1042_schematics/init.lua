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
    return true
end


function schematics_1042.place_schematic(pos, schem)
    if not schematics_1042.is_schamatic(schem) then return false end

    local pos_min
    local pos_max


    local vm = core.get_voxel_manip(pos - (schem.size/2), pos + (schem.size/2))
end






core.log("action", "1042_schematics loaded.")
