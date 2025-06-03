-- Load other parts
local path = core_1042.get_core_mod_path("core") .. "/"

local files = {
    "phases.lua",
    "funcs.lua",
    "crafting.lua",
    "invs.lua",
    "tree_system.lua",
    "privs.lua",
    "chat_commands.lua",
    "node_wear.lua",
    "abms.lua",
    "item.lua",
}


for _, file in ipairs(files) do
    dofile(path .. file)
end

