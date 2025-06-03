local aux1_cooldown = {}
local sprint_increment_cooldown = {}






core.override_item("", {
	wield_image = "[combine:2x4:0,0=1042_plain_node.png\\^[colorize\\:#ffffff\\:0:0,2=1042_plain_node.png\\^[transformR90\\^[colorize\\:#aa8877\\:168",
	wield_scale = {x = 0.35, y = 4, z = 4},

	range = 4.0,
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level = 1,
		groupcaps = {
			breakable_by_hand = {times = {[1] = 0.1, [2] = 0.25, [3] = 0.5, [4] = 1, [5] = 2, [6] = 3, [7] = 4}, uses = 0},
			dig_immediate = {times = {[1] = 0}, uses = 0}
		},
		damage_groups = {fleshy = 1},
	},
	groups = {not_in_creative_inventory = 1}
})



-- Spawn player; depends on 1042_mapgen

local function spawn_player(player)
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

	return true
end

core.register_on_respawnplayer(spawn_player)


-- Die player

core.register_on_dieplayer(function(player, reason)
	local inv = player:get_inventory()
	local pos = player:get_pos()

	for listname, list in pairs(inv:get_lists()) do
		for i, itemstack in ipairs(list) do
			core.item_drop(itemstack, player, pos)
			inv:set_stack(listname, i, ItemStack(""))
		end
	end
end)






-- Join player

