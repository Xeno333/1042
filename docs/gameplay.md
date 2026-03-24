# 1042 Gameplay

## Inital notes

- This game is designed to be a survival adventure game, thus it is recommended to try to figure things out first.
- The game machanics in 1042 are not the same as most games on the luanti engine, thus this gameplay manual.

## Getting Around

Movement is pretty simple in 1042; besides the generic engine defined movement, you can go faster by walking longer (much like NodeCore if you've played that).

### Controls

Controls are slightly different in 1042. To eat/use some items you use the `aux1` key instead of rightclick/leftclick this is so you can still treat items as nodes.

### The Glider

Gliders allow you glide, how fascinating! Currently only one glider type exists, it can be crafted with some [sticks and plant matter](#natural_materials). Don't worry about the holes, you only fall out of the sky if you look down...

### Sky Portal (WIP)

The Sky Portal allows you to teleport to the Sky Dimension by left-clicking on it.

## Progressing

Welcome to the great big world! As you start out, you start with absolutely nothing, so in order to do absolutely anything you will have to absolutely get something. First you should know what's out there.

### Natural Materials

Materials can be found in many places in the world, some spawn naturally, or in loot chests if you happen to find one.

You will find sticks scattered across the surface, along with a multitude of flowers and other plant material. That's not the only place however, moss and other organic matter can be found underground.

If you find yourself feeling a little snacky, you can find a mushroom or two growing just about anywhere above ground (not under for some reason?). You can also expand you diet with some delectable raw bacon if you find that palatable. Word of advice: if you don't know what it is, don't eat it.

#### Cooking

If you don't however find raw pork satisfying, you can cook it by placing it on a campfire, or nearby a fire.

### Tools

In Luanti, nodes are given breaking groups. Tools can be assigned groups, which allows them to break nodes with those groups. Each tool is assigned at least one node break group:

* Axes: `wood` (Trees, Wood, etc.)
* Picks: `stone`, `frozen` (Stone, Ores, etc.)
* Shovels: `soil` (Sand, Soil, etc.)
* Swords: `leafy` (Leaves, Grass, etc.)

Tools also have material tiers:

* Axes: Flint, Iron, Cobalt, Titanium
* Picks: Iron, Bronze, Steel, Titanium
* Swords: Iron, Bronze, Cobalt, Titanium
* Shovels: Iron

#### Chisel

The chisel is used to make nodes out of harder materials such as stone. Left-click the stone with the chisel to select the node for it to be chiseled into, then press `Aux1` to begin (Press `Esc` to stop chiseling).

See this handy-dandy table for the nodes you can chisel:
| Final node |   Requirement  | Duration |
|:-----------|:--------------:|----------:|
| Oven	   | 2 stone blocks (vertical) |	  16 s |
| Mold	   | 1 stone block, or 1 rock  |	   8 s |

### Metals and Gems

Metal ores can be broken down into nuggets, you can find nuggets scattered around caves along with the ores. Gemstones are currently just shiny rocks.

Metal Ores:
* Copper
* Iron
* Gold
* Silver
* Cobalt
* Titanium

Gemstones:
* Beryl (Aquamarine)
* Opal
* Sapphire
* Ruby
* Topaz
* Tourmaline

Alloys:
* Bronze
* Steel

#### Smelting

Once you get your nugget you can begin the smelting process. First you need a [Mold](#mold), and a [Stone Oven](#oven). Grab your mold and place your nugget inside (place the nugget on the mold). Then, light the oven and place the mold inside. After a little while your nugget will be fully smelted.

#### Mold

The mold is used as a crucible to smelt ores in. Place the ore nugget in the mold and then place the mold into a lit oven to beign smelting it.

#### Oven

The Stone Oven is used to cook things at high temperatures. It is chiseled out of two vertical blocks of stone. You can light it with a campfire and then place a [mold](#mold) inside it to begin smelting.

### Crafting

Opening your inventory, you will see many things. Most importantly, there is your inventory list, which holds all the items you have on you. There is also a list of crafts, if you have the required materials to make a craft, you can craft it by moving the item from the craft list to your inventory (Hint: use Luanti's listring navigation `Shift+Click` functionality).

### Getting Started

Now that you understand the basics of how to progress, let's start with basic tools. If you are impatient, you may want to make a flint axe. Grab two sticks and 3 flint and craft yourself one.

Now it's time we begin getting ourselves that oven. First, you will need to make a [chisel](#chisel).

In order to make a chisel, you must first obtain iron (crude iron, or an iron ingot). Crude iron can be obtained by following this process:

1. Gather at least 9 nuggets
2. Craft an Iron Nugget Block from those nuggets
3. Gather enough plant material (`group:burns`) to craft a torch
4. Light charcoal with the torch, see [charcoal](#charcoal) on how to obtain charcoal
5. Place the Iron Nugget Block beside the burning charcoal
6. The burning charcoal should melt the Iron Nugget Block
7. If you're lucky it will solidify into Crude Iron, unlucky, Iron Slag
8. Repeat until you obtain at least one Crude Iron

Once you have crude iron, get some sticks and make the chisel. Now it's time to chisel the oven, and the mold. Take a look at the [chisel](#chisel) section on how to do this. Now you can begin [smelting](#smelting).

### Starting fires (Currently Broken, Use a Torch Instead)

This is a fairly simple task, find some iron nuggets and some flint. When you have found some flint, take it and put it right next to the node you want to light. After doing this you start to use (`aux1`) the flint to smack the iron nugget. This should produce a lot of sparks and the fire should ignite after a few attempts. It can take a while sometimes so don't give up to quickly. Some things like wood burn to charcoal, this can be used to melt metals.

#### Charcoal

Charcoal is made by burning trees or wood. Charcoal burns significantly hotter than other burnable nodes.