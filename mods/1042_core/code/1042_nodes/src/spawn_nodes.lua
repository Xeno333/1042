
core_1042.registry.register_material("1042_core:tower", {
    description = core_1042.lorelang.translate("Tower"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_tower",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

core_1042.registry.register_material("1042_core:fountain", {
    description = core_1042.lorelang.translate("Fountain"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_fountain",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

core_1042.registry.register_material("1042_core:monument", {
    description = core_1042.lorelang.translate("Monument"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_monument",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

core_1042.registry.register_material("1042_core:house", {
    description = core_1042.lorelang.translate("House"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_house",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

core_1042.registry.register_material("1042_core:firepit", {
    description = core_1042.lorelang.translate("Firepit"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_firepit",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

core_1042.phases.register_callback("startup", function()
    local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/house")
    schematics_1042.register_schematic("1042_house", schem)
    local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/firepit")
    schematics_1042.register_schematic("1042_firepit", schem)
    local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/monument")
    schematics_1042.register_schematic("1042_monument", schem)
    local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/fountain")
    schematics_1042.register_schematic("1042_fountain", schem)
    local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/tower")
    schematics_1042.register_schematic("1042_tower", schem)
end)

core.register_abm({
    label = "Spawn Structure",
    interval = 1,
    chance = 1,
    nodenames = {"group:structure_spawner"},

    action = function(pos, node, active_object_count, active_object_count_wider)
        core.set_node(pos, {name = "air"})
		local def = core.registered_items[node.name]
        local schematic = schematics_1042.get_schematic(def._1042_schematic)
        schematics_1042.place_schematic(pos, schematic, def._1042_schematic_force)
    end
})