item_wear = {}

function item_wear.set_uses(itemstack, uses)
    itemstack:get_meta():set_int("item_uses", uses)
end



function item_wear.register_complex_node(name, def)
    def._item_wear_old_after_use = def.after_use -- save old function
    def._item_wear_uses = def.uses
    def.uses = nil

    def.after_use = function(itemstack, user, node, digparams)
        local meta = itemstack:get_meta()
        local uses = meta:get_int("item_uses")
        local defl = core.registered_items[itemstack:get_name()] or {}

        if uses == 0 then
            uses = (core.registered_items[itemstack:get_name()] or {})._item_wear_uses or 1
        end

        uses = uses - 1
        
        -- Color text to indicate uses
        local c = string.format("%02x", math.max(math.min(math.floor((1 - (uses / defl._item_wear_uses)) * 0xff), 0xff), 0))
        local c2 = string.format("%02x", math.max(math.min(math.floor(((uses / defl._item_wear_uses)) * 0xff), 0xff), 0))
        meta:set_string("count_meta", core.colorize("#" .. c .. c2 .. "00", uses))
        meta:set_int("count_alignment", 5)

        -- Color overlay method
        --local c = math.max(math.min(math.floor((1 - (uses / defl._item_wear_uses)) * 128), 128), 0)
        --meta:set_string("inventory_overlay", "1042_plain_node.png^[colorize:#ff0000:" .. c)

        if uses == 0 then
            if defl.sounds and defl.sounds.breaks then
                if user and user:is_player() then
                    core.sound_play(defl.sounds.breaks, {gain = 1.0, pitch = 1.0, loop = false, to_player = user:get_player_name()}, true)
                end
            end
            
            itemstack:take_item(1)
            return itemstack
        else
            meta:set_int("item_uses", uses)
        end

        if defl._item_wear_old_after_use then
            return defl._item_wear_old_after_use(itemstack, user, node, digparams)
        end
        
        return itemstack
    end

    core.register_node(name, def)
end