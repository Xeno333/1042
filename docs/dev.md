# **Documentation of 1042 for development and modding**

This is documentation for development and modding for the game `1042` on the *Luanti* game engine.


## Table of contents

> [Core interface](#core-interface)\
> [Groups](#groups)
> [Node definition fields](#node-definition-fields)\
> [`core_1042` APIs](#core_1042-apis)\
> [Cooking API(s) (`1042_cooking`) (WIP)](#cooking-apis-1042_cooking-wip)\
> [Chiseling API (WIP)](#chiseling-api-wip)\
> [Weather API](#weather-api)\
> [Intigrated Testing Mod](#intigrated-testing-mod)\
> [Privs](#privs)\
> [Development](#development)



# Core interface

## `core_1042` is the namespace for all core_1042 functions

- `core_1042.eat(itemstack, user, food_value, p_chance)` This removes one item from itemstack from the player `user` and adds `value` to `user`'s HP, `p_chance` is chance of taking damage of 2 times `food_value` while eating item.
- `core_1042.read_file(filename)` Read a file and return its contense as a string. Returns `nil` if no data is read.
- `core_1042.get_pointed_thing(player)` Gets player pointed thing, in form of raycast.
- `core_1042.set(key, value)` Sets a game stored value to key.
- `core_1042.get(value)` Gets a game stored value from key.
- `core_1042.info` Game info table.
- `core_1042.rand` Core random a `PcgRandom(math.random(1, 2048))` object. This can be used by anything.
- `core_1042.register_loot(def)` Register loot as defined by `Loot table`
- `core_1042.get_loot()` Returns a random `ItemStack` from the loot that is registered.

### `core_1042` Data fields (Read Only)

- `version_release_to_string` Mapped table for converting `<version table>.release` to a string.
- `version` Current 1042 version. Format: `{major = <number>, minor = <number>, patch = <number>, release = <number>}`. `release` uses the format mapped in `version_release_to_string`.
- `version_string` Readable formated string form of `version`.
- `oldest_supported_version` Last suported version in same format, dev is older than release.
- `world_version` Version of world  in same format.
- `world_version_string` Readable formated string form of `world_version`.
- `info` Result of `core.get_game_info()`.
- `rand` Result of `PcgRandom(math.random(1, 2048))`. May be used for all true randoms.


## `core_1042.shared_lib` is a library that can be loaded into any place with `dofile(core.get_modpath("1042_core").."/src/shared_lib.lua")` if it isnt already loaded (it should be)

```lua 
core_1042.shared_lib = {
	consts = {
		plain_world_y_levels = {
			max = 128,
			min = -256
		}
	}
}
```


## 1042 extensions of `PlayerHPChangeReason`

- `_1042_death_msg` 1042 death message, if it causes or can cause death. **Note:** Prepends `You ` to message.
- `_1042_reason` 1042 reason of death.



## Tables

### `Loot table`

```lua
{
	name = <name>,
	max_count = <maxcount>
}
```




## Groups

- `breakable_by_hand` Player can break these items without tools. value is for break-time `{[1] = 0.1, [2] = 0.25, [3] = 0.5, [4] = 1, [5] = 2, [6] = 3, [7] = 4}`
- `stone` Stone nodes. Value is for tools like pick, for break-time. `{[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}`
- `leafy` Leafy nodes.
- `plant` Plant (Biomass) nodes.
- `wood` Wood nodes. Value is for tools like axe, for break-time. `{[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}`
- `cools` Nodes that cool hot nodes.
- `burning` For burning/hot nodes.
- `burns` Nodes that can catch on fire. Value is chance from `1` to `<group value>` chance of burning.
- `molten` Uses `_1042_cools_to` for node.
- `melts` Uses `_1042_melts_to` for node.
- `cooks` Uses `_1042_cooks_to` for node. Value is chance from 1 to `<group value>` of cooking per check.
- `biomass` Amount of biomass this node contains, values: 1-255. WARNING: This is WIP and is subject to change.
- `growth_bio_mass` Amount of biomass required to support its spreading, values: 1-255. WARNING: This is WIP and is subject to change.
- `growth` Is part of the growth ABM and will spread based on the growth type. Value of 1 means it uses fungal growth paterns. WARNING: This is WIP and is subject to change.





# Node definition fields

There are a few new node definition fields for ABMs and such:

- `_1042_cools_to = <node>` Node cools to given node.
- `_1042_melts_to = <node>` Node melts to given node.
- `_1042_cooks_to = <node>` Node cooks to given node.


## Callbacks
- `_1042_on_use = function(itemstack, player, pointed_thing)` on_use but for aux1. Uses `raycast` object.






# `core_1042` APIs

There are a few APIs built into the game, and more planned for the beta release.



## `item_wear` API

This is an API for complex nodes/items that have wear, these are basicly tools of node types.

### Functions (WIP)

- `item_wear.set_uses(itemstack, uses)` Returns the itemstack with `uses` aplied to its wear. **WARNING:** `uses = 0` is undefined.
- `item_wear.wear(itemstack, wear_to_apply)` Returns the itemstack with `wear_to_apply` uses aplied to it, if it breaks it removes and returns `ItemStack("")`.
- `item_wear.register_complex_node(name, def)` Registers a node as a complex node (tool-like). **Note:** This may be changed to `register_complex_tool` in version v0.3-beta, but this is not definent yet. If it is changed later it will be kept until v0.4 with a depricated status and be a refrence.





## Crafting API (`core_1042.crafting`)

The crafting system 1042 has is fully custom and does not depend on the luanti crafting system. It allows for custom types and mod specific usage.

### Functions

- `core_1042.crafting.default_register_craft(def)` This is the default craft registration and just appends the craft to the list of this type's crafting recipeis. 
- `core_1042.crafting.register_craft(def)` Register a craft recipe.
- `core_1042.crafting.register_craft_type(type_name, reg_craft_func(def))` This registers a craft type with a custom function to handel it. The functions should add its data in the mods own format to `core_1042.crafting.registered_crafts_results[<type>]`, but not `core_1042.crafting.registered_crafts_results`.

### Tables

```lua
core_1042.crafting = {
    registered_crafts = {}, -- Sorted by type tables and then subsorted by mod that uses it. Non-game spesific and can be in any format, i.e. the mods internal format.
    registered_crafts_results = {}, -- Indexed by result with value being a table of recipies, can be used for crafting guid.
}
```



## Player API

### Functions

- `player_api.add_item_to_player_inventory(player, list, itemstack, drop_overflow_pos)` Add itemstack to player inv and drop remains, returns count droped at `drop_overflow_pos`. If player is not a player node the itemstack is just dropped.

#### Player HUD Functions

These functions clean up automaticly, and provide a clean interface.

- `player_api.add_hud(player, unique_hud_name, hud_def)` Add a HUD to a player, returns `true` if it was added, and `false` if it already exits.
- `player_api.remove_hud(player, unique_hud_name)` Remove a HUD to a player, returns `true` if it was removed, and `false` if it didn't exits.
- `player_api.update_hud(player, unique_hud_name, hud_def)` Add/Update(remove and add) a HUD without respecting pervious definition. Always returns `true` and should always be ignored.
- `player_api.hud_exists(player, unique_hud_name)` Check if a HUD exits for player.
- `player_api.get_hud_id(player, unique_hud_name)` Get a HUD id. Returns `false` on fail.



## Tree API

This API allows for registering trees.

- `core_1042.trees.register_tree(from_mod, def)` This registers a tree and the nodes related to it.

The definition of a tree is as follows:

```lua
tree_def = {
    name = "", -- Name of tree type/class it will end with ' Tree'/' Leaves'/' Sapling'/' Planks' unless name = "" like here the space is stripped.
    
    tree = { -- Tree trunk node def without description.
        tiles = {"1042_plain_node.png^[colorize:#672307:200"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 1
            }
        },
    
        groups = {wood = 1, plant = 1, burns = 3},
    },
    leaves = { -- Tree leaves def without description.
        tiles = {"1042_plain_node.png^[colorize:#1c770a:168"},
        use_texture_alpha = "blend",
        drawtype = "allfaces",
        
        paramtype = "light",
        sunlight_propagates = true,
    
        groups = {leafy = 1, plant = 1, breakable_by_hand = 1, burns = 1},
    },
    Planks = { -- Tree planks def without description.
        tiles = {"1042_plain_node.png^[colorize:#672307:128"},
        use_texture_alpha = "opaque",
    
        sounds = {
            dig = {
                name = "tree_dig",
                gain = 2,
                pitch = 1
            }
        },
    
        groups = {wood = 1, plant = 1, burns = 3},
    }
}
```


## Function Callback Phases (WIP) `core_1042.phases`

Function callback phases are callbacks called at points in runtime. Some are called durring start up so that mods can have fixed start times.

### Registration

- `core_1042.phases.register_callback(phase, func)` Register a callback to run in specified phase.

### On mods loaded (`core.on_mods_loaded(func())`)

- `"complex_registration"` Called right after all mods are loaded, used to make entities or extened forms of some nodes (stairs, etc.).
- `"startup"` Called at durring start up in the same `on_mods_loaded` as `"complex_registration"` but right after.

### Server startup compleated (`core.after(0, func())`)
- `"startup_done"` Called right after server startup compleated.
- `"tests"` Testing time.







# Achievement API `achievements_1042`

`achievements_1042` is the mod that contains the API for achievements, along with some core achievements.

### Functions

- `achievements_1042.achieve(player, achievement_name)` Returns `nil` if the achievement does not exist, `false` if the player already has it, and `true` if the achievement is shown to the player.
- `achievements_1042.register_achievement(achievement_name, achievement_definition)` Register an achievement, returns `false` if already registered, `true` otherwise.

### Exposed tables

- `achievements_1042.achievements` All registered achievements.

### Achievement definition

```lua
{
	achievement = core.colorize("#ffffff", "First life"),
	colour = "#00ffaa"
}
```

### Core achievements

- `first_life` This is the achievement for first spawn of a player.
- `smelter` This is the achievement for first ingot broken. *With 1042_nodes*






# Cooking API(s) (`1042_cooking`) (WIP)

To add cookable items, it's depends on the method to be used.

### Campfire (WIP)

Campfire is used for things that cooks at low temperature *(< 200 °C)*, like foods. On a campfire, an item can be cooked either above or on the side of the fire. Nodes that are cookable with a campfire use the `_1042_campfire_cooks` field with the following table:

```lua
_1042_campfire_cooks = {
	hanging = true, -- If the item is cooked above (true) or on the side (false) of the campfire.
	name = "", -- Tn unique name/identifier found at the end of the entity name.
	drop = "", -- The name of the cooked item.
	model = "", -- The model of the entity while cooking.
	textures = {} -- The list of the textures of the entity.
}
```

### Oven (WIP)

Oven is used for things that cooks at (very)high temperature *(> 1000 °C)*, like iron. To be cooked on an oven, the item must first be placed in a mold. Molds are registed for all items with the `_1042_moldable` field in the item definition.

#### `_1042_moldable` format:

```lua
_1042_moldable = {
	color = "", -- ColorString for the item in the mold.
	name = "", -- An unique identifier found at the end of the entity name.
	drop = "" -- The itemstring of the cooked item.
}
```








# Chiseling API (WIP)

The chisel is used to create some complex nodes, *like oven or molds*, from more basic one, *like stone or rocks*. Register a chisel recipe from the node `from_node`. Register it with a type of `"1042_chisel"` with `core_1042.crafting.register_craft(def)`.

#### Chisel recipie definition format:

```lua
{
	type = "1042_chisel",
	result = "<itemstring>", -- Itemstring of items to be placed when done chiseling.

	node = "<itemstring>", -- Itemstring of node that will be chiseled
	check = function(pos), -- **Optional** Returns a condition to test if the node at 'pos' can be chiseled. Only use this if you need a complex check, defaults to a simple check if node is there.
	place = function(pos), -- **Optional** Complex placement, only use if you need complex placement.

	cuting_formspec_image = "<image>", -- Waiting formspec image made of 4 different images to create 2 tow-frames animations.
	duration = <number> -- Time, in seconds, to finish the chiseling.
}
```








# Weather API

Weathers are registered by appending to the end of `weather.weathers` with a weather definition. Tempetures across the map vary in range of ~-30 to ~30, though they may be slightly above or below these.


## Weather API

The weather API is avalible in both the async mapgen enviorment and main via import from file (as done in mapgen.) Temps can be from -10 C to 30 C.

-`function weather.get_temp_map(x, z)` Get a temp map starting at `x, z`. The map is a mapblock, thus 80x80.
-`function weather.get_temp(pos, temp_map)` Get temp from temp map with coords on that temp map.
-`function weather.get_temp_single(pos)` Get temp at a position, this is faster than using the other two for single coords.
- `weather.rand` A `PcgRandom` object.
- `weather.get_biome_palette_index(temp)` Returns the index in a palette conforming to the biome color palette format from a tempeture.


## Weathers API

Present if `weather.is_loaded` is set to `true`.

### Functions and talbes

- `weather.players_weather` A table of player weather data, index with player name.
- `weather.weathers` All registered weather definitions.
- `weather.default_on_change(player, name, players_weather)` Default `on_change` call back, called between every change to try to clean up.
- `weather.register_weather(def)` Regsiter a `Weather Definition`. Note: If a on_change sets a sound it must store the handle for it in `players_weather.sound_handle` before returning. This should not modify sky paramiters other than using: `player:set_sun()`, `player:set_clouds()`, `player:set_sky()` and `player:set_lighting()`. For more info see `on_change` usage down further.
- `weather.get_weather_at_pos(pos)` Return the index to weather in `weather.weathers` that matches the current global weather and local weather.
- `weather.weather_hight` Hight of spawning for weather particles.

## Weather Definition

```lua
	{
		name = "Light snow",
		conditions = {
			temp = {
				max = 0
			}
		},
		on_change = function(player, players_weather) end, -- Code can only modify things that will be restored in weather.default_on_change or sounds.
		on_step = function(player), -- Code that is run once per weather step (1 second)
		on_end = function(player, name, players_weather), -- Code run at end defaults to weather.default_on_change if not used, otherwise you must undo ALL changes made in on_change
		particlespawner = -- Same as luanti particlespawner, with the exception of the _1042_* fields
		{
			amount = 500,
			time = 1,

			_1042_weather_box_distance = 16, -- Bounds of spawner from player in nodes. Default 16

			collisiondetection = true,
			object_collision = true,
			collision_removal = true,

			vel = {
				min = vector.new(-2, -1, -2),
				max = vector.new(2, -4, 2),
				bias = 0
			},

			size = {
				min = 0.5,
				max = 1
			},

			exptime = {
				min = 6,
				max = 8
			},

			bounce = {
				min = 0,
				max = 0.3
			},

			glow = 8,

			texture = "1042_plain_node.png^[colorize:#ddddff:144"
		}
	}
```


### `on_change(player, name, players_weather)`

This call back is called once per weather change after the defaults are reset. This function can set sounds but the sounds must be stored in `players_weather.sound_handle`. Anything changed here, excluding sounds, must be reverted with `on_end(player, name, players_weather)` or if not present the defaults of `weather.default_on_change`. 

### `the_weather.on_end(player, name, players_weather)`

If `the_weather.on_end(player, name, players_weather)` is defined then all things changed in `on_change` MUST be reverted, this does not include the sound set with `players_weather.sound_handle` but all other things, as the default handler will not be run.






# `1042_schematics` API

1042 has its own schematic format to be used in mapgen. The files use a naming conventions in this format: `<schematic name>.1042_schem.json`. It uses a json formated file as an output and has the following functions:

- `schematics_1042.new_schematic(x, y, z)` Returns a schematic table with a size of `(x, y, z)`.
- `schematics_1042.register_schematic(name, schem)` Register a schematic table in the enviorment. Returns `true` if it worked or `false` if it was alredy registered.
- `schematics_1042.get_schematic` Get a registered schematic talbe, returns `nil` if it doesn't exist.
- `schematics_1042.is_schamatic(schem)` Returns `true` if table is formated correctly.
- `schematics_1042.load_schematic(path)` Load a schematic from disk. Returns `nil` on failure.
- `schematics_1042.place_schematic(posin, schematic, force)` Queue placing of schematic. Returns `"Qeued..."`
- `schematics_1042.save_schematic(pos1, pos2, path, ignore_air)` Queue saving of schematic. Returns `"Qeued..."`
- `schematics_1042.place_schematic_on_vmanip(posin, schematic, vm, force)` Place schematic on vm. Returns `true` if success, or `false` if it was to large for the vm area.




# Intigrated Testing Mod

`1042_tests` is a mod with a system of tests in game that are run with the game setting `1042_enable_intigrated_tests = true`. It has an API for easy testing in mods and new game components. This mod does not function when `1042_enable_intigrated_tests = false` but all function calls are still valid, but they will just return `false`.

## API

- `function tests_1042.print(text)` Prints debug data when runs in the intigrated tests are enabled. Is the same as `core.log("warning", "1042_tests: " .. tostring(text))`. Returns `true` on success.
- `function tests_1042.register_test(namein, func(name), run_on_loaded)` Register a test to run when all mods are loaded and testing starts. It is highly recommended to use the name format of `<mod name>:<test name>[_<test number>]>`. `run_on_loaded` runs the test as soon as all mods are loaded, other wise it is just set as a test that must be run, `false` by default. Returns `true` on success and `false` if already registered or intigrated tests are disabled. If `run_on_loaded` is `false` then when a player runs the test, the players name will be passed as `name`.
- `testing_1042` A boolean set based on the value of 1042_enable_intigrated_tests, this is to be used internaly to enable WIP features or tests/experiments. This can be set internaly but should be avoided unless needed for testing, for this reason the `run_test` chat-command is always valid.







# Privs

- `admin` This gives user the ability to manipulate things in the game.
- `creative` This gives user the unlimited items.


# Development

## Things to fix

- Things in code/content, that are known to need fixing soon can be found by greping for `#fixme`.