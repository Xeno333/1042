
-- Liquids

core.register_node("1042_nodes:water_source", {
    description = "Water Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "blend",
    
    paramtype = "light",
    paramtype2 = "none",
    light_source = 4,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,


    liquidtype = "source",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0xbb, b = 0xcc},
    groups = {water = 1, liquid = 1, cools = 1},

})

core.register_node("1042_nodes:water_flowing", {
    description = "Flowing Water",

    drawtype = "flowingliquid",
    tiles = {"1042_plain_node.png^[colorize:#00bbcc:144"},
    special_tiles = {
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#00bbcc:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "blend",

    paramtype = "light",
    paramtype2 = "flowingliquid",
    light_source = 4,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:water_flowing",
    liquid_alternative_source = "1042_nodes:water_source",

    drowning = 2,
    liquid_viscosity = 1,
    liquid_range = 5,
	waving = 3,

    post_effect_color = {a = 64, r = 0x00, g = 0xbb, b = 0xcc},
    groups = {water = 1, liquid = 1, cools = 1},
})






core.register_node("1042_nodes:lava_source", {
    description = "Lava Source",

    drawtype = "liquid",
    tiles = {
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "none",
    
    paramtype = "light",
    paramtype2 = "none",
    sunlight_propagates = true,
    light_source = 6,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,


    liquidtype = "source",
    liquid_alternative_flowing = "1042_nodes:lava_flowing",
    liquid_alternative_source = "1042_nodes:lava_source",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,
    damage_per_second = 10,

    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {lava = 1, liquid = 1},

})

core.register_node("1042_nodes:lava_flowing", {
    description = "Flowing Lava",

    drawtype = "flowingliquid",
    tiles = {"1042_plain_node.png^[colorize:#ff2200:144"},
    special_tiles = {
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = false,
		},
		{
			name = "1042_plain_node.png^[colorize:#ff2200:144",
			backface_culling = true,
		},
    },
	use_texture_alpha = "none",
    
    paramtype = "light",
    paramtype2 = "none",
    sunlight_propagates = true,
    light_source = 6,

    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,

    liquidtype = "flowing",
    liquid_alternative_flowing = "1042_nodes:lava_flowing",
    liquid_alternative_source = "1042_nodes:lava_source",

    drowning = 10,
    liquid_viscosity = 4,
    liquid_range = 4,
    damage_per_second = 10,

    post_effect_color = {a = 144, r = 0xff, g = 0x22, b = 0x00},
    groups = {lava = 1, liquid = 1},
})

core.register_abm({
    label = "Cool lava",
    nodenames = {"1042_nodes:lava_flowing", "1042_nodes:lava_source"},
    neighbors = {"group:cools"},
    interval = 1,
    chance = 1,
    catch_up = true,
    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "1042_nodes:basalt"})
    end
})