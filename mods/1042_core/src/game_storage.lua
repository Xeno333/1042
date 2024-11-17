
local storage = core.get_mod_storage()

function core_1042.set(key, value)
    storage:set_string("1042_game_storage_json_"..key, core.write_json({cont = value}) or "")
end

function core_1042.get(key)
    local json = storage:get_string("1042_game_storage_json_"..key)
    if json == "" then
        return nil
    end
    return (core.parse_json(json) or {}).cont
end