
cooking_1042.moldable_things = {
}



core_1042.phases.register_callback("complex_registration", function()
	for id, def in pairs(core.registered_items) do
		local thing = def._1042_moldable
		if thing and not cooking_1042.moldable_things[id] then
			cooking_1042.moldable_things[id] = thing

			core.register_node(":1042_core:mold_with_" .. thing.name, {
				description = "Mold with " .. thing.name,
				drawtype = "mesh",
				mesh = "mold_filled.obj",
				tiles = {
					"1042_plain_node.png^[colorize:" .. thing.color .. ":200",
					"1042_plain_node.png^[colorize:#777777:200"
				},
				
				paramtype2 = "4dir",
				paramtype = "light",
				sunlight_propagates = true,

				sounds = {
					dig = {
						name = "stone_dig",
						gain = 2,
						pitch = 1
					}
				},
				selection_box = {
					type = "fixed",
					fixed = {
						{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
					}
				},
				collision_box = {
					type = "fixed",
					fixed = {
						{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
					}
				},
			
				groups = {breakable_by_hand = 2}
			})

			core.register_entity(":1042_core:mold_cooking_" .. thing.name, {
				initial_properties = {
					hp_max = 1000,
					physical = false,
					pointable = false,
					collide_with_objects = false,
					visual = "mesh",
					mesh = "mold_filled.obj",
					textures = {
						"1042_plain_node.png^[colorize:" .. thing.color .. ":200",
						"1042_plain_node.png^[colorize:#777777:200"
					},
					use_texture_alpha = false,
					visual_size = {x = 5, y = 5, z = 5},
					
					selection_box = {
						type = "fixed",
						fixed = {
							{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
						}
					},
					collision_box = {
						type = "fixed",
						fixed = {
							{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
						}
					},
					
					groups = {breakable_by_hand = 2}
				},

				_1042_core_drop = thing.drop,

				on_activate = function(self, staticdata, dtime_s)
					core.after(30, function()
						local entity = self.object
						core.add_item(self.object:get_pos(), (self["_1042_core_drop"]))
						entity:remove()
					end)
				end,
			})

		elseif cooking_1042.moldable_things[id] then -- Failed
			core.log("warning", "Failed to register mold for '" .. id .."'.")
		end
	end
end)

core.register_node("1042_core:mold_empty", {
	description = "Empty mold",
	drawtype = "mesh",
	mesh = "mold_empty.obj",
	tiles = {
		"1042_plain_node.png^[colorize:#777777:200"
	},

	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.25, 0.3125, -0.25, 0.1875}
		}
	},
	
	paramtype2 = "4dir",
	paramtype = "light",
	sunlight_propagates = false,

	sounds = {
		dig = {
			name = "stone_dig",
			gain = 2,
			pitch = 1
		}
	},
	
	groups = {breakable_by_hand = 2},
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = itemstack:get_name()
		if not name or name == "" then return end

		local v = cooking_1042.moldable_things[name]
		if v then
			itemstack:take_item()
			core.swap_node(pos, {name="1042_core:mold_with_" .. v.name, param2=node.param2})
		end
	end
})

core_1042.crafting.register_craft({
	type = "1042_chisel",
	result = "1042_core:mold_empty",

	node = "1042_core:rock",
	cuting_formspec_image = "1042_chiseling_mold.png",
	duration = 8
})
core_1042.crafting.register_craft({
	result = "1042_core:mold_empty",
	type = "1042_chisel",

	node = "1042_core:stone",
	cuting_formspec_image = "1042_chiseling_mold.png",
	duration = 8
})