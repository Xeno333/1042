
core.register_node("1042_smithing:stone_oven_off", {
	description = "Stone Oven",
	drawtype = "mesh",
	mesh = "oven.obj",
	tiles = {
		"1042_plain_node.png^[colorize:#777777:200",
		"1042_plain_node.png^[colorize:#555555:200"
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
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
			{-0.375, 0.375, -0.5, 0.375, 1.5, 0.5}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
			{-0.375, 0.375, -0.5, 0.375, 1.5, 0.5}
		}
	},
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		if (itemstack:get_name() == "1042_smithing:campfire") then
			itemstack:take_item()
			core.set_node(pos, {name="1042_smithing:stone_oven_on", param2=node.param2})
		end
	end,
	
	drop = "",
	groups = {stone = 1}
})

core.register_node("1042_smithing:stone_oven_on", {
	description = "Stone Oven",
	drawtype = "mesh",
	mesh = "oven.obj",
	tiles = {
		"1042_plain_node.png^[colorize:#777777:200",
		"1042_plain_node.png^[colorize:#dd1100:128"
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
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
			{-0.375, 0.375, -0.5, 0.375, 1.5, 0.5}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.5},
			{-0.375, 0.375, -0.5, 0.375, 1.5, 0.5}
		}
	},
	
	drop = "",
	groups = {burning = 1, stone = 1},
	
	on_construct = function(pos)
		core.add_entity({x = pos.x, y = pos.y - 0.12, z = pos.z}, "1042_smithing:campfire_fire", nil)
	end,
	
	on_destruct = function(pos)
		for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()
			if entity then
				if entity.name == "1042_nodes:campfire_fire" or string.find(entity.name, "1042_nodes:mold_cooking_") then
					entity.object:remove()
				end
			end
		end
	end,
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = itemstack:get_name()
		if not name or name == "" then return end
		local has_cooking = false
		for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()
			if entity then
				if string.find(entity.name, "1042_smithing:mold_cooking_") then
					has_cooking = true
				end
			end
		end
		for i, v in ipairs(moldable_things) do
			if ("1042_smithing:mold_with_" .. v.name == name and not has_cooking) then
				itemstack:take_item()
				core.add_entity({x = pos.x, y = pos.y+.65, z = pos.z}, "1042_smithing:mold_cooking_" .. v.name, nil)
			end
		end
	end
})