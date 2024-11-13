# **Documentation of 1042 for development and modding**

This is documentation for development and modding for the game `1042` on the *Luanti* game engine.




# Core interface

## `core_1042` is the namespace for all core_1042 functions
- `core_1042.eat(itemstack, user, food_value, p_chance)` This removes one item from itemstack from the player `user` and adds `value` to `user`'s HP, `p_chance` is chance of taking damage of `food_value` while eating item.




# Groups

- `breakable_by_hand` Player can break these items without tools. value is for break-time `{[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}`
- `stone` Stone nodes. Value is for tools like pick, for break-time. `{[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}`
- `leafy` Leafy nodes.
- `plant` Plant (Biomass) nodes.
- `wood` Wood nodes. Value is for tools like axe, for break-time. `{[1] = 1, [2] = 2, [3] = 3, [4] = 4, [5] = 5, [6] = 6}`
- `cools` Nodes that cool hot nodes.
- `burning` For burning/hot nodes.
- `burns` Nodes that can catch on fire. Value is chance from `1` to `<group value>` chance or burning.
- `molten` Uses `_1042_cools_to` for node.
- `melts` Uses `_1042_melts_to` for node.





# Node definition fields

There are a few new node definition fields for ABMs and such:

- `_1042_cools_to=<node>` Node cools to given node.
- `_1042_melts_to=<node>` Node melts to given node.




# APIs

There are a few APIs built into the game, and more planned for the beta release.


## Achievement API `achievements_1042`

`achievements_1042` is the mod that contains the API for achievements, along with some core achievements.


## Functions

- `achievements_1042.achieve(player, achievement_name)` Returns `nil` if the achievement does not exist, `false` if the player already has it, and `true` if the achievement is shown to the player.
- `achievements_1042.register_achievement(achievement_name, achievement_definition)` Register an achievement, returns `false` if already registered, `true` otherwise.


## Exposed tables
- `achievements_1042.achievements` All registered achievements.


## Achievement definition
```lua
{
    achievement = core.colorize("#ffffff", "First life"),
    colour = "#00ffaa"
}
```


## Core achievements

- `first_life` This is the achievement for first spawn of a player.
- `smelter` This is the achievement for first ingot broken.




# Weather API

Weathers are registered by appending to the end of `weather.weathers` with a weather definition. Tempetures across the map vary in range of ~-30 to ~30, though they may be slightly above or below these.


## API functions

The weather API is avalible in both the asynch mapgen enviorment and main via import from file (as done in mapgen.)

-`function weather.get_temp_map(x, z)` Get a temp map starting at `x, z`. The map is a mapblock, thus 80x80.
-`function weather.get_temp(pos, temp_map)` Get temp from temp map with coords on that temp map.
-`function weather.get_temp_single(pos)` Get temp at a position, this is faster than using the other two for single coords.


## Weather Definition

```lua
    {
        name = "Light snow",
        conditions = {
            temp = {
                max = 0
            }
        },
        clouds = {
            density = 0.35,
            color = "#f0faffaa",
            ambient = "#006699",
            thickness = 128,
            speed = {x=1, y=1},
            shadow = "#cccccc",
            height = 120
        },
        sky = {
            type = "regular",
            clouds = true,
            sky_color = {
                night_sky = "#0066ff",
                night_horizon = "#0088ff",
                day_horizon = "#90d3f6",
                day_sky = "#61b5f5"
            },
            fog = {
                fog_start = 0,
                fog_distance = 90,
                fog_color = "#ddddddaa"
            }
        },
        particlespawner = 
        {
            amount = 500,
            time = 1,

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



# Development

## Things to fix

- Things in code/content, that are known to need fixing soon can be found by greping for `#fixme`.