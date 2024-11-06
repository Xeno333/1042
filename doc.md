# Documentation of 1042 for development and modding

## Core interface

### `core_1042` is the namespace for all core_1042 functions
- `eat(itemstack, user, food_value)` This removes one item from itemstack from the player `user` and adds `value` to `user`'s HP.

## Groups

- `breakable_by_hand` Player can break these items without tools. `{[1] = 0.25, [2] = 0.5, [3] = 1, [4] = 2, [5] = 3, [6] = 4}`
- `stone` Stone nodes
- `leafy` Leafy nodes
- `plant` Plant (Biomass) nodes
- `wood` Wood nodes
### Not used yet
- `burns` Planned for burning/fire
- `melts` Planned for melting nodes
- `freezes` Planned for freezing nodes
- `cools` Planned for cooling nodes