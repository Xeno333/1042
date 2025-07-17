core.log("action", "Loading 1042_tools...")

tools_1042 = {}

local path = core_1042.get_core_mod_path("1042_tools")
dofile(path.."/src/chisel.lua")

local c = core.colorize

item_wear.register_complex_node("1042_core:sword",{
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

    uses = 300,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:sword"})

core_1042.crafting.register_craft({
    result = "1042_core:sword",
    type = "1042_default",
    items = {"1042_core:iron_ingot 2", "1042_core:sticks"}
})



item_wear.register_complex_node("1042_core:pick",{
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

    uses = 200,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:pick"})

core_1042.crafting.register_craft({
    result = "1042_core:pick",
    type = "1042_default",
    items = {"1042_core:iron_ingot 3", "1042_core:sticks 2"}
})




item_wear.register_complex_node("1042_core:axe_flint",{
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

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local node = core.get_node(pos).name
        local player_name = user:get_player_name()

        local rec = core_1042.crafting.registered_crafts["1042_chopping"][node]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 65,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

core_1042.crafting.register_craft({
    result = "1042_core:axe_flint",
    type = "1042_default",
    items = {"1042_core:flint 3", "1042_core:sticks 2"}
})






core.log("action", "1042_tools loaded.")