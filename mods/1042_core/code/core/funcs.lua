core_1042.reach_distance = 4
local storage = core.get_mod_storage()



-- Loot
core_1042.loots = {}


function core_1042.register_loot(def)
    core_1042.loots[#core_1042.loots+1] = {
        name = def.name,
        max_count = def.max_count
    }
end


function core_1042.get_loot()
    local ret = nil
    if #core_1042.loots > 0 then
        local def = core_1042.loots[core_1042.rand:next(1, #core_1042.loots)]
        ret = ItemStack(def.name .. " " .. core_1042.rand:next(1, (def.max_count or 1)))
    end
    return ret
end





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




function core_1042.eat(itemstack, player, value, p_chance)
    if p_chance and math.random(1, p_chance) == 1 then
        player:set_hp(player:get_hp() - (value * 2), {_1042_reason="bad_food", _1042_death_msg="ate poisen"})
    else
        player_api.add_hunger(player, value, reason, {_1042_reason="food"})
        itemstack:set_count(itemstack:get_count() - 1)
    end

    return itemstack
end

function core_1042.get_pointed_thing(player)
    local pos = player:get_pos()
    pos.y = pos.y + player:get_properties().eye_height
    local ray = core.raycast(vector.new(pos.x, pos.y, pos.z), vector.add(vector.new(pos.x, pos.y, pos.z), vector.multiply(player:get_look_dir(), core_1042.reach_distance)), false, false)

    return ray:next()
end

function core_1042.read_file(filename)
    local file = io.open(filename)
    
    if not file then
        return nil
    end
    
    local str = file:read("*a")
    
    file:close()

    return str
end