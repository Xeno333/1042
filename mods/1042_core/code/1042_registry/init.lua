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

function registry_1042.register_item(name, def, rarity, recipe)
    nname = "1042_core:" .. name -- names follow modname:itemname convention

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
            result = nname,
            type = "1042_default",
            items = recipe
        })
    end

    registry_1042.items[nname] = { -- add the item to the list so we can get rarity easily (could use the nodedef._rarity?)
        name = nname,
        rarity = r
    }

    ndef._rarity = r or 1

    rcolor = registry_1042.rarity[r].color
    rlabel = registry_1042.rarity[r].name

    tx = ndef.inventory_image or ndef.textures[1]
    ndef.inventory_image = tx .. "^(rarity.png^[colorize:" .. rcolor .. ":255)" -- TODO: Handle inventory images for nodes and models better
    core.log(ndef.inventory_image)
    ndef.description = ndef.description .. "\n" .. core.colorize(rcolor, rlabel)

    if def.item_type == "craftitem" then -- register it as a craftitem or node respectively
        core.register_craftitem(nname, ndef)
    elseif def.item_type == "node" then
        core.register_node(nname, ndef)
    end
end


--[[
registry_1042.register_item("test_0", {
    description = "Test thingy 0",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 1)

registry_1042.register_item("test_1", {
    description = "Test thingy 1",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 2)

registry_1042.register_item("test_2", {
    description = "Test thingy 2",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 3)

registry_1042.register_item("test_3", {
    description = "Test thingy 3",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 4)

registry_1042.register_item("test_4", {
    description = "Test thingy 4",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 5)

registry_1042.register_item("test_5", {
    description = "Test thingy 5",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, 6)

registry_1042.register_item("test_r", {
    description = "Test thingy R",
    textures = {"test_stick.png"},
    item_type = "craftitem",
}, nil, {"1042_core:sticks 10"})

]]--