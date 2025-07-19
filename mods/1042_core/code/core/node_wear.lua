item_wear = {}

function item_wear.set_uses(itemstack, uses)
    itemstack:get_meta():set_int("item_uses", uses)
end

function item_wear.wear(itemstack, wear_to_apply)
    local meta = itemstack:get_meta()
    local uses = meta:get_int("_item_uses")
    local defl = core.registered_items[itemstack:get_name()] or {}

    if uses == 0 then
        uses = (core.registered_items[itemstack:get_name()] or {})._item_wear_uses or 1
    end

    uses = uses - wear_to_apply
    
    -- Color text to indicate uses
    local c = string.format("%02x", math.max(math.min(math.floor((1 - (uses / defl._item_wear_uses)) * 0xff), 0xff), 0))
    local c2 = string.format("%02x", math.max(math.min(math.floor(((uses / defl._item_wear_uses)) * 0xff), 0xff), 0))
    meta:set_string("count_meta", core.colorize("#" .. c .. c2 .. "00", uses))
    meta:set_int("count_alignment", 5)

    -- Color overlay method
    --local c = math.max(math.min(math.floor((1 - (uses / defl._item_wear_uses)) * 128), 128), 0)
    --meta:set_string("inventory_overlay", "1042_plain_node.png^[colorize:#ff0000:" .. c)

    if uses <= 0 then
        if defl.sounds and defl.sounds.breaks then
            if user and user:is_player() then -- TODO: there is no such 'user'?
                core.sound_play(defl.sounds.breaks, {gain = 1.0, pitch = 1.0, loop = false, to_player = user:get_player_name()}, true)
            end
        end
        
        itemstack:take_item(1)
        return itemstack
    else
        meta:set_int("_item_uses", uses)
    end

    return itemstack
end


function item_wear.register_complex_node(name, def)
    def._item_wear_old_after_use = def.after_use -- save old function
    def._item_wear_old_on_dig = def.on_dig -- save old function
    def._item_wear_old_after_place_node = def.after_place_node
    def._item_wear_uses = def.uses
    def.uses = nil



    def.after_use = function(itemstack, user, node, digparams)
        local defl = core.registered_items[itemstack:get_name()] or {}

        if defl._item_wear_old_after_use then
            itemstack = item_wear.wear(defl._item_wear_old_after_use(itemstack, user, node, digparams), 1)
        end

        return item_wear.wear(itemstack, 1)
    end

    def.after_place_node = function(pos, placer, itemstack, pointed_thing)
        local defl = core.registered_items[itemstack:get_name()] or {}

        local node_meta = core.get_meta(pos)
        node_meta:set_string("_itemstack", itemstack:to_string())

        if defl._item_wear_old_after_place_node then
            defl._item_wear_old_after_place_node(pos, placer, itemstack, pointed_thing)
        end
    end

    def.on_dig = function(pos, node, digger)
        local defl = core.registered_items[node.name] or {}

        if defl._item_wear_old_on_destruct then
            defl._item_wear_old_on_destruct(pos, node, digger)
        end

        local node_meta = core.get_meta(pos)
        local itemstack = ItemStack(node_meta:get_string("_itemstack"))

        core.set_node(pos, {name = "air"})
        player_api.add_item_to_player_inventory(digger, "main", itemstack, pos)
    end

    core.register_node(name, def)
end