core_1042.crafting.register_craft_type("1042_chisel", function(def)
    if not core_1042.crafting.registered_crafts["1042_chisel"][def.node] then
        core_1042.crafting.registered_crafts["1042_chisel"][def.node] = {}
    end
    core_1042.crafting.registered_crafts["1042_chisel"][def.node][#core_1042.crafting.registered_crafts["1042_chisel"][def.node]+1] = def
end)


local chiseling = {}


-- Chisel

local function chisel(chisel_data, player_name, seconds, node_being_chiseled)    
    local player = core.get_player_by_name(player_name)
    if not player then
        chiseling[player_name] = nil
        return
    end

    if chiseling[player_name] == nil then return end

	local phase = math.floor(seconds/(chisel_data.duration/2)) * 2

	core.show_formspec(player_name, "1042_core:chisel_cuting", "size[10,10]bgcolor[#00000000]background[4,4;2,2;" .. chisel_data.cuting_formspec_image .. "^[verticalframe:4:" .. ((2*seconds)%2)+phase .. "]")
	
    if seconds >= chisel_data.duration then
		local pos = core_1042.get_pointed_thing(player).under

        if chisel_data.place then
            if chisel_data.check then
                if chisel_data.check(pos) then
                    chisel_data.place(pos)
                    core.close_formspec(player_name, "1042_core:chisel_cuting")
                    chiseling[player_name] = nil
                end

            elseif core.get_node(pos).name == node_being_chiseled then
                chisel_data.place(pos)
                core.close_formspec(player_name, "1042_core:chisel_cuting")
                chiseling[player_name] = nil
            end

        elseif chisel_data.result and core.get_node(pos).name == node_being_chiseled then
			core.set_node(pos, {name=chisel_data.result})
            core.close_formspec(player_name, "1042_core:chisel_cuting")
            chiseling[player_name] = nil
        end

	else
		core.after(.5, function()
			chisel(chisel_data, player_name, seconds+0.5, node_being_chiseled)
		end)
	end
end

core.register_on_player_receive_fields(function(player, formspec, fields)
    if formspec == "1042_core:chisel_cuting" then
        if fields.quit then
            chiseling[player:get_player_name()] = nil
            return false
        end
    end
end)


local chisel_job = {}

-- #fixme, add check for pointed thing
local function chisel_select_menu(player_name, change)
    local player = core.get_player_by_name(player_name)
    if player == nil then
        chisel_job[player_name] = nil
        return
    end


    if player:get_wielded_item():get_name() == "1042_core:chisel_iron" and player:get_player_control().dig then
        if change then
            player_api.update_hud(player, "chisel_select", {
                type = "inventory",
                position = {x=0.6, y=0.5},
                name = "chisel_select",
                scale = {x = 1, y = 1},
                text = "_1042_chisel_selected",
                number = 1
            })
        end

        if chisel_job[player_name] then
            chisel_job[player_name]:cancel()
        end
        chisel_job[player_name] = core.after(1, function()
            chisel_select_menu(player_name, false)
        end)

    else
        player_api.remove_hud(player, "chisel_select")
        chisel_job[player_name] = nil
    end
end


-- #fixme Fix wear to go as delt
item_wear.register_complex_node("1042_core:chisel_iron", {
    description = "Iron chisel",
    drawtype = "mesh",
    mesh = "chisel.obj",
    tiles = {
        "1042_plain_node.png^[colorize:#444444:168",
        "1042_plain_node.png^[colorize:#672307:168"
    },
    use_texture_alpha = "opaque",

    paramtype2 = "facedir",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = true,

    stack_max = 1,
    tool_capabilities = {
        full_punch_interval = 2,
        damage_groups = {fleshy = 1},
		groupcaps = {
			stone = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}, uses = 1},
		},
        punch_attack_uses = 1
    },
    wield_scale = {x = 1.5, y = 2, z = 1.5},

    uses = 500,
	
    groups = {weapon = 1, falling_node = 1, breakable_by_hand = 2},

    on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        if not pos then return end
    
        local node_being_chiseled = core.get_node(pos).name
        local rec = core_1042.crafting.registered_crafts["1042_chisel"][node_being_chiseled]
        if not rec then return end

        -- Sort out ones that can not be placed do to failure of complex check
        local valid_defs = {}
        for _, chisel_data in pairs(rec) do
            if chisel_data.check then
                if chisel_data.check(pos) then
                    valid_defs[#valid_defs+1] = chisel_data
                end

            else
                valid_defs[#valid_defs+1] = chisel_data
            end
        end
        if #valid_defs == 0 then return end -- Error


        local meta = itemstack:get_meta()
        local index = meta:get_int("chisel_index")

        -- Make sure in range and roll over
        if index >= #valid_defs then
            index = 1
        else
            index = index + 1 -- Makes sure its never 0
        end
        meta:set_int("chisel_index", index)

        local def = valid_defs[index]

    
        -- Put into the inv
        local inv = user:get_inventory()
        -- Handel errors if doesnt create
        if inv:get_size("_1042_chisel_selected") == 0 then
            if not inv:set_size("_1042_chisel_selected", 1) then
                return -- Error occored
            end
        end
        inv:set_stack("_1042_chisel_selected", 1, def.result)


        -- Show
        chisel_select_menu(user:get_player_name(), true)

        return itemstack
    end,

	_1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local node_being_chiseled = core.get_node(pos).name
        local player_name = user:get_player_name()

        local rec = core_1042.crafting.registered_crafts["1042_chisel"][node_being_chiseled]
        if not rec then return end

        -- Sort out ones that can not be placed do to failure of complex check
        local valid_defs = {}
        for _, chisel_data in pairs(rec) do
            if chisel_data.check then
                if chisel_data.check(pos) then
                    valid_defs[#valid_defs+1] = chisel_data
                end

            else
                valid_defs[#valid_defs+1] = chisel_data
            end
        end
        if not (#valid_defs > 0) then return end -- Error


        local meta = itemstack:get_meta()
        local index = meta:get_int("chisel_index")

        if index == 0 then index = 1 end -- Make sure never 0 from error

        -- Reset if overflow
        if index > #valid_defs then
            index = 1
        end


        local chisel_data = valid_defs[index]
        if chisel_data.check then
            if chisel_data.check(pos) then
                itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration/2))
                chiseling[player_name] = true
                chisel(chisel_data, player_name, 0, node_being_chiseled)
            end

        else
            itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration/2))
            chiseling[player_name] = true
            chisel(chisel_data, player_name, 0, node_being_chiseled)
        end

        return itemstack
	end
})




core_1042.register_loot({name = "1042_core:chisel_iron"})
core_1042.crafting.register_craft({
    result = "1042_core:chisel_iron",
    type = "1042_default",
    items = {
        "1042_core:crude_iron", "1042_core:sticks"
    }
})
core_1042.crafting.register_craft({
    result = "1042_core:chisel_iron",
    type = "1042_default",
    items = {
        "1042_core:iron_ingot", "1042_core:sticks"
    }
})