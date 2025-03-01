player_api = {}



function player_api.add_item_to_player_inventory(player, list, itemstack, drop_overflow_pos)
    local overflow = itemstack

    if core.is_player(player) then
        local inv = player:get_inventory()
        overflow = inv:add_item(list, itemstack)
    end

    local count = overflow:get_count()
    if count > 0 then
        core.add_item(drop_overflow_pos, overflow)
    end

    return count
end




-- Hunger system
