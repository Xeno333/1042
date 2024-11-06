

core.register_node("1042_tools:sword",{
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

    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 4},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    damage_per_second = 128,

    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},
})