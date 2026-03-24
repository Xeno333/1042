player_api = {
    hunger_time = 60 -- seconds per -1 hunger
}



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
        end

        return true


    else -- if doesnt exist
        return false
    end
end

function player_api.get_hud(player, unique_hud_name)
    local player_name = player:get_player_name()
    local huds = player_huds[player_name] or {}

    if huds[unique_hud_name] then -- if no player huds table
		return player:hud_get(huds[unique_hud_name])

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

function player_api.get_hud_id(player, unique_hud_name)
    local huds = player_huds[player:get_player_name()]

    if huds and huds[unique_hud_name] then
        return huds[unique_hud_name]

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

function player_api.add_hunger(player, v, reason)
    local name = player:get_player_name()
	local hunger = player_api.get_data(name, "hunger")
    hunger = math.min(hunger + v, 20)
    if v < 0 and hunger < 0 then
        hunger = 0
        player:set_hp(player:get_hp() - 1, {_1042_reason="starved", _1042_death_msg="starved"})
    end

    player_api.set_data(name, "hunger", hunger)

    player_api.update_hud(player, "hunger", {
		type = "statbar",
		name = "hunger",
		text = "1042_plain_node.png^[colorize:#ff8822:168",
		text2 = "1042_plain_node.png^[colorize:#ff8822:64",
		number = hunger,
		item = 20,
		direction = 3,
		position = {x=0.96, y=0.9},
		size = {x=20,y=20}
    })
end


-- Player data

function player_api.set_data(playername, id, data)
    core_1042.set("1042_player_data__" .. playername .. "__" .. id, data)
end

function player_api.get_data(playername, id)
    return core_1042.get("1042_player_data__" .. playername .. "__" .. id)
end




function player_api.spawn_player(player)
	local pos = nil

	for tries = 0, 5000 do -- Max 5000 tries (This is very fast, and is mearly theoretical)
		local x = math.random(0, 20000)
		local z = math.random(0, 20000)
		local y = mapgen_1042.get_spawn_y(x, z) 

		if y then
			pos = vector.new(x, y+1, z)
			break
		end
	end

	-- stop inf loop
	if not pos then
		pos = vector.new(0, 0, 0) -- Put here on problem to stop inf loop
	end

	player:set_pos(pos)

	-- Reset hunger
	player_api.set_data(player:get_player_name(), "hunger", 20)
	player_api.add_hunger(player, 0)

	return true
end

core.register_privilege("spawn", {
    description = "Respawn",
    give_to_admin = true,
    give_to_singleplayer = false
})
core.register_chatcommand("spawn", {
    privs = {["spawn"] = true},
    description = "Respawn",
    func = function(name)
        player_api.spawn_player(core.get_player_by_name(name))
        return true, "Done!"
    end
})

local default_physics = {
    gravity = 1.5,
    jump = 1.2,
    speed_walk = 0.5,
    sneak_glitch = true,
    acceleration_default = 1,
    acceleration_air = 1
}

local experimental_physics = {
    gravity = 0.8,
    jump = 1,
    speed_walk = 1.5,
    sneak_glitch = true,
    acceleration_default = 2,
    acceleration_air = 0.8
}

player_api.get_default_physics = function()
    if core.settings:get_bool("1042_experimental_physics", false) == true then
        return experimental_physics
    else
        return default_physics
    end
end

function player_api.set_physics(player, override)
    local phy = player:get_physics_override()
    if core.settings:get_bool("1042_experimental_physics", false) == true then
        for k, v in pairs(experimental_physics) do
            phy[k] = v
        end
    else
        for k, v in pairs(default_physics) do
            phy[k] = v
        end
    end

    if override then
        for k, v in pairs(override) do
            phy[k] = v
        end
    end

    player:set_physics_override(phy)
	
	player:set_bone_override("Spine", nil)
end