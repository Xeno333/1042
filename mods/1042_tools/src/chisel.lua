tools_1042.chisel = {
    registered_chisel_recipes = {}
}

local registered_chisel_recipes = tools_1042.chisel.registered_chisel_recipes


function tools_1042.chisel.register_chisel_recipes_from(from_node, recipe)
    if not registered_chisel_recipes[from_node] then
        registered_chisel_recipes[from_node] = {}
    end

    registered_chisel_recipes[from_node][#(registered_chisel_recipes[from_node]) + 1] = recipe
end



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

	core.show_formspec(player_name, "1042_tools:chisel_cuting", "size[10,10]bgcolor[#00000000]background[4,4;2,2;" .. chisel_data.cuting_formspec_image .. "^[verticalframe:4:" .. ((2*seconds)%2)+phase .. "]")
	
    if seconds == chisel_data.duration then
		local pos = core_1042.get_pointed_thing(player).under

        if chisel_data.place then
            if chisel_data.check then
                if chisel_data.check(pos) then
                    chisel_data.place(pos)
                    core.close_formspec(player_name, "1042_tools:chisel_cuting")
                    chiseling[player_name] = nil
                end

            elseif core.get_node(pos).name == node_being_chiseled then
                chisel_data.place(pos)
                core.close_formspec(player_name, "1042_tools:chisel_cuting")
                chiseling[player_name] = nil
            end

        elseif chisel_data.node and core.get_node(pos).name == node_being_chiseled then
			core.set_node(pos, chisel_data.node)
            core.close_formspec(player_name, "1042_tools:chisel_cuting")
            chiseling[player_name] = nil
        end

	else
		core.after(.5, function()
			chisel(chisel_data, player_name, seconds+.5, node_being_chiseled)
		end)
	end
end

core.register_on_player_receive_fields(function(player, formspec, fields)
    if formspec == "1042_tools:chisel_cuting" then
        if fields.quit then
            chiseling[player:get_player_name()] = nil
            return false
        end
    end
end)




-- #fixme Fix wear to go as delt
item_wear.register_complex_node("1042_tools:chisel_iron", {
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
	
	_1042_on_use = function(itemstack, user, pointed_thing)
        if not pointed_thing then return end
        local pos = pointed_thing.under
        local node_being_chiseled = core.get_node(pos).name
        local player_name = user:get_player_name()

        local rec = registered_chisel_recipes[node_being_chiseled]
        if not rec then return end

        for _, chisel_data in ipairs(rec) do
            -- #fixme add multi select here
            if chisel_data.check then
                if chisel_data.check(pos) then
                    itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration/2))
                    chiseling[player_name] = true
                    chisel(chisel_data, player_name, 0, node_being_chiseled)
                    break
                end

            else
                itemstack = item_wear.wear(itemstack, math.ceil(chisel_data.duration/2))
                chiseling[player_name] = true
                chisel(chisel_data, player_name, 0, node_being_chiseled)
                break
            end
        end

        return itemstack
	end
})




core_1042.register_loot({name = "1042_tools:chisel_iron"})
core.register_craft({
    output = "1042_tools:chisel_iron",
    recipe = {
        {"1042_nodes:crude_iron", "1042_nodes:sticks"}
    }
})
core.register_craft({
    output = "1042_tools:chisel_iron",
    recipe = {
        {"1042_nodes:iron_ingot", "1042_nodes:sticks"}
    }
})