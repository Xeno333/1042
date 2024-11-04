-- api.lua

--[[
--  This is in dev, this is not used yet.
]]

--[[
    Biome Definitions
    {
        temp = {
            min = <i>,
            max = <i>
        },
        y_lvl = {
            min = <i>,
            max = <i>
        },
        turf = <turf>,
        stone = <stone>,
        dirt = <dirt>,
        water = <water>,
        top_water = <top water>
    }
]]

--[[
    Deceration Definitions
    {
        type = <"schematic"/"node">,
        deceration = <deceration>,
        chance = <i>
    }
]]


mapgen_1042.api = {}

mapgen_1042.biomes = {}
mapgen_1042.decerations = {}




function mapgen_1042.api.register_biome(name, def)
    if def and not mapgen_1042.biomes[name] then
        mapgen_1042.biomes[name] = def
        mapgen_1042.decerations[name] = {}
        return true
    end

    return false
end


function mapgen_1042.api.register_deceration(biome, def)
    if def and not mapgen_1042.decerations[biome] then
        mapgen_1042.decerations[biome][#mapgen_1042.decerations[biome]+1] = def
        return true
    end

    return false
end


