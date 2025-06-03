core.log("action", "Loading 1042_schematics...")





core.register_node("1042_core:schematic_ignore", {
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
local path = core_1042.get_core_mod_path("1042_schematics")
dofile(path.."/schematics_api.lua")





-- commands #fixme

core.register_chatcommand("save_schematic", {
    description = "Save a schematic from world.",
    params = "<length>, <hight>, <width>, <path>(, ignore_air)",
    privs = {["admin"] = true},

    func = function(name, param)
        if not (name and param) then return false, nil end

        local params = {}
        for s in string.gmatch(param, "([^,%s+]+)") do
            params[#params+1] = s
        end

        local x = tonumber(params[1])
        local y = tonumber(params[2])
        local z = tonumber(params[3])
        local path = core.get_worldpath() .. "/1042_schematics_exports/" .. params[4]

        if x and y and z and path then
            local v = vector.new(x-(x/math.abs(x)), y-(y/math.abs(y)), z-(z/math.abs(z)))
            local pos = core.get_player_by_name(name):get_pos()
            pos = vector.new(math.floor(pos.x+0.5), math.floor(pos.y+0.5), math.floor(pos.z+0.5))

            local ignore_air = false
            if params[5] == "ignore_air" then ignore_air = true end

            schematics_1042.save_schematic(pos, pos + v, path, ignore_air)
            return true, "Done"

        else
            return false, nil
        end
    end
})

core.register_chatcommand("load_schematic", {
    description = "Load a schematic into world.",
    params = "<path>, <force (true/false)>(, center)",
    privs = {["admin"] = true},

    func = function(name, param)
        if not (name and param) then return false, nil end

        local params = {}
        for s in string.gmatch(param, "([^,%s+]+)") do
            params[#params+1] = s
        end

        local path = params[1]
        local force = params[2]
        local center = params[3]
        if not path then return false, nil end

        if force == "true" then
            force = true
        else
            force = false
        end

        local schem = schematics_1042.load_schematic(core.get_worldpath() .. "/1042_schematics_exports/" .. path)
        if schem then
            if center == "center" then schem.center = true end

            local pos = core.get_player_by_name(name):get_pos()
            pos = vector.new(math.floor(pos.x+0.5), math.floor(pos.y+0.5), math.floor(pos.z+0.5))

            schematics_1042.place_schematic(pos, schem, force)
            return true, "Done"

        else
            return false, "Could not load schematic!"
        end
    end
})


core.log("action", "1042_schematics loaded.")
