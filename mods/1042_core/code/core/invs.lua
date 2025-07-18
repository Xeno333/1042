
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
core.after(0,function() -- use after to ensure compleate initalization
    local size = 0
    local lists = {core.registered_nodes, core.registered_items, core.registered_tools, core.registered_craftitems}

    local added = {}
    local items_to_reg = {}

    for _, list in pairs(lists) do
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
        return (a.short_description or a.description or a.name) < (b.short_description or b.description or b.name)
    end)
    
    table.sort(core_1042.all_registered_items, function(a, b)
        return (a.short_description or a.description or a.name) < (b.short_description or b.description or b.name)
    end)

    core_1042.creative_inv:set_size("main", size)
    for i, def in ipairs(items_to_reg) do
        local is = ItemStack(def.name)
        is:set_count(def.stack_max)
        core_1042.creative_inv:set_stack("main", i, is)
    end
end)



local table_of_crafts = {}

core_1042.phases.register_callback("startup_done", function()
    for _, recipe in pairs(core_1042.crafting.registered_crafts["1042_default"]) do
        local item_stacks = {}

        for _, stack in pairs(recipe.items) do
            if core.registered_items[stack] then
                local itemstack = ItemStack(stack)
                item_stacks[itemstack:get_name()] = (item_stacks[itemstack:get_name()] or 0) + itemstack:get_count()
            else
                item_stacks[stack] = (item_stacks[stack] or 0) + 1
            end
        end

        table_of_crafts[#table_of_crafts+1], _ = {recipe = recipe, output = recipe.result, req_items = item_stacks}
    end
end)






-- #fixme Add a part to return the replacements things from crafting and part that updates when there inv updates so only things they have items for show
function core_1042.update_player_crafts(player)
    --local inv = player:get_inventory()
    local craft_inv = core.get_inventory({type="detached", name=player:get_player_name() .. "_crafts"})

    craft_inv:set_size("main", #table_of_crafts)

    for i, craft in ipairs(table_of_crafts) do
        local item = ItemStack(craft.output)
        local meta = item:get_meta()
        local rec = ""

        meta:set_string("items_needed_to_craft", core.serialize(craft.req_items))

        for stack, c in pairs(craft.req_items) do
            local itemstack = ItemStack(stack)
            local itemstack_name = itemstack:get_name()

            local ingredient_name = itemstack_name
            if core.registered_items[itemstack_name] then ingredient_name = itemstack:get_short_description() end

            rec = rec  .. "\n" .. ingredient_name .. " x " .. c
        end

        meta:set_string("description", item:get_description() .. "\n" .. core.colorize("#00ff00", rec))

        craft_inv:set_stack("main", i, item)
    end
end





-- Triggers to update (for on updates to make achivement based but probably a bad idea)
--[[core.register_on_player_inventory_action(function(player, action, inventory, inventory_info)
    if ((action == "put" or action == "take") and inventory_info.listname == "main") or action == "move" then
        core_1042.update_player_crafts(player)
    end
end)
core.register_on_item_pickup(function(_, player)
    core_1042.update_player_crafts(player)
end)]]




-- Temp holder for a few strings of meta data while player crafts item
local swap_meta_data


core.register_on_joinplayer(function(player)
    local inv = player:get_inventory()
    inv:set_size("main", 40)

    local craft_inv = core.create_detached_inventory(player:get_player_name() .. "_crafts", {
        allow_move = function() return 0 end,
        allow_put = function() return 0 end,
        allow_take = function(orginv, orglistname, orgindex, stack, player)
            local inv = player:get_inventory()
            local items_needed_to_craft = core.deserialize(stack:get_meta():get_string("items_needed_to_craft") or "")
            local inv_list = inv:get_list("main")

            for item, count in pairs(items_needed_to_craft) do
                if item:find("^group:") ~= nil then
                    local parts = {}
                    for part in string.gmatch(item, "([^:, ]+)") do parts[#parts+1] = part end

                    local found = false
                    for _, is in pairs(inv_list) do
                        local raw_name = is:get_name()
                        if core.registered_items[raw_name] and (core.get_item_group(raw_name, parts[2]) or 0) ~= 0 then
                            if is:get_count() >= count then
                                found = true
                                break
                            end
                        end
                    end

                    if not found then
                        return 0
                    end
                elseif not inv:contains_item("main", ItemStack(item .. " " .. count)) then
                    return 0
                end
            end

            -- temp swap out of inv data so that it doesnt end up with meta on the stack for player
            local meta = stack:get_meta()
            swap_meta_data = {
                items_needed_to_craft = meta:get_string("items_needed_to_craft"),
                description = meta:get_string("description")
            }
            meta:set_string("items_needed_to_craft", "")
            meta:set_string("description", "")
            orginv:set_stack(orglistname, orgindex, stack)
            
            return -1
        end,

        on_take = function(orginv, orglistname, orgindex, stack, player)
            local inv = player:get_inventory()
            local items_needed_to_craft = core.deserialize(swap_meta_data.items_needed_to_craft or "")
            local inv_list = inv:get_list("main")

            for item, count in pairs(items_needed_to_craft) do
                if item:find("^group:") ~= nil then
                    local parts = {}
                    for part in string.gmatch(item, "([^:, ]+)") do parts[#parts+1] = part end

                    for _, is in pairs(inv_list) do
                        local raw_name = is:get_name()
                        if core.registered_items[raw_name] and (core.get_item_group(raw_name, parts[2]) or 0) ~= 0 then
                            if is:get_count() >= count then
                                local remove_it = ItemStack(is)
                                remove_it:set_count(count)
                                inv:remove_item("main", remove_it)
                                break
                            end
                        end
                    end
                else
                    inv:remove_item("main", ItemStack(item .. " " .. count))
                end
            end

            -- swap back of inv data so that it doesnt end up with meta on the stack for player
            local meta = stack:get_meta()
            meta:set_string("items_needed_to_craft", swap_meta_data.items_needed_to_craft)
            meta:set_string("description", swap_meta_data.description)
            orginv:set_stack(orglistname, orgindex, stack)
        end
    })

    craft_inv:set_size("main", 0)

    core_1042.update_player_crafts(player)
end)
