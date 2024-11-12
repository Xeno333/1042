# **Documentation of 1042 for development and modding**

This is documentation for development and modding for the game `1042` on the *Luanti* game engine.




# Core interface

## `core_1042` is the namespace for all core_1042 functions
- `core_1042.eat(itemstack, user, food_value, p_chance)` This removes one item from itemstack from the player `user` and adds `value` to `user`'s HP, `p_chance` is chance of taking damage of `food_value` while eating item.




# Groups

- `breakable_by_hand` Player can break these items without tools. `{[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}`
- `stone` Stone nodes.
- `leafy` Leafy nodes.
- `plant` Plant (Biomass) nodes.
- `wood` Wood nodes.
- `cools` Planned for cooling nodes.
- `burning` For burning/hot nodes.
- `melts` Melts to water.


## Not used yet

- `burns` Planned for burning/fire.
- `freezes` Planned for freezing nodes.




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




# Development

## Things to fix

- Things in code/content, that are known to need fixing soon can be found by greping for `#fixme`.