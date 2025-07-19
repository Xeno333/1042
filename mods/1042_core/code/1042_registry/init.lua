registry_1042 = {
    items = {}
}

registry_1042.rarity = { -- rarity definition
    [1] = {name="Common", color="#aaa"},
    [2] = {name="Unusual", color="#3b3"},
    [3] = {name="Rare", color="#39b"},
    [4] = {name="Unique", color="#b33"},
    [5] = {name="Legendary", color="#cb3"},
    [6] = {name="Singular", color="#939"},
}

local function recipe_rarity(recipe)
    if recipe == nil then -- if there is no recipe default to base rarity
        return 1
    end

    r = 1
    c = 0
    for _, v in ipairs(recipe) do
        local count = 1
        s = v.split(" ") -- split the `item count` string into the respective pieces
        local ingredient = s[1]

        if s[2] ~= nil then
            count = count + tonumber(s[2])
        end

        local it = registry_1042.items[ingredient] or nil
        if it ~= nil and it.rarity ~= nil then
            r = r + tonumber(it.rarity) * count -- multiply by the defined rarity
        else
            r = r + 1 * count -- multiply by base rarity if none defined
        end
        c = c + count
    end
    local rarity = math.floor(r / c + 0.5) -- round the remainder of the division off to make it an integer (+0.5 to round up)
    return rarity
end

function registry_1042.register_item(name, def, rarity, recipe, loot)
    local ndef = {}
    for k, v in pairs(def) do
        ndef[k] = v -- add in all the definition key/value pairs
    end

    local r = nil
    if rarity ~= nil then -- if rarity defined, assign it
        r = rarity
    else
        r = recipe_rarity(recipe) -- otherwise try to get the rarity from the recipe
    end

    if recipe ~= nil then
        core_1042.crafting.register_craft({ -- if recipe defined then register it
            result = name,
            type = "1042_default",
            items = recipe
        })
    end

    registry_1042.items[name] = { -- add the item to the list so we can get rarity easily (could use the nodedef._rarity?)
        rarity = r
    }

    ndef._rarity = r or 1

    local rcolor = registry_1042.rarity[r].color
    local rlabel = registry_1042.rarity[r].name

    --local tx = ndef.inventory_image or ndef.tiles[0]
    ndef.inventory_overlay = "rarity.png^[colorize:" .. rcolor .. ":255" -- overlay the rarity visual
    core.log(ndef.inventory_overlay)
    ndef.description = ndef.description .. "\n" .. core.colorize(rcolor, rlabel)

    if def.item_type == "craftitem" then -- register it as a craftitem or node respectively
        core.register_craftitem(name, ndef)
    elseif def.item_type == "node" then
        core.register_node(name, ndef)
    end

    if loot ~= nil then core_1042.register_loot(loot) end
end

--[[
registry_1042.register_item("1042_core:test_0", {
    description = "Test thingy 0",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 1)

registry_1042.register_item("1042_core:test_1", {
    description = "Test thingy 1",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 2)

registry_1042.register_item("1042_core:test_2", {
    description = "Test thingy 2",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 3)

registry_1042.register_item("1042_core:test_3", {
    description = "Test thingy 3",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 4)

registry_1042.register_item("1042_core:test_4", {
    description = "Test thingy 4",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 5)

registry_1042.register_item("1042_core:test_5", {
    description = "Test thingy 5",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, 6)

registry_1042.register_item("1042_core:test_r", {
    description = "Test thingy R",
    inventory_image = "test_stick.png",
    item_type = "craftitem",
}, nil, {"1042_core:sticks 10"})
]]--