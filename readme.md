
## luscious

Makes your map luscious.

This mod heavily modifies your base landscape and modifies various
nodes like dirt and leaves so that they become colored using node
coloring.

The color selection of each node is decided based on the biome data,
using heat and humidity. These are mapped on a 16x16 palette where
the heat is mapped along the x axis from 0-15 and the humidity along
the y axis with the same range. This gives us a total of 256 possible
colorizations of each node.

Manual placing of the nodes, and sapling placement is also modified to
make trees growing or manual placing of nodes also result in colorized
nodes in the landscape.

## features

- Player placed blocks are properly colored.
- Saplings that grow into trees color correctly.
- separate palette to color leaves and grass.
- should not break with texture packs, but you'll lose texture
  pack specific leaf and grass textures.
- grass spread places the correct color.
- jungle dirt is replaced by dirt with grass.
- jungle grass is also colored.
- dirt with dry grass is replaced by dirt with grass.
- dirt with snow is replaced by dirt with grass.
- dry grass is replaced with grass.
- Support recolor for ethereal prairie , bamboo and dry dirt.

## bugs
- Leaf decay require the newest version of minetest game if not it's disabled. 
- snowy pine trees are no longer generated, only regular pines

## palette

The large palette image is generated with:

```
  convert textures/luscious_grass_palette.png -filter point \
   -resize 256x256 textures/luscious_grass_palette_large.png
```

## Installation

Create a new world, enable this mod. Do not use this mod in an existing
world, ever.

