registry_1042 = {
    items = {}
}

registry_1042.rarity = {
    [0] = {name="Common", color="#aaa"},
    [1] = {name="Unusual", color="#3b3"},
    [2] = {name="Rare", color="33b"},
    [3] = {name="Singular", color="b33"},
    [4] = {name="Legendary", color="993"},
    [5] = {name="Unique", color="939"},
}

-- {"1042_core:iron_ingot 2", "1042_core:sticks}

local function recipe_rarity(recipe)
    if recipe == nil then
        return 0
    end
    r = 0
    c = 0
    for _, v in ipairs(recipe) do
        local count = 1
        s = v.split(" ")
        local ingredient = s[1]

        if s[2] ~= nil then
            count = count + tonumber(s[2])
        end

        local it = registry_1042.items[ingredient] or nil
        if it ~= nil and it.rarity ~= nil then
            r = r + tonumber(it.rarity) * count
        end
        c = c + count
    end
    local rarity = math.floor(r / c + 0.5)
    return rarity
end

function registry_1042.register_craftitem(name, def, rarity, recipe)
    nname = "1042_core:" .. name

    local ndef = {}
    for k, v in pairs(def) do
        ndef[k] = v
    end

    local r = nil
    if rarity ~= nil then
        r = rarity
    else
        r = recipe_rarity(recipe)
    end

    if recipe ~= nil then
        core_1042.crafting.register_craft({
            result = nname,
            type = "1042_default",
            items = recipe
        })
    end

    registry_1042.items[nname] = {
        name = nname,
        rarity = r
    }

    ndef._rarity = r or 0

    rcolor = registry_1042.rarity[r].color
    rlabel = registry_1042.rarity[r].name

    tx = ndef.inventory_image or ndef.textures[1]
    ndef.inventory_image = tx .. "^(rarity.png^[colorize:" .. rcolor .. ":255)"
    core.log(ndef.inventory_image)
    ndef.description = ndef.description .. "\n" .. core.colorize(rcolor, rlabel)

    core.register_craftitem(nname, ndef)
end

registry_1042.register_craftitem("test_0", {
    description = "Test thingy 0",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_1", {
    description = "Test thingy 1",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_2", {
    description = "Test thingy 2",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_3", {
    description = "Test thingy 3",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_4", {
    description = "Test thingy 4",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_5", {
    description = "Test thingy 5",
    textures = {"test_stick.png"}
}, 0)

registry_1042.register_craftitem("test_r", {
    description = "Test thingy R",
    textures = {"test_stick.png"}
}, nil, {"1042_core:sticks 10"})