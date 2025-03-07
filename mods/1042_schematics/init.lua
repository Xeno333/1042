core.log("action", "Loading 1042_schematics...")





core.register_node("1042_schematics:schematic_ignore", {
    description = "Schematic Ignore",
    drawtype = "nodebox",
    tiles = {"1042_plain_node.png^[colorize:#ff00ff:200"},

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,

    node_box = {
        type = "fixed",
        fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1}
    },
    selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1}
    },

    
    groups = {dig_immediate = 1},
})



-- API
local path = core.get_modpath("1042_schematics")
dofile(path.."/schematics_api.lua")





-- commands #fixme

core.register_chatcommand("save_schematic", {
    description = "Save a schematic from world.",
    params = "", -- Add size here later
    privs = {["admin"] = true},

    func = function(name)
        return false, "Command is only a placeholder"
    end
})


core.log("action", "1042_schematics loaded.")
