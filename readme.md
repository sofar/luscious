
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

- jungle dirt is replaced by dirt with grass
- dirt with dry grass is replaced by dirt with grass
- dirt with snow is replaced by dirt with grass
- dry grass is replaced with grass

## bugs

- leaf decay is broken due to p2 usage
- grass spread is broken or will place wrongly colored grass nodes
- inventory items lack proper coloring
- snowy pine trees are missing

## palette

The large palette image is generated with:
  `convert textures/default_luscious_palette.png -filter point -resize 256x256 textures/palette_large.png`

