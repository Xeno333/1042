core.log("action", "Loading 1042_tools...")

tools_1042 = {}

local path = core.get_modpath("1042_tools")
dofile(path.."/src/chisel.lua")

local c = core.colorize

item_wear.register_complex_node("1042_tools:sword",{
    description = "Len-Kyf"..c("#777", "\n(Sword)"),
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

    uses = 300,

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
    description = "Ctxn-Kyf"..c("#777", "\n(Pick)"),
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

    uses = 200,

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
    description = "Sare-Ctxn Akce"..c("#777", "\n(Flint Axe)"),
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

    uses = 65,

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






core.log("action", "1042_tools loaded.")