cookable_things = {
	{
		id = "1042_nodes:pork_raw",
		hanging = true,
		name = "pork",
		drop = "1042_nodes:pork_cooked",
		model = "cooking_pork.obj",
		textures = {
			"1042_plain_node.png^[colorize:#672307:200",
			"1042_plain_node.png^[colorize:#ffbb88:128",
			"1042_plain_node.png^[colorize:#ffaa77:144",
			"1042_plain_node.png^[colorize:#ff9966:128"
		}
	}
}

core.register_entity("1042_smithing:campfire_fire", {
	initial_properties = {
		physical = false,
		pointable = false,
		collide_with_objects = false,
		visual = "mesh",
		mesh = "campfire_fire.obj",
		visual_size = {x=15, y=15, z=15},
		textures = {
			"1042_plain_node.png^[colorize:#cc2200:128"
		},
		use_texture_alpha = true,
		backface_culling = false,
		show_on_minimap = true
	},
})

for i, thing in ipairs(cookable_things) do
	core.register_entity("1042_smithing:campfire_cooking_"  .. thing.name, {
		initial_properties = {
			hp_max = 1000,
			physical = false,
			pointable = false,
			collide_with_objects = false,
			visual = "mesh",
			mesh = thing.model,
			visual_size = {x=10, y=10, z=10},
			textures = thing.textures,
			use_texture_alpha = false
		},
		
		_dorp = thing.drop,
		
		on_activate = function(self, staticdata, dtime_s)
			core.after(10, function()
				local entity = self.object
				core.add_item(self.object:get_pos(), (self["_dorp"]))
				entity:remove()
			end)
		end,
	})
end

core.register_node("1042_smithing:campfire", {
	description = "Campfire",
	drawtype = "mesh",
	mesh = "campfire.obj",
	tiles = {
		"1042_plain_node.png^[colorize:#777777:200",
		"1042_plain_node.png^[colorize:#672307:200"
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
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.12, 0.5}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.12, 0.5}
	},

	on_construct = function(pos)
		core.add_entity(pos, "1042_smithing:campfire_fire", nil)
	end,
	
	on_destruct = function(pos)
		for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()
			if entity then
				if entity.name == "1042_smithing:campfire_fire" then
					entity.object:remove()
				end
			end
		end
	end,

	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = itemstack:get_name()
		if not name or name == "" then return end
		local has_hanging = false
		local has_side = 0
		local sides_used = {false, false, false, false}
		for object in core.objects_inside_radius(pos, 1) do
			local entity = object:get_luaentity()
			if entity then
				if string.find(entity.name, "1042_smithing:campfire_cooking_") then
					for i, thing in ipairs(cookable_things) do
						if "1042_smithing:campfire_cooking_" .. thing.name == entity.name then
							if thing.hanging then
								has_hanging = true
							else
								has_side = has_side+1
								if object:get_pos().x%1 == .25 and object:get_pos().z%1 == .25 then
									sides_used[1] = true
								elseif object:get_pos().x%1 == .25 and object:get_pos().z%1 == .75 then
									sides_used[2] = true
								elseif object:get_pos().z%1 == .25 then
									sides_used[3] = true
								else
									sides_used[4] = true
								end
							end
						end
					end
				end
			end
		end
		for i, thing in ipairs(cookable_things) do
			if name == thing.id then
				if (not has_hanging) and thing.hanging then
					itemstack:take_item()
					core.add_entity(pos, "1042_smithing:campfire_cooking_" .. thing.name, nil)
				elseif (not thing.hanging) and has_side < 4 then
					itemstack:take_item()
					moved_pos = {x = pos.x-.25+(.5*(has_side%2)), y = pos.y+.2, z = pos.z-.25+(.5*math.floor(has_side/2))}
					core.add_entity(moved_pos, "1042_smithing:campfire_cooking_" .. thing.name, nil)
				end
			end
		end
	end,

	groups = {burning = 1, stone = 1},
})
core.register_craft({
	output = "1042_smithing:campfire 1",
	type = "shapeless",
	recipe = {
		"1042_nodes:rock", "1042_nodes:rock", "1042_nodes:rock",
		"1042_nodes:sticks", "1042_nodes:sticks",
		"1042_nodes:flint",
	},
})


local path = core.get_modpath("1042_smithing")
dofile(path .. "/campfire/oven.lua")
dofile(path .. "/campfire/mold.lua")