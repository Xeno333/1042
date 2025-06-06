
core.register_privilege("creative", {
    description = "Creative",
    give_to_admin = true,
    give_to_singleplayer = false,
    on_grant = function(name, granter_name) 
        local player = core.get_player_by_name(name)
        if player then
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))
        end
    end,
    on_revoke = function(name, granter_name) 
        local player = core.get_player_by_name(name)
        if player then
            player:set_inventory_formspec(core_1042.make_inv_formspec(player))
        end
    end
})


function core.is_creative_enabled(player_name)
    local player = core.get_player_by_name(player_name)
    return core.check_player_privs(player, "creative") or core.settings:get_bool("creative_mode", false)
end


core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if core.is_player(placer) then
        if core.is_creative_enabled(placer:get_player_name()) then
            return true
        end
    end
end)




core.register_privilege("admin", {
    description = "Admin",
    give_to_admin = true,
    give_to_singleplayer = false
})