core_1042.crafting = {
    registered_crafts = {}, -- Sorted by type tables and then subsorted by mod that uses it. Non-game spesific and can be in any format, i.e. the mods internal format.
    registered_crafts_results = {}, -- Indexed by result with value being a table of recipies, can be used for crafting guid.
}

local registered_crafts_registrations = {} -- sorted by type tables


-- def uses fields type and result all others are up to mods

function core_1042.crafting.default_register_craft(def)
    core_1042.crafting.registered_crafts[def.type][#core_1042.crafting.registered_crafts[def.type]+1] = def
end

function core_1042.crafting.register_craft(def)
    local rc = (registered_crafts_registrations[def.type] or core_1042.crafting.default_register_craft)(def)

    if not core_1042.crafting.registered_crafts_results[def.result] then
        core_1042.crafting.registered_crafts_results[def.result] = {}
    end
    core_1042.crafting.registered_crafts_results[def.result][#core_1042.crafting.registered_crafts_results[def.result]+1] = def

    return rc
end

function core_1042.crafting.register_craft_type(type_name, reg_craft_func)
    if not core_1042.crafting.registered_crafts[type_name] then
        core_1042.crafting.registered_crafts[type_name] = {}
        registered_crafts_registrations[type_name] = reg_craft_func
        return true
    end

    return false
end



core_1042.crafting.register_craft_type("1042_default", nil)