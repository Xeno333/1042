core_1042.trees = {
    registered_trees = {}
}


function core_1042.trees.register_tree(from_mod, def)
    local sep = ""
    local item_name = string.lower(def.name)
    local item_desc = def.name

    if def.name ~= "" then
        sep = " "
        item_name = "_" .. item_name
        item_desc = item_desc .. " "
    end

    def.leaves.description = item_desc .. "Leaves"
    def.tree.description = item_desc.. "Tree"

    core.register_node(":" .. from_mod .. ":tree" .. item_name, def.tree)

    core.register_node(":" .. from_mod .. ":leaves" .. item_name, def.leaves)

    -- WIP
    core.register_node(":" .. from_mod .. ":sapling" .. item_name, {
        description = item_desc .. "Sapling",
        drawtype = "mesh",
        mesh = "sapling.obj",
        tiles = {
            def.leaves.tiles[1],
            def.tree.tiles[1]
        },
        use_texture_alpha = "opaque",

        paramtype = "light",
        sunlight_propagates = true,
        walkable = true,
        buildable_to = false,

        groups = {plant = 1, breakable_by_hand = 1},
    })

    core_1042.trees.registered_trees[#core_1042.trees.registered_trees+1] = {
        name = string.lower(def.name),
        grow_data = def.grow_data -- #fixme Add grow data functions etc
    }
end



function core_1042.trees.grow_tree()
end
