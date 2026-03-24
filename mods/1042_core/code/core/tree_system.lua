core_1042.trees = {
    registered_trees = {}
}

function core_1042.trees.register_tree(from_mod, def)
    local sep = ""
    local item_name = string.lower(def.name)
    local item_desc = core_1042.lorelang.translate(def.name)

    if def.name ~= "" then
        sep = " "
        item_name = "_" .. item_name
        item_desc = item_desc .. " "
    end

    def.leaves.description = item_desc .. core_1042.lorelang.translate("Leaves")
    def.tree.description = item_desc .. core_1042.lorelang.translate("Tree")
    def.planks.description = item_desc .. core_1042.lorelang.translate("Planks")
    

    core.register_node(":" .. from_mod .. ":tree" .. item_name, def.tree)
    core.register_node(":" .. from_mod .. ":leaves" .. item_name, def.leaves)
    core.register_node(":" .. from_mod .. ":planks" .. item_name, def.planks)

    -- WIP
    core.register_node(":" .. from_mod .. ":sapling" .. item_name, {
        description = item_desc .. core_1042.lorelang.translate("Sapling"),
        drawtype = "plantlike",
        --mesh = "sapling.obj",
        tiles = {"1042"..item_name.."_sapling.png"},
        use_texture_alpha = "clip",

        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        buildable_to = false,

        groups = {plant = 1, breakable_by_hand = 1},
    })

    core_1042.crafting.register_craft({
        result = from_mod .. ":planks" .. item_name,
        type = "1042_chopping",
        node = from_mod .. ":tree" .. item_name
    })

    core_1042.trees.registered_trees[#core_1042.trees.registered_trees+1] = {
        name = string.lower(def.name),
        grow_data = def.grow_data -- #fixme Add grow data functions etc
    }
end

