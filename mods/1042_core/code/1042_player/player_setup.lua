local aux1_cooldown = {}
local auxing_1042 = {}
local player_callbacks = {}
local sprint_increment_cooldown = {}






core.override_item("", {
	wield_image = "wieldhand.png",
	wield_scale = {x = 1, y = 1, z = 4},

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

	-- Reset hunger
	player_api.set_data(player:get_player_name(), "hunger", 20)
	player_api.add_hunger(player, 0)

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



local function set_physics(player)
	player:set_physics_override(
		{
			gravity = 1.5,
			jump = 1.2,
			sneak_glitch = true,
			liquid_sink = 2,
			speed_walk = 0.5
		}
	)
	player:set_bone_override("Spine", nil)
end


-- Join player

core.register_on_joinplayer(function(player, last_join)
	local name = player:get_player_name()
	aux1_cooldown[name] = 0
	sprint_increment_cooldown[name] = 0
	auxing_1042[name] = {}

	player_callbacks[name] = {}

	player:set_properties({
		visual = "mesh",
		mesh = "player.glb",
		textures = {
			"character.png",
			"character.png",
			"character.png",
			"character.png",
			"character.png",
			"character.png",
			"character.png",
			"character.png",
		},
		--[[
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
		},]]
		show_on_minimap = false,
		visual_size = {
			x = 7,
			y = 7
		},
		stepheight = 1.1,

		nametag_color = "#00000000",
	})
	set_physics(player)
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
			texture = "moon.png",
			visible = true,
			scale = 0.3
		}
	)
	player:set_sun({sunrise_visible = false})
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
	if player_api.get_data(name, "setting_hotbar_mode") == "Bottom" then
		hotbar.direction = 0
		hotbar.position = {x=0.5, y=0.95}
	elseif player_api.get_data(name, "setting_hotbar_mode") == "Top" then
		hotbar.direction = 0
		hotbar.position = {x=0.5, y=0.05}
	else
		hotbar.direction = 2
		hotbar.position = {x=0.05, y=0.5}
	end

	player_api.add_hud(player, "hotbar", hotbar)
	player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ffff:128^[opacity:64")
	player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ffff:128^[opacity:128")
	player:hud_set_hotbar_itemcount(10)



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


	player_api.add_hud(player, "crosshair", {
		type = "image",
		name = "pointer",
		text = "1042_plain_node.png^[colorize:#aaffff:128",
		position = {x=0.5, y=0.5},
		scale = {x=3,y=3},
	})

	player_api.add_hud(player, "1042", {
		type = "text",
		name = "game",
		text = "1042",
		position = {x=0.98, y=0.02},
		number = 0x00ffff,
		style = 3
	})
end)





core.register_on_leaveplayer(function(player)
	local name = player:get_player_name()

	aux1_cooldown[name] = nil
	auxing_1042[name] = nil
	player_callbacks[name] = nil
	sprint_increment_cooldown[name] = nil
end)

local function remove_glider(player)
	local meta = player:get_meta()
	if meta:get_string("glider_entity_guid") ~= "" then
		local glider = core.objects_by_guid[meta:get_string("glider_entity_guid")]
		if (glider ~= nil) then
			glider:set_detach()
		end
		meta:set_string("glider_entity_guid", "")
	end
end

local function add_glider(player)
	local meta = player:get_meta()
	if meta:get_string("glider_entity_guid") == "" then
		local glider = core.add_entity(player:get_pos(), "1042_core:glider_entity", nil)
		meta:set_string("glider_entity_guid", glider:get_guid())
		glider:set_attach(player, "Spine", vector.new(0, 0.5, -0.5), vector.new(90, 0, 0), true)
		if core.settings:get_bool("1042_flight_cam") then
			player:set_camera({mode="third"}) -- force into third person
			core.after(0, function(...) player:set_camera(...) end, {mode="any"}) -- allow changing pov again
		end
	end
end

local function make_death_formspec(reason)
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
		if core_1042.get(name .. "_gliding") == "on" then
			if core_1042.player.set_animation(player, {name="glide", range={x = 2.7, y = 3.7}, speed=0.3}) then
				add_glider(player)
			end
		else
			if player_controls.movement_y ~= 0 then
				remove_glider(player)
				core_1042.player.set_animation(player, {name="walk", range={x = 0, y = 0.8}, speed=1.1})
			elseif player_controls.movement_y == 0 and core_1042.player.get_animation ~= "walk" then
				remove_glider(player)
				core_1042.player.set_animation(player, {name="idle", range={x = 0, y = 0}, speed=1})
			end
		end

		local itemstack = player:get_wielded_item()
		local def = core.registered_items[itemstack:get_name()] or {}

		-- _1042_use (optimised)
		if aux1_cooldown[name] then
			if aux1_cooldown[name] > 0 then
				aux1_cooldown[name] = aux1_cooldown[name] - dtime
			elseif player_controls.aux1 then
				if def._1042_on_use then
					local ret_itemstack = def._1042_on_use(itemstack, player, pointed_thing)
					if ret_itemstack then
						player:set_wielded_item(ret_itemstack)
					end
					aux1_cooldown[name] = 0.5
				end
			end
		end


		-- aux2

		if player_controls.zoom and not player_controls.aux1 then
			if not auxing_1042[name].on then
				auxing_1042[name].on = true

				if def._1042_aux then
					if def._1042_aux.mode == "selection" then
						local hotbar = player_api.get_hud(player, "hotbar")
						if hotbar then
							player_api.remove_hud(player, "hotbar")

							local selection = {
								type = "hotbar",
								name = "selection",
								text = "selection",
							}
							if player_api.get_data(name, "setting_hotbar_mode") == "Bottom" or def._1042_aux.horizontal then
								selection.direction = 0
								selection.position = {x=0.5, y=0.95}
							elseif player_api.get_data(name, "setting_hotbar_mode") == "Top" then
								selection.direction = 0
								selection.position = {x=0.5, y=0.05}
							else
								selection.direction = 2
								selection.position = {x=0.05, y=0.5}
							end

							player_api.add_hud(player, "selection", selection)

							local inv = player:get_inventory()
							local main = inv:get_list("main")
							inv:set_list("1042_selection_main_backup", main)

							auxing_1042[name].weild_index = player:get_wield_index()
							auxing_1042[name].org_weild_index = auxing_1042[name].weild_index

							inv:set_size("main", 0)
							inv:set_size("main", def._1042_aux.num or 10)
							inv:set_stack("main", auxing_1042[name].org_weild_index, inv:get_stack("1042_selection_main_backup", auxing_1042[name].org_weild_index))


							if def._1042_aux.bar_params ~= nil then
								player:hud_set_hotbar_image(def._1042_aux.bar_params.image)
								player:hud_set_hotbar_selected_image(def._1042_aux.bar_params.selected_image)
							else
								player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ff00:128^[opacity:64")
								player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ff00:128^[opacity:128")
							end
							player:hud_set_hotbar_itemcount(def._1042_aux.num or 10)

							local function handel()
								local w = player:get_wield_index()

								if auxing_1042[name].on then
									player_callbacks[name].selection = handel


								if w ~= auxing_1042[name].weild_index then
									local inv = player:get_inventory()

									local stack = inv:get_stack("main", w)
									inv:set_stack("main", w, inv:get_stack("main", auxing_1042[name].weild_index))
									inv:set_stack("main", auxing_1042[name].weild_index, stack)

									auxing_1042[name].weild_index = w

									if def._1042_aux.func then
										def._1042_aux.func(player, (def._1042_aux.num or 10) - w)
									end
								end

								-- Restore
								elseif auxing_1042[name] ~= nil then
									player_api.add_hud(player, "hotbar", hotbar)
									player_api.remove_hud(player, "selection")

									local inv = player:get_inventory()
									local stack = inv:get_stack("main", auxing_1042[name].weild_index)
									for i = 1, inv:get_size("main") do
										if i ~= auxing_1042[name].weild_index then
											player_api.add_item_to_player_inventory(player, "1042_selection_main_backup", inv:get_stack("main", i), pos + vector.new(0, 1, 0))
										end
									end
									local main = inv:get_list("1042_selection_main_backup")

									inv:set_size("main", 40)
									inv:set_list("main", main)
									inv:set_stack("main", auxing_1042[name].org_weild_index, stack)

									player:hud_set_hotbar_image("1042_plain_node.png^[colorize:#00ffff:128^[opacity:64")
									player:hud_set_hotbar_selected_image("1042_plain_node.png^[colorize:#00ffff:128^[opacity:128")
									player:hud_set_hotbar_itemcount(10)

									if def._1042_aux.done_func then
										def._1042_aux.done_func(player, (def._1042_aux.num or 10) - w)
									end

									return
								end
							end


							if def._1042_aux.func then
								def._1042_aux.func(player, (def._1042_aux.num or 10) - auxing_1042[name].weild_index)
							end
							player_callbacks[name].selection = handel
						end
					end
				end
			end
		elseif player_controls.zoom and player_controls.aux1 then
			if not auxing_1042[name].on_and_aux1 then
				auxing_1042[name].on_and_aux1 = true
				-- Free extra
			end
		else
			auxing_1042[name].on = nil
			auxing_1042[name].on_and_aux1 = nil
		end

		if player_callbacks[name] then
			for k, func in pairs(player_callbacks[name]) do
				player_callbacks[name][k] = nil
				func()
			end
		end



		-- Hud code

		if pointed_thing and pointed_thing.type == "node" then
			local node_name = core.get_node(vector.new(pointed_thing.under.x, pointed_thing.under.y, pointed_thing.under.z)).name

			player_api.update_hud(player, "pointed_thing", {
				type = "text",
				name = "pointed_node_hud",
				text = (core.registered_nodes[node_name] or {}).short_description or node_name,
				position = {x=0.5, y=0.05},
				number = 0x00ffdd,
				style = 3
			})

		else
			player_api.remove_hud(player, "pointed_thing") -- remove old if exists
		end


		-- Wield Item
		local item = core.registered_items[ player:get_wielded_item():get_name()]
		if item and item.short_description then
			player_api.update_hud(player, "wield_text", {
				type = "text",
				name = "wield_text_hud",
				text = item.short_description,
				position = {x=0.05, y=0.9},
				number = 0x00ffdd,
				style = 3
			})
		end

		local dir = player:get_look_dir()
		local bone_pos = player:get_bone_position("Neck")
		player:set_bone_override("Neck", { position = nil, rotation = {vec=vector.new((1-dir.y+270)*1.6, 0, 0), interpolation=0.1}})

		local function apply_glide(player, dtime)
			player:set_physics_override({
				gravity = 0.3,
				speed_walk = 0
			})

			local vel = player:get_velocity()
			--local dir = player:get_look_dir()

			player:set_bone_override("Spine", { position = nil, rotation = {vec=vector.new((1-dir.y+45)*1.5, 0, 0), interpolation=0.2}})
			player:set_bone_override("Neck", nil)

			local speed = math.max(math.min(math.sqrt(vel.x*vel.x + vel.y*vel.y + vel.z*vel.z), 8), 0)

			local s = speed * 0.1
			local r = 50
			local n = 0.5
			local dy = dir.y + 0.2
			if dy > 0 then
				n = n / math.max(0.1, math.floor(dy * 20) / 10)
			end

			player:add_velocity(vector.new(-vel.x / r, -vel.y / r * 2, -vel.z / r))
			player:add_velocity(vector.new(dir.x * s, dir.y * s * n, dir.z * s))
		end

		if core_1042.get(name .. "_gliding") == "on" then
			local p_pos = player:get_pos()
			local node_below = core.get_node({x = p_pos.x, y = p_pos.y - 0.5, z = p_pos.z})
			local def = core.registered_nodes[node_below.name]

			if def.walkable then
				core_1042.set(name .. "_gliding", "off")
				set_physics(player)

			elseif player_controls.jump then
				apply_glide(player, dtime)

			else
				player:set_physics_override(core_1042.get(name .. "_gliding_physics_backup"))
			end
		end
	end
end)