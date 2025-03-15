player_api = {}



-- HUDs

local player_huds = {} -- Private

function player_api.add_hud(player, unique_hud_name, hud_def)
    local player_name = player:get_player_name()

    if not player_huds[player_name] then -- if no player huds table
        player_huds[player_name] = {}
        player_huds[player_name][unique_hud_name] = player:hud_add(hud_def)
        return true
        
    elseif not player_huds[player_name][unique_hud_name] then -- if not exists
        player_huds[player_name][unique_hud_name] = player:hud_add(hud_def)
        return true

    else -- if exists
        return false
    end
end

function player_api.remove_hud(player, unique_hud_name)
    local player_name = player:get_player_name()
    local huds = player_huds[player_name] or {}

    if huds[unique_hud_name] then -- if no player huds table
		player:hud_remove(huds[unique_hud_name])
        huds[unique_hud_name] = nil

        if not next(player_huds[player_name]) then -- emtpy
            player_huds[player_name] = nil
            return true
        end

        return true


    else -- if doesnt exist
        return false
    end
end

function player_api.update_hud(player, unique_hud_name, hud_def)
    local player_name = player:get_player_name()

    -- if no player huds table make it
    if not player_huds[player_name] then
        player_huds[player_name] = {}

     -- if exists remove
    elseif player_huds[player_name][unique_hud_name] then 
        player:hud_remove(player_huds[player_name][unique_hud_name])
    end

    -- add new
    player_huds[player_name][unique_hud_name] = player:hud_add(hud_def)

    return true
end

function player_api.hud_exists(player, unique_hud_name)
    local huds = player_huds[player:get_player_name()]

    if huds and huds[unique_hud_name] then
        return true

    else
        return false
    end
end

core.register_on_leaveplayer(function(player)
	player_huds[player:get_player_name()] = nil
end)




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