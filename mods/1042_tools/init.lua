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






-- Chisel

local function chisel_cuting_formspec(chisel_data, player, seconds, node_being_chiseled)
	local phase = math.floor(seconds/(chisel_data.duration/2)) * 2
    local player_name = player:get_player_name()

	core.show_formspec(player_name, "1042_tools:chisel_cuting", "size[10,10]bgcolor[#00000000]background[4,4;2,2;" .. chisel_data.cuting_formspec_image .. "^[verticalframe:4:" .. ((2*seconds)%2)+phase .. "]")
	
    if seconds == chisel_data.duration then
		local pos = core_1042.get_pointed_thing(player).under

        if chisel_data.place then
            if chisel_data.check then
                if chisel_data.check(pos) then
                    chisel_data.place(pos)
                    core.close_formspec(player_name, "1042_tools:chisel_cuting")
                end
                
            elseif core.get_node(pos).name == node_being_chiseled then
                chisel_data.place(pos)
                core.close_formspec(player_name, "1042_tools:chisel_cuting")
            end

        elseif chisel_data.node and core.get_node(pos).name == node_being_chiseled then
			core.set_node(pos, chisel_data.node)
            core.close_formspec(player_name, "1042_tools:chisel_cuting")
        end

	else
		core.after(.5, function()
			chisel_cuting_formspec(chisel_data, player, seconds+.5, node_being_chiseled)
		end)
	end
end


item_wear.register_complex_node("1042_tools:chisel_iron", {
    description = "Iron chisel",
    drawtype = "mesh",
    mesh = "chisel.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#444444:168",
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

    uses = 65,
	
    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
	
	_1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local node_being_chiseled = core.get_node(pos).name
        local chisel_data = (core.registered_items[node_being_chiseled] or {})._1042_chisel_data
        if not chisel_data then return end

        if chisel_data.check then
            if chisel_data.check(pos) then
                itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration))
                chisel_cuting_formspec(chisel_data, user, 0, node_being_chiseled)
            end
        else
            itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration))
            chisel_cuting_formspec(chisel_data, user, 0, node_being_chiseled)
        end

        return itemstack
	end
})
core_1042.register_loot({name = "1042_tools:chisel_iron"})

core.register_craft({
    output = "1042_tools:chisel_iron",
    recipe = {
        {"1042_nodes:crude_iron", "1042_nodes:sticks"}
    }
})
core.register_craft({
    output = "1042_tools:chisel_iron",
    recipe = {
        {"1042_nodes:iron_ingot", "1042_nodes:sticks"}
    }
})





core.log("action", "1042_tools loaded.")