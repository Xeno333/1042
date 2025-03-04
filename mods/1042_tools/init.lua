core.log("action", "Loading 1042_tools...")


item_wear.register_complex_node("1042_tools:sword",{
    description = "Sword",
    drawtype = "mesh",
    mesh = "sword.obj",
    tiles = {"1042_plain_node.png^[colorize:#444444:168"},
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    selection_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 2, 0.3},
        },
    },
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.3, -0.3, -0.3, 0.3, 2, 0.3},
        },
    },

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 1,
        damage_groups = {fleshy = 3},
		groupcaps = {
			leafy = {times = {[1] = 0.125, [2] = 0.25, [3] = 0.5, [4] = 1, [5] = 1.5, [6] = 2}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 150,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_tools:sword"})

core.register_craft({
    output = "1042_tools:sword",
    recipe = {
        {"", "1042_nodes:iron_ingot", ""},
        {"", "1042_nodes:iron_ingot", ""},
        {"", "1042_nodes:sticks", ""},
    }
})



item_wear.register_complex_node("1042_tools:pick",{
    description = "Pick",
    drawtype = "mesh",
    mesh = "pick.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#672307:168",
        "1042_plain_node.png^[colorize:#444444:168"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 1},
		groupcaps = {
			stone = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
            frozen = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 100,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_tools:pick"})

core.register_craft({
    output = "1042_tools:pick",
    recipe = {
        {"1042_nodes:iron_ingot", "1042_nodes:iron_ingot", "1042_nodes:iron_ingot"},
        {"", "1042_nodes:sticks", ""},
        {"", "1042_nodes:sticks", ""},
    }
})




item_wear.register_complex_node("1042_tools:axe_flint",{
    description = "Flint axe",
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#672307:168",
        "1042_plain_node.png^[colorize:#07070d:168"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 4,
        damage_groups = {fleshy = 4},
		groupcaps = {
			wood = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 25,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

core.register_craft({
    output = "1042_tools:axe_flint",
    recipe = {
        {"1042_nodes:flint", "1042_nodes:flint", "1042_nodes:flint"},
        {"", "1042_nodes:sticks", ""},
        {"", "1042_nodes:sticks", ""},
    }
})



chiselable_nodes = {
	{
		check = function(pos)
			return (core.get_node(pos).name == "1042_nodes:stone" and core.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "1042_nodes:stone")
		end,
		place = function(pos)
			core.set_node(pos, {name="1042_smithing:stone_oven_off"})
			core.set_node({x = pos.x, y = pos.y+1, z = pos.z}, {name="air"})
		end,
		node = "1042_smithing:stone_oven_off",
		display_name = "Oven",
		cuting_formspec_image = "1042_chiseling_stone_oven",
		duration = 16
	}, {
		check = function(pos)
			return core.get_node(pos).name == "1042_nodes:rock"
		end,
		place = function(pos)
			core.set_node(pos, {name="1042_smithing:mold_empty"})
		end,
		node = "1042_smithing:mold_empty",
		display_name = "Mold",
		cuting_formspec_image = "1042_chiseling_mold",
		duration = 8
	}
}



core.register_node("1042_tools:chisel_flint", {
    description = "Flint chisel",
    drawtype = "mesh",
    mesh = "chisel.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#07070d:168",
        "1042_plain_node.png^[colorize:#672307:168"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 1},
		groupcaps = {
			stone = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 100,

    damage_per_second = 64,
	
    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
	
	on_place = function(itemstack, user, pointed_thing)
		formspec = "size[8,8]label[0,0;Select a construction:]"
		local view_index = 0
		for i, node in ipairs(chiselable_nodes) do
			if node.check(pointed_thing.under) then
				view_index = view_index+1
				formspec = formspec .. "item_image_button[" .. .5+(2.5*((view_index-1)%3)) .. "," .. .5+(2.5*math.floor((view_index-1)/3)) .. ";2,2;" ..
						node.node .. ";" .. node.node .. ";" .. node.display_name .. "]"
			end
		end
		formspec = formspec .. "]image_button_exit[" .. .5+(2.5*(view_index%3)) .. "," .. .5+(2.5*math.floor(view_index/3)) .. ";2,2;cross.png;close;Cancel]"
		core.show_formspec(user:get_player_name(), "1042_tools:chisel_select", formspec)
	end
})
core_1042.register_loot({name = "1042_tools:chisel_flint"})

core.register_craft({
    output = "1042_tools:chisel_flint",
    recipe = {
        {"1042_nodes:flint", "1042_nodes:sticks"}
    }
})

function chisel_cuting_formspec(node, player, seconds)
	local phase = math.floor(seconds/(node.duration/2)) * 2
	core.show_formspec(player:get_player_name(), "1042_tools:chisel_cuting", "size[10,10]bgcolor[#00000000]background[4,4;2,2;" .. node.cuting_formspec_image .. ".png^[verticalframe:4:" .. ((2*seconds)%2)+phase .. "]")
	if seconds == node.duration then
		local pos = core_1042.get_pointed_thing(player).under
		if node.check(pos) then
			node.place(pos)
			core.close_formspec(player:get_player_name(), "1042_tools:chisel_cuting")
		end
	else
		core.after(.5, function()
			chisel_cuting_formspec(node, player, seconds+.5)
		end)
	end
end

core.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "1042_tools:chisel_select" and fields["quit"] ~= "true" then
		for k, v in pairs(fields) do -- Should only contains 1 item
			for i, node in ipairs(chiselable_nodes) do
				if node.node == k then
					chisel_cuting_formspec(node, player, 0)
				end
			end
		end
	end
end)

core.log("action", "1042_tools loaded.")