core.register_on_joinplayer(function(player, last_join)
	local name = player:get_player_name()
	aux1_cooldown[name] = 0
	sprint_increment_cooldown[name] = 0

	player:set_properties({
		visual = "mesh",
		mesh = "player.gltf",
		textures = {
			"1042_plain_node.png^[colorize:#442211:168", -- Shoe
			"1042_plain_node.png^[colorize:#442211:144", -- Leg
			"1042_plain_node.png^[colorize:#442211:144", -- Leg
			"1042_plain_node.png^[colorize:#442211:200", -- Shoe
			"1042_plain_node.png^[colorize:#553311:168", -- Shirt
			"1042_plain_node.png^[colorize:#aa8877:144", -- Neck
			"1042_plain_node.png^[colorize:#aa8877:144",  -- Head
			"1042_plain_node.png^[colorize:#aa8877:144", -- Arm
			"1042_plain_node.png^[colorize:#aa8877:144"  -- Arm
		},
		show_on_minimap = false,
		visual_size = {
			x = 4,
			y = 4
		},
		stepheight = 1.1,

		nametag_color = "#00000000",
	})
	player:set_physics_override(
		{
			gravity = 1.5,
			jump = 1.2,
			sneak_glitch = true,
			liquid_sink = 2,
			speed_walk = 0.5
		}
	)
	player:hud_set_flags(
		{
			minimap = false,
			minimap_radar = false,
			crosshair = false, -- We use custom one
			basic_debug = false,
			hotbar = false -- We use custom one
		}
	)

	-- Ligthing and enviorment
	local saturation = 1.8
	if player_api.get_data(name, "setting_greyscale") == "true" then
		saturation = 0
	end

	player:set_lighting(
		{
			volumetric_light = {
				strength = 0.1
			},
			shadows = {
				intensity = 0.4,
				tint = {r=0x99, g=0x99, b=0x99}
			},
			bloom = {
				intensity = 0.07,
				strength_factor = 1.0,
				radius = 1.0
			},
			saturation = saturation,
			exposure = {
				exposure_correction = 0.75
			}
		}
	)
	player:set_moon(
		{
			texture = "1042_plain_node.png^[colorize:#aaaaaa:144",
			visible = true,
			scale = 0.3
		}
	)
	player:set_stars(
		{
			visible = true,
			day_opacity = 0.1,
			count = 6000,
			star_color = "#99aaffff",
			scale = 0.3
		}
	)

	local zoom_time = 0
	if last_join == nil then
		spawn_player(player)
		zoom_time = 1

		core.chat_send_player(name, core.colorize("#00ff00", "It is the year 1042 and you are lost."))

	else
		core.chat_send_player(name, "It is day " .. core.get_day_count() .. " of being lost.")

	end

	player:set_fov(100, false, zoom_time)







	-- Hud

	core.hud_replace_builtin("breath", {
		type = "statbar",
		name = "breath",
		text = "1042_plain_node.png^[colorize:#ddffff:168",
		text2 = "1042_plain_node.png^[colorize:#ddffff:64",
		number = 20,
		item = 20,
		direction = 3,
		position = {x=0.98, y=0.6},
		size = {x=20,y=20}
	})

	
	core.hud_replace_builtin("health", {
		type = "statbar",
		name = "health",
		text = "1042_plain_node.png^[colorize:#ff0000:168",
		text2 = "1042_plain_node.png^[colorize:#ff0000:64",
		number = 20,
		item = 20,
		direction = 3,
		position = {x=0.98, y=0.9},
		size = {x=20,y=20}
	})


	local hotbar = {
		type = "hotbar",
		name = "hotbar",
		text = "main",
	}
	if player_api.get_data(name, "setting_hud_at_bottom") == "true" then
		hotbar.direction = 0
		hotbar.position = {x=0.5, y=0.95}
	else
		hotbar.direction = 2
		hotbar.position = {x=0.05, y=0.5}
	end

	player_api.add_hud(player, "hotbar", hotbar)



	local hunger = player_api.get_data(name, "hunger")
	if hunger == nil then
		hunger = 20
		player_api.set_data(name, "hunger", hunger)
	end

	player_api.add_hud(player, "hunger", {
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



	player:hud_add({
		type = "image",
		name = "pointer",
		text = "1042_plain_node.png^[colorize:#aaffff:128",
		position = {x=0.5, y=0.5},
		scale = {x=3,y=3},
	})

	player:hud_add({
		type = "text",
		name = "game",
		text = "1042",
		position = {x=0.98, y=0.02},
		number = 0x00ffff,
		style = 3
	})

	player:hud_set_hotbar_itemcount(10)
	player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ffff:64")
	player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ffff:128")

end)





core.register_on_leaveplayer(function(player)
	local name = player:get_player_name()

	aux1_cooldown[name] = nil
	sprint_increment_cooldown[name] = nil
end)



local function make_death_formspec( reason)
	local msg = "You "
	if reason then
		if reason._1042_death_msg then
			msg = msg .. reason._1042_death_msg

		elseif reason.type == "fall" then
			msg = msg .. "fell"

		elseif reason.type == "drown" then
			msg = msg .. "drowned"

		else
			msg = "You are dead"
		end
	else
		msg = "You are dead"
	end

	return "1042_death_screen", "formspec_version[8]size[12,8]position[0.5,0.5]style_type[*;sound=stone_dig]"..
		"bgcolor[#00223340;;]"..
		"allow_close[false]"..
		"set_focus[respawn;true]"..
		"hypertext[4,1;4,1;reason;<center>" .. msg .. "</center>]"..
		"image_button[4.5,3.5;3,1;1042_plain_node.png^[colorize:#00ffff:144;respawn;Respawn]"
end

function core.show_death_screen(player, reason)
	local player_name = player:get_player_name()
	core.show_formspec(player_name, make_death_formspec(reason))
end

core.register_on_player_receive_fields(function(player, form, fields)
	if form == "1042_death_screen" then
		local player_name = player:get_player_name()

		if fields.respawn then
			player:respawn()
			core.close_formspec(player_name, form)

		else
			core.show_formspec(player_name, make_death_formspec(nil))
		end

		return true
	end
end)


core.register_globalstep(function(dtime)
	for _, player in ipairs(core.get_connected_players()) do
		local name = player:get_player_name()
		local pos = player:get_pos()
		local pointed_thing = core_1042.get_pointed_thing(player)

		-- Collect items
		--[[for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()
			if entity and entity.name == "__builtin:item" then
				player_api.add_item_to_player_inventory(player, "main", ItemStack(entity.itemstring), entity.object:get_pos())
				entity.itemstring = nil
				entity.object:remove()
			end
		end]]


		-- Controles
		local player_controls = player:get_player_control()
		local player_meta = player:get_meta()


		-- Hunger
		local hunger_cooldown = player_api.get_data(name, "hunger_cooldown") or 0
		if hunger_cooldown >= player_api.hunger_time or ((player_controls.movement_y ~= 0 or player_controls.movement_x ~= 0) and hunger_cooldown >= (player_api.hunger_time / 2)) then
			player_api.add_hunger(player, -1)

			local hunger = player_api.get_data(name, "hunger")
			if hunger > 10 then
       			player:set_hp(player:get_hp() + 1, {_1042_reason="feed", _1042_death_msg="digested"})
			end

			player_api.set_data(name, "hunger_cooldown", 0)
		else
			player_api.set_data(name, "hunger_cooldown", hunger_cooldown + dtime)
		end



		-- Sprint
		local phy = player:get_physics_override()
		if sprint_increment_cooldown[name] then -- sanity chgeck
			if sprint_increment_cooldown[name] > 0 then
				sprint_increment_cooldown[name] = sprint_increment_cooldown[name] - dtime

			else
				if (player_controls.movement_y ~= 0 or player_controls.movement_x ~= 0) and not player_controls.sneak then
					if phy.speed_walk < 1.2 then
						phy.speed_walk = phy.speed_walk + 0.05
						player:set_physics_override(phy)

						sprint_increment_cooldown[name] = 0.5
					end

				elseif phy.speed_walk > 0.5 then
					phy.speed_walk = phy.speed_walk - 0.05
					player:set_physics_override(phy)

					sprint_increment_cooldown[name] = 0.5
				end
			end
		end

		-- Animation
		if player_controls.movement_y ~= 0 and player_meta:get_string("moving") == "false" then
			player:set_animation({x = 0, y = 40}, 3)
			player_meta:set_string("moving", "true")
		elseif player_controls.movement_y == 0 and player_meta:get_string("moving") ~= "false" then
			player:set_animation({x = 0, y = 0}, 1)
			player_meta:set_string("moving", "false")
		end

		-- _1042_use (optimised)
		if aux1_cooldown[name] then
			if aux1_cooldown[name] > 0 then
				aux1_cooldown[name] = aux1_cooldown[name] - dtime
			elseif player_controls.aux1 then
				local itemstack = player:get_wielded_item()
				local def = core.registered_items[itemstack:get_name()] or {}

				if def._1042_on_use then
					local ret_itemstack = def._1042_on_use(itemstack, player, pointed_thing)
					if ret_itemstack then
						player:set_wielded_item(ret_itemstack)
					end
					aux1_cooldown[name] = 0.5
				end
			end
		end




		-- Hud code

		if pointed_thing and pointed_thing.type == "node" then
			local node_name = core.get_node(vector.new(pointed_thing.under.x, pointed_thing.under.y, pointed_thing.under.z)).name

			player_api.update_hud(player, "pointed_thing", {
				type = "text",
				name = "pointed_node_hud",
				text = (core.registered_nodes[node_name] or {}).description or node_name,
				position = {x=0.5, y=0.05},
				number = 0x00ffdd,
				style = 3
			})

		else
			player_api.remove_hud(player, "pointed_thing") -- remove old if exists
		end


		-- Wield Item
		local item = core.registered_items[ player:get_wielded_item():get_name()]
		if item and item.description then
			player_api.update_hud(player, "wield_text", {
				type = "text",
				name = "wield_text_hud",
				text = item.description,
				position = {x=0.05, y=0.9},
				number = 0x00ffdd,
				style = 3
			})
		end

	end
end)