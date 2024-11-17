local reach_distance = 4


function core_1042.eat(itemstack, user, value, p_chance)
    if p_chance and math.random(1, p_chance) == 1 then
        user:set_hp(user:get_hp() - (value * 2), "bad food")
    else
        user:set_hp(user:get_hp() + value, "food")
        itemstack:set_count(itemstack:get_count() - 1)
    end

    return itemstack
end

function core_1042.get_pointed_thing(player)
    local pos = player:get_pos()
    pos.y = pos.y + player:get_properties().eye_height
    local ray = core.raycast(vector.new(pos.x, pos.y, pos.z), vector.add(vector.new(pos.x, pos.y, pos.z), vector.multiply(player:get_look_dir(), reach_distance)), false, false)

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