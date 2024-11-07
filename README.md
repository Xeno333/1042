# 1042

## pre-alpha-v0.1.1
![pre-alpha-v0.1.0](menu/background.2.png)


## Features
- Mapgen with 4 biomes (tempeture areas) vast mountins and plains with deep oceans and caves
- Unique UI with custom HUD and Invintory and in-game settings on a per-player basis
- 1 texture
- Several nodes
- Basic weather system


## Missing/Planned
- Crafting of items
- Working tools
- Mobs
- More trees and plants
- Goals or achivments
- Add ores
- Add moddable mapgen API
- Add sounds and music
- More general gameplay


## Requirements

### Luanti
By default 1042 requires:

#### Can not be overridden
- Luanti version 5.10.0 or later

#### Can be overridden with `1042_ignore_required_settings = true`
- `enable_shaders = true` for rendering some nodes properly
- `enable_auto_exposure = true` for the colours in the game to look right
- `enable_post_processing = true` for rendering
- `translucent_liquids = true` to render things like water
- `enable_clouds = true` for weather to look right
- `enable_3d_clouds = true` for weather to look right
- `exposure_compensation = 0.5` for stuff to look right

### Recommended and will enable if there are left at default
- `enable_waving_water = true`
- `enable_water_reflections = true`
- `smooth_lighting = true`
- `enable_dynamic_shadows = true`
- `enable_volumetric_lighting = true`
- `enable_bloom = true`
- `enable_node_specular = true`
- `soft_clouds = true`
- `connected_glass = true`
- `enable_fog = true`