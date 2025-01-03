
core_1042.all_registered_items = {}




-- Trash
core_1042.void_inv = core.create_detached_inventory("void",
{
    allow_move = function() return 0 end,
    allow_put = function() return -1 end,
    allow_take = function() return 0 end,
})
core_1042.void_inv:set_size("main", 1)



-- Creative inv
core_1042.creative_inv = core.create_detached_inventory("creative",
{
    allow_move = function() return 0 end,
    allow_put = function() return 0 end,
    allow_take = function() return -1 end,
})


-- Generate the inv
core.register_on_mods_loaded(function()
    local size = 0
    local lists = {core.registered_nodes, core.registered_items, core.registered_tools, core.registered_craftitems}

    local added = {}
    local items_to_reg = {}

    for _, list in ipairs(lists) do
        for name, def in pairs(list) do
            if not added[name] then
                added[name] = true
                core_1042.all_registered_items[#core_1042.all_registered_items+1] = def -- Add to global refs list
                if not def.groups.not_in_creative_inventory then
                    size = size + 1
                    items_to_reg[#items_to_reg+1] = def -- Add to local for creative
                end
            end
        end
    end

    table.sort(items_to_reg, function(a, b)
        return a.name > b.name
    end)
    
    table.sort(core_1042.all_registered_items, function(a, b)
        return a.name > b.name
    end)

    core_1042.creative_inv:set_size("main", size)
    for i, def in ipairs(items_to_reg) do
        local is = ItemStack(def.name)
        is:set_count(def.stack_max)
        core_1042.creative_inv:set_stack("main", i, is)
    end
end)



-- #fixme Add a part to return the replacements things from crafting
function core_1042.update_player_crafts(player)
    local inv = player:get_inventory()
    local craft_inv = core.get_inventory({type="detached", name=player:get_player_name() .. "_crafts"})

    local table_of_crafts = {}

    for _, def in pairs(core_1042.all_registered_items) do
        if def.name and def.name ~= "" then
            local recipe = core.get_craft_recipe(def.name)

            if recipe and recipe.method == "normal" then
                local item_stacks = {}

                for _, stack in pairs(recipe.items) do
                    item_stacks[stack] = (item_stacks[stack] or 0) + 1
                end

                table_of_crafts[#table_of_crafts+1] = {recipe = recipe, output = core.get_craft_result(recipe), req_items = item_stacks}
            end
        end
    end

    craft_inv:set_size("main", #table_of_crafts)

    for i, craft in ipairs(table_of_crafts) do
        craft.output.item:get_meta():set_string("items_needed_to_craft", core.serialize(craft.req_items))
        craft_inv:set_stack("main", i, craft.output.item)
    end
end





-- Triggers to update
core.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
    if ((action == "put" or action == "take") and inventory_info.listname == "main") or action == "move" then
        core_1042.update_player_crafts(player)
    end
end)
core.register_on_item_pickup(function(_, player)
    core_1042.update_player_crafts(player)
end)





core.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size("main", 40)

    local craft_inv = core.create_detached_inventory(player:get_player_name() .. "_crafts", {
        allow_move = function() return 0 end,
        allow_put = function() return 0 end,
        allow_take = function(_, _, _, stack, player)
            local inv = player:get_inventory()
            local items_needed_to_craft = core.deserialize(stack:get_meta():get_string("items_needed_to_craft") or {})

            for item, count in pairs(items_needed_to_craft) do
                if not inv:contains_item("main", ItemStack(item .. " " .. count)) then
                    return 0
                end
            end
            
            return -1
        end,

        on_take = function(_, _, _, stack, player)
            local inv = player:get_inventory()
            local items_needed_to_craft = core.deserialize(stack:get_meta():get_string("items_needed_to_craft") or {})

            for item, count in pairs(items_needed_to_craft) do
                inv:remove_item("main", ItemStack(item .. " " .. count))
            end
        end
    })

    craft_inv:set_size("main", 0)

    core_1042.update_player_crafts(player)
end)
