

function core_1042.eat(itemstack, user, value, p_chance)
    if p_chance and math.random(1, p_chance) == 1 then
        user:set_hp(user:get_hp() - value, "bad food")
    else
        user:set_hp(user:get_hp() + value, "food")
        itemstack:set_count(itemstack:get_count()-1)
    end

    return itemstack
end