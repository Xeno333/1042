core.log("action", "Loading 1042_tools...")

tools_1042 = {}

local path = core_1042.get_core_mod_path("1042_tools")
dofile(path.."/src/chisel.lua")

local c = core.colorize

item_wear.register_complex_node("1042_core:sword_iron",{
    description = core_1042.lorelang.translate("Iron Sword"),
    drawtype = "mesh",
    mesh = "sword.obj",
    tiles = {"1042_iron_ingot.png"},
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
core_1042.register_loot({name = "1042_core:sword_iron"})

item_wear.register_complex_node("1042_core:sword_bronze",{
    description = core_1042.lorelang.translate("Bronze Sword"),
    drawtype = "mesh",
    mesh = "sword.obj",
    tiles = {"1042_bronze_ingot.png"},
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
			leafy = {times = {[1] = 0.3, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 200,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:sword_bronze"})

item_wear.register_complex_node("1042_core:sword_cobalt",{
    description = core_1042.lorelang.translate("Cobalt Sword"),
    drawtype = "mesh",
    mesh = "sword.obj",
    tiles = {"1042_cobalt_ingot.png"},
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
			leafy = {times = {[1] = 0.1, [2] = 0.125, [3] = 0.3, [4] = 0.5, [5] = 0.8, [6] = 1.5}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 400,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:sword_cobalt"})

item_wear.register_complex_node("1042_core:sword_titanium",{
    description = core_1042.lorelang.translate("Titanium Sword"),
    drawtype = "mesh",
    mesh = "sword.obj",
    tiles = {"1042_titanium_ingot.png"},
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
			leafy = {times = {[1] = 0.05, [2] = 0.1, [3] = 0.2, [4] = 0.3, [5] = 0.5, [6] = 1}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 500,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:sword_titanium"})

core_1042.crafting.register_craft({
    result = "1042_core:sword_bronze",
    type = "1042_default",
    items = {"1042_core:bronze_ingot 2", "1042_core:sticks"}
})

core_1042.crafting.register_craft({
    result = "1042_core:sword_iron",
    type = "1042_default",
    items = {"1042_core:iron_ingot 2", "1042_core:sticks"}
})

core_1042.crafting.register_craft({
    result = "1042_core:sword_cobalt",
    type = "1042_default",
    items = {"1042_core:cobalt_ingot 2", "1042_core:silver_ingot 1", "1042_core:sticks"}
})

core_1042.crafting.register_craft({
    result = "1042_core:sword_titanium",
    type = "1042_default",
    items = {"1042_core:titanium_ingot 2", "1042_core:steel_ingot 2", "1042_core:sticks"}
})

item_wear.register_complex_node("1042_core:pick_iron",{
    description = core_1042.lorelang.translate("Iron Pick"),
    drawtype = "mesh",
    mesh = "pick.obj",
    tiles = {
        "1042_tree.png",
        "1042_iron_ingot.png"
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
			stone = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 2},
            frozen = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 300,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:pick_iron"})

item_wear.register_complex_node("1042_core:pick_bronze",{
    description = core_1042.lorelang.translate("Bronze Pick"),
    drawtype = "mesh",
    mesh = "pick.obj",
    tiles = {
        "1042_tree.png",
        "1042_bronze_ingot.png"
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
			stone = {times = {[1] = 1.5, [2] = 3, [3] = 4, [4] = 5, [5] = 6}, uses = 2},
            frozen = {times = {[1] = 1.5, [2] = 3, [3] = 4, [4] = 5, [5] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 200,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:pick_bronze"})

item_wear.register_complex_node("1042_core:pick_steel",{
    description = core_1042.lorelang.translate("Steel Pick"),
    drawtype = "mesh",
    mesh = "pick.obj",
    tiles = {
        "1042_tree.png",
        "1042_steel_ingot.png"
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
			stone = {times = {[1] = 0.2, [2] = 0.5, [3] = 1.5, [4] = 3, [5] = 4, [6] = 5.5}, uses = 2},
            frozen = {times = {[1] = 0.2, [2] = 0.5, [3] = 1.5, [4] = 3, [5] = 4, [6] = 5.5}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 400,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:pick_steel"})

item_wear.register_complex_node("1042_core:pick_titanium",{
    description = core_1042.lorelang.translate("Titanium Pick"),
    drawtype = "mesh",
    mesh = "pick.obj",
    tiles = {
        "1042_tree.png",
        "1042_titanium_ingot.png"
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
			stone = {times = {[1] = 0.1, [2] = 0.25, [3] = 1, [4] = 2, [5] = 3.5, [6] = 4.5}, uses = 2},
            frozen = {times = {[1] = 0.1, [2] = 0.25, [3] = 1, [4] = 2, [5] = 3.5, [6] = 4.5}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 500,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})
core_1042.register_loot({name = "1042_core:pick_titanium"})

core_1042.crafting.register_craft({
    result = "1042_core:pick_bronze",
    type = "1042_default",
    items = {"1042_core:bronze_ingot 3", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:pick_iron",
    type = "1042_default",
    items = {"1042_core:iron_ingot 3", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:pick_steel",
    type = "1042_default",
    items = {"1042_core:steel_ingot 3", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:pick_titanium",
    type = "1042_default",
    items = {"1042_core:titanium_ingot 3", "1042_core:steel_ingot 2", "1042_core:sticks 2"}
})


item_wear.register_complex_node("1042_core:axe_flint",{
    description = core_1042.lorelang.translate("Flint Axe"),
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_tree.png",
        "1042_flint.png"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 3},
		groupcaps = {
			wood = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local rec = core_1042.crafting.registered_crafts["1042_chopping"][core.get_node(pos).name]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 100,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

item_wear.register_complex_node("1042_core:axe_iron",{
    description = core_1042.lorelang.translate("Iron Axe"),
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_tree.png",
        "1042_iron_ingot.png"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 4},
		groupcaps = {
			wood = {times = {[1] = 0.5, [2] = 1, [3] = 1.5, [4] = 2, [5] = 2.5, [6] = 3}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local rec = core_1042.crafting.registered_crafts["1042_chopping"][core.get_node(pos).name]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 300,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

item_wear.register_complex_node("1042_core:axe_cobalt",{
    description = core_1042.lorelang.translate("Cobalt Axe"),
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_tree.png",
        "1042_cobalt_ingot.png"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 4},
		groupcaps = {
			wood = {times = {[1] = 0.3, [2] = 0.4, [3] = 0.5, [4] = 0.8, [5] = 1, [6] = 2}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local rec = core_1042.crafting.registered_crafts["1042_chopping"][core.get_node(pos).name]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 400,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

item_wear.register_complex_node("1042_core:axe_titanium",{
    description = core_1042.lorelang.translate("Titanium Axe"),
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_tree.png",
        "1042_titanium_ingot.png"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 4},
		groupcaps = {
			wood = {times = {[1] = 0.1, [2] = 0.2, [3] = 0.3, [4] = 0.5, [5] = 0.8, [6] = 1}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local rec = core_1042.crafting.registered_crafts["1042_chopping"][core.get_node(pos).name]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 500,

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

core_1042.crafting.register_craft({
    result = "1042_core:axe_iron",
    type = "1042_default",
    items = {"1042_core:iron_ingot 2", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:axe_flint",
    type = "1042_default",
    items = {"1042_core:flint 3", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:axe_cobalt",
    type = "1042_default",
    items = {"1042_core:cobalt 3", "1042_core:silver 1", "1042_core:sticks 2"}
})

core_1042.crafting.register_craft({
    result = "1042_core:axe_titanium",
    type = "1042_default",
    items = {"1042_core:titanium 3", "1042_core:steel 2", "1042_core:sticks 2"}
})


item_wear.register_complex_node("1042_core:shovel_iron",{
    description = core_1042.lorelang.translate("Iron Shovel"),
    drawtype = "mesh",
    mesh = "axe.obj",
    tiles = {
        "1042_tree.png",
        "1042_iron_ingot.png"
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
			wood = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    _1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local rec = core_1042.crafting.registered_crafts["1042_tilling"][core.get_node(pos).name]
        if not rec then return end

        core.set_node(pos, {name = rec.result})

        return item_wear.wear(itemstack, 1)
    end,

    uses = 256,

    damage_per_second = 1,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})

core_1042.crafting.register_craft({
    result = "1042_core:shovel_iron",
    type = "1042_default",
    items = {"1042_core:iron_ingot", "1042_core:sticks 2"}
})


core.log("action", "1042_tools loaded.")