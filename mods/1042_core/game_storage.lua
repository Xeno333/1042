
local storage = core.get_mod_storage()

function core_1042.set(key, value)
    storage:set_string("1042_game_storage_"..key, core.serialize(value))
end

function core_1042.get(key)
    return core.deserialize(storage:get_string("1042_game_storage_"..key))
end