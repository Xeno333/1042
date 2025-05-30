
core_1042 = {
    version_release_to_string = {"", "-pre-release", "-dev"},
    version = {major = 0, minor = 3, patch = 0, release = 3},
    version_string = nil, -- string set at start time
    oldest_supported_version = {major = 0, minor = 3, patch = 0, release = 3},
    world_version = nil,
    world_version_string = nil, -- string set at start time

    core_path = core.get_modpath("1042_core"),

    info = core.get_game_info(),
    rand = PcgRandom(math.random(1, 2048)) -- Good for all random needed
}

core_1042.version_string = "1042 v" .. core_1042.version.major .. "." .. core_1042.version.minor .. "." .. core_1042.version.patch ..  core_1042.version_release_to_string[core_1042.version.release]

core_1042.shared_lib = {
    consts = {
        -- Later use these for automaticly creating dimensions from a base value
        plain_world_y_levels = {
            max = 512,
            min = -256,

            sea_level = 0,
            land_max = 128
        }
    }
}

function core_1042.get_core_mod_path(name)
    return core_1042.core_path .. "/code/" .. name
end