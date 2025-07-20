core_1042.registry = {}

core_1042.registry.rarity = { -- rarity definition
    [1] = {name="Common", color="#aaa"},
    [2] = {name="Unusual", color="#3b3"},
    [3] = {name="Rare", color="#39b"},
    [4] = {name="Unique", color="#b33"},
    [5] = {name="Legendary", color="#cb3"},
    [6] = {name="Singular", color="#939"},
}

local registered_rare_items = {}

local function recipe_rarity(recipe, tbl)
    if recipe == nil then -- if there is no recipe default to base rarity
        return 1
    end

    local rarity = 0
    local c = 0
    if tbl then
        if #recipe == 0 then return 1 end

        for _, v in pairs(recipe) do
            rarity = rarity + recipe_rarity(v)
            c = c + 1
        end

        return math.min(math.floor(rarity / c + 0.5), #core_1042.registry.rarity)
    end

    local items = recipe.items or {recipe.node}

    for _, v in ipairs(items) do
        local is = ItemStack(v)
        local count = is:get_count()
        local ingredient = is:get_name()

        local it = core.registered_items[ingredient]
        if it and it._1042_rarity ~= nil then
            rarity = rarity + it._1042_rarity * count -- multiply by the defined rarity
        else
            rarity = rarity + recipe_rarity(core_1042.crafting.registered_crafts_results[ingredient], true) * count -- multiply by base rarity if none defined
        end
        c = c + count
    end

    return math.min(math.floor(rarity / c + 0.5), #core_1042.registry.rarity)
end


function core_1042.registry.register_material(name, def, rarity, recipe, loot)
    local ndef = {}
    for k, v in pairs(def) do
        ndef[k] = v -- add in all the definition key/value pairs
    end

    local rarity = rarity or recipe_rarity(recipe)

    if recipe then
        core_1042.crafting.register_craft(recipe)
    end
    if loot then
        core_1042.register_loot(loot)
    end

    ndef._1042_rarity = rarity

    registered_rare_items[name] = true

    local rcolor = core_1042.registry.rarity[rarity].color
    local rlabel = core_1042.registry.rarity[rarity].name

    ndef.inventory_overlay = "rarity.png^[colorize:" .. rcolor .. ":255" -- overlay the rarity visual
    ndef.description = ndef.description .. "\n" .. core.colorize(rcolor, rlabel)

    core.register_node(name, ndef)

end

core.register_on_mods_loaded(function()
    for name, def in pairs(core.registered_items) do
        if name ~= "" and not registered_rare_items[name] then
            local ndef = {
                description = def.description or "",
                inventory_overlay = def.inventory_overlay or ""
            }

            local rarity = def._1042_rarity

            -- Make rarity
            if not rarity then
                rarity = recipe_rarity(core_1042.crafting.registered_crafts_results[name], true)
                ndef._1042_rarity = rarity
            end

            local rcolor = core_1042.registry.rarity[rarity].color
            local rlabel = core_1042.registry.rarity[rarity].name

            if ndef.inventory_overlay ~= "" then ndef.inventory_overlay = ndef.inventory_overlay .. "^[overlay:" end
            ndef.inventory_overlay = ndef.inventory_overlay .. "rarity.png^[colorize:" .. rcolor .. ":255"

            if ndef.description ~= "" then ndef.description = ndef.description .. "\n" end
            ndef.description = ndef.description .. core.colorize(rcolor, rlabel)

            core.override_item(name, ndef, {})
        end
    end
end)