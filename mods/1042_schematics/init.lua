core.log("action", "Loading 1042_schematics...")


-- API
local path = core.get_modpath("1042_schematics")
dofile(path.."/schematics_api.lua")






-- tests

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

tests_1042.register_test("1042_schematics:test_4", function(name)
    local path = core.get_worldpath() .. "/1042_schematics_exports/"
    local rc, schem = schematics_1042.load_schematic(path.."1042_schematics__test_2_result")

    if rc then
        schem.center = true
        schematics_1042.place_schematic(core.get_player_by_name(name):get_pos(), schem)
    else
        return "Something went wrong loading schem."
    end
    
end, false)





-- commands

core.register_chatcommand("save_schematic", {
    description = "Save a schematic from world.",
    params = "", -- Add size here later
    privs = {["admin"] = true},

    func = function(name)
        return false, "Command is only a placeholder"
    end
})


core.log("action", "1042_schematics loaded.")
