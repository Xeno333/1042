
core.register_privilege("creative",
    {
        description = "Creative",
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
    }
)


function core_1042.is_creative(player)
    return core.check_player_privs(player, "creative") or core.is_creative_enabled(player:get_player_name()) 
end


core.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
    if core.is_player(placer) then
        if core_1042.is_creative(placer) then
            return true
        end
    end
end)
