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

function player_api.set_physics(player, override)
    local gravity = 1.5
    local jump = 1.2
    local speed_walk = 0.5
    local speed_climb = 1
    local speed_crouch = 1
    local speed_fast = 1
    local speed = 1
    local acceleration_default = 1
    local acceleration_air = 1
    local acceleration_fast = 1
    local liquid_sink = 1
    local liquid_fluidity = 1
    local liquid_fluidity_smooth = 1
    local sneak = true
    local sneak_glitch = true
    local new_move = true

    if override ~= nil then
        gravity = override.gravity or gravity
        jump = override.jump or jump
        speed_walk = override.speed_walk or speed_walk
        speed_climb = override.speed_climb or speed_climb
        speed_crouch = override.speed_crouch or speed_crouch
        speed_fast = override.speed_fast or speed_fast
        speed = override.speed or speed
        acceleration_default = override.acceleration_default or acceleration_default
        acceleration_air = override.acceleration_air or acceleration_air
        acceleration_fast = override.acceleration_fast or acceleration_fast
        liquid_sink = override.liquid_sink or liquid_sink
        gravity = override.gravity or gravity
        liquid_fluidity = override.liquid_fluidity or liquid_fluidity
        liquid_fluidity_smooth = override.liquid_fluidity_smooth or liquid_fluidity_smooth
        sneak = override.sneak or sneak
        sneak_glitch = override.sneak_glitch or sneak_glitch
        new_move = override.new_move or new_move
    elseif core.settings:get_bool("1042_experimental_physics") == true then
        gravity = 0.8
        jump = 1
        speed_walk = 1.5
    end

    player:set_physics_override(
        {
            gravity = gravity,
            jump = jump,
            speed_walk = speed_walk,
            speed_climb = speed_climb,
            speed_crouch = speed_crouch,
            speed_fast = speed_fast,
            speed = speed,
            acceleration_default = acceleration_default,
            acceleration_air = acceleration_air,
            acceleration_fast = acceleration_fast,
            liquid_sink = liquid_sink,
            liquid_fluidity = liquid_fluidity,
            liquid_fluidity_smooth = liquid_fluidity_smooth,
            sneak = sneak,
            sneak_glitch = sneak_glitch,
            new_move = new_move,
        }
    )
	
	player:set_bone_override("Spine", nil)
end