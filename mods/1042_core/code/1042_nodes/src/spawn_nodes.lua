


local schem = schematics_1042.load_schematic(core_1042.info.path .. "/schematics/tower")
schematics_1042.register_schematic("1042_tower", schem)

core_1042.registry.register_material("1042_core:tower", {
    description = core_1042.lorelang.translate("Tower"),
    tiles = {"1042_bedrock.png"},

    _1042_schematic = "1042_tower",
    _1042_schematic_force = true,

    diggable = false,
    groups = {unbreakable = 1, structure_spawner = 1},

}, 6, nil, nil)

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