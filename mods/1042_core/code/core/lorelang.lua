core_1042.lorelang = {}

core_1042.lorelang.translations = { -- using hardcoded key based translation as a dynamic translator is not needed
    ["Stone"] = "Ctxn",
    ["Flint"] = "Kyn-Ctxn",
    ["Tree"] = "Rekte",
    ["Planks"] = "Reklyac",
    ["Leaves"] = "Lyfec",
    ["Turf"] = "Krec",
    ["Grass"] = "Kyn-Krec",
    ["Snow"] = "Slin",
    ["Rock"] = "Ral-Ctxn",
    ["Ore"] = "Ctxn", -- ores are translated as Iron Ore >> Iron Stone (Fero Ctxn)
    ["Sand"] = "Cond",
    ["Water"] = "Van",
    ["Ice"] = "Xc",
    ["Mushroom"] = "Srem",
    ["Axe"] = "Akc",
    ["Sword"] = "Len-Kyf",
    ["Chisel"] = "Bluf-Kyf",
    ["Pick"] = "Ctxn-Akc",
    ["Iron"] = "Fero",
    ["Gold"] = "Agra",
    ["Beryl"] = "Akuavan",
    ["Pork"] = "Svyn-Myt",
    ["Dirt"] = "Sola",
    ["Sapling"] = "Cen-Rekte",
    ["Shovel"] = "Sola-Kyf",
    ["Sky"] = "Valkar",
    ["Portal"] = "Hodre",
    ["Moss"] = "Ctxn-Krec",
    ["Bedrock"] = "Tuf-Ctxn",
    ["Chest"] = "Reklya-Beg",
    ["White"] = "Lec-Blok",
    ["Black"] = "Dec-Blok",
    ["Glass"] = "Clyt-Cond",
    ["Tilled"] = "Suf",
    ["Basalt"] = "Dec-Ctxn",
    ["Lava"] = "Laven-Ctxn",
    ["Molten"] = "Laven",
    ["Charcoal"] = "Fyren-Reklya",
    ["Burning"] = "Firy",
    ["Slag"] = "Plyke-Fyren",
    ["Nugget"] = "Ral",
    ["Short"] = "Cen",
    ["Tall"] = "Len",
    ["Light"] = "Lec",
    ["Dark"] = "Dec",
    ["Apple"] = "Rekte-Myt",
    ["Sunflower"] = "Flyr-Lyfe",
    ["Flowing"] = "Rusr",
    ["Lit"] = "Firy",
    ["Hanging"] = "Grypa",
    ["Fire"] = "Fira",
    ["Torch"] = "Firy Len-Reklya",
    ["Sticks"] = "Len-Reklya",
    ["Candle"] = "Tuf Kece-Myt",
    ["Campfire"] = "Ral-Fira",
    ["Oven"] = "Rokas-Fira",
    ["Mold"] = "Ctxn-Rokas",
    ["Cooked"] = "Ryfi",
    ["Raw"] = "Nat-Ryfi",
    ["Ingot"] = "Ryfi-Blok",
    ["Anvil"] = "Fero Kece-Blok",
    ["Crude"] = "Nat-Ryfi",
    ["Block"] = "Blok",
    ["Spyglass"] = "Len Clyt-Cond",
    ["with"] = "nyl"
}

core_1042.lorelang.translate = function(input)
    if not core.settings:get_bool("1042_lorelang", false) then
        return input
    end

    --local words = string.split(input, " ")
    local words = input:split(" ")

    local output = ""

    for _, v in pairs(words) do
        if v ~= nil and v ~= "" then
            local translation = core_1042.lorelang.translations[v]
            if translation == nil or translation == "" then
                output = output .. v .. " "
            else
                output = output .. translation .. " "
            end
        else
            output = output .. ""
        end
    end

    return output:gsub("%s*$", "")
end
