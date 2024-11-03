

function core_1042.eat(itemstack, user, pointed_thing, value)
    user:set_hp(user:get_hp() + value, "food")
    itemstack:set_count(itemstack:get_count()-1)
    return itemstack
end