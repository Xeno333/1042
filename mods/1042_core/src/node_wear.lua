item_wear = {}

function item_wear.set_uses(itemstack, uses)
    itemstack:get_meta():set_int("item_uses", uses)
end



function item_wear.register_complex_node(name, def)
    def._item_wear_old_after_use = def.after_use
    def._item_wear_uses = def.uses
    def.uses = nil

    def.after_use = function(itemstack, user, node, digparams)
        local meta = itemstack:get_meta()
        local uses = meta:get_int("item_uses")
        local def = core.registered_items[itemstack:get_name()] or {}

        if uses == 0 then
            uses = (core.registered_items[itemstack:get_name()] or {})._item_wear_uses or 0
        else
            -- Add check for use type
            uses = uses - 1
            -- set color here
        end


        if uses == 0 then
            if def.sounds and def.sounds.breaks then
                if user and user:is_player() then
                    core.sound_play(def.sounds.breaks, {gain = 1.0, pitch = 1.0, loop = false, to_player = user:get_player_name()}, true)
                end
            end
            
            itemstack:take_item(1)
            return itemstack
        else
            meta:set_int("item_uses", uses)
        end

        if def._item_wear_old_after_use then
            return def._item_wear_old_after_use(itemstack, user, node, digparams)
        end
        
        return itemstack
    end

    core.register_node(name, def)
end