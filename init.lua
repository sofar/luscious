
--[[

  grass - biome colored grass

  (C) LGPL-2.1+ Auke Kok <sofar@foo-projects.org>

  Textures are licensed according to their respective origin
  from github.com/minetest/minetest_game, generally CC-BY-SA-4.0
  or similar.

]]--



local wp = minetest.get_worldpath() .. "/luscious"
minetest.mkdir(wp)

local mgp = minetest.get_mapgen_params()
local chunksize = 16 * mgp.chunksize

local function cmpy(p2, y)
	if y > 0 then
		local h1 = p2 % 16
		local h2 = math.floor(p2 / 16) * 16

		h1 = h1 - math.max(math.min(h1, math.floor(y / 16)), 0)
		return math.max(1, h1 + h2)
	else
		return math.max(1, p2)
	end
end
local function on_construct(pos)
	-- get chunk from pos
	local v = vector.apply(pos, function(a) return math.floor((a - 48) / chunksize) end)
	local o = vector.subtract(pos, vector.apply(v, function(a) return (a * chunksize) + 48 end))
	local l = o.z * (chunksize) + o.x
	local p = minetest.hash_node_position(v)

	local f = io.open(wp .. "/" .. string.format("%d", p), "r")
	if not f then
		minetest.log("error", "unable to find map for " .. string.format("%d", p))
		return
	end

	local z = f:read("*a")
	f:close()
	local map = minetest.decompress(z)

	local node = minetest.get_node(pos)
	
    if node.param2 ~=1 then     -- Use/preseve 1 as the flag to prevent leaf decay.     
        node.param2 = cmpy(string.byte(map, l + 1), pos.y)
    end
	minetest.swap_node(pos, node)
end



minetest.override_item("default:dirt_with_grass", {
	paramtype2 = "color",
	drawtype = "color",
	palette_index = 136,
	color = "#7dea1eff",
	palette = "luscious_grass_palette.png",
	tiles = {"luscious_grass.png", {name = "default_dirt.png", color = "white"}, "luscious_grass.png"},
	overlay_tiles = {"", "", {name = "luscious_dirt_overlay.png", color = "white"}},
	place_param2 = 136,
	drop  = "default:dirt",
	on_construct = on_construct,
})




minetest.override_item("default:desert_sand", {
	paramtype2 = "color",
	drawtype = "color",
	palette_index = 136,
	color = "#c0825dff",
	palette = "luscious_desert_sand_palette.png",
	tiles = {"luscious_desert_sand.png", {name = "luscious_desert_sand", color = "white"}, "luscious_desert_sand.png"},
	place_param2 = 136,
	drop  = "default:desert_sand", -- Prevent the creation of a new item for each color.
	on_construct = on_construct,
})


minetest.override_item("default:sand", {
	paramtype2 = "color",
	drawtype = "color",
	palette_index = 136,
	color = "#f3dec3ff",
	palette = "luscious_default_sand_palette.png",
	tiles = {"luscious_default_sand.png", {name = "default_sand.png", color = "white"}, "luscious_default_sand.png"},
--	overlay_tiles = {"", "", {name = "luscious_dirt_overlay.png", color = "white"}},
	place_param2 = 136,
	drop  = "default:sand",
	on_construct = on_construct,
})





--------------------------------------Ethereal Add On------------------------------------------------
if minetest.get_modpath("ethereal") then
minetest.override_item("ethereal:prairie_dirt", {
	paramtype2 = "color",
	drawtype = "color",
	palette_index = 136,
	color = "#7dea1eff",
	palette = "luscious_grass_palette.png",
	tiles = {"luscious_prairie_grass.png", {name = "default_dirt.png", color = "white"}, "luscious_prairie_grass.png"},
	overlay_tiles = {"", "", {name = "luscious_dirt_overlay.png", color = "white"}},
	place_param2 = 136,
	drop  = "ethereal:prairie_dirt",
	on_construct = on_construct,
})






minetest.override_item("ethereal:dry_dirt", {
	paramtype2 = "color",
	drawtype = "color",
	palette_index = 136,
	color = "#7dea1eff",
	palette = "luscious_ethereal_dry_dirt_palette.png",
	tiles = {"luscious_ethereal_dry_dirt.png", {name = "luscious_ethereal_dry_dirt.png", color = "white"}, "luscious_ethereal_dry_dirt.png"},
--	overlay_tiles = {"", "", {name = "luscious_dirt_overlay.png", color = "white"}},
	place_param2 = 136,
	drop  = "ethereal:dry_dirt",
	on_construct = on_construct,
})



end

-----------------------------------------------------------------------------------------------------------

for _, v in pairs({
	"default:leaves",
	"default:aspen_leaves",
	"default:jungleleaves",
	"default:pine_needles",
	"default:acacia_leaves",
	"default:bush_leaves",
	"default:acacia_bush_leaves",
}) do
	local def = minetest.registered_nodes[v]
	local tile, _ = def.tiles[1]:gsub("default_", "luscious_")
	minetest.override_item(v, {
		paramtype2 = "color",
		palette_index = 136,
		palette = "luscious_leaves_palette.png",
		color = "#8afb94ff",
		tiles = {tile},
		place_param2 = 136,
		groups = {snappy = 3, flammable = 2, leaves = 1, leafdecay = 1},
		on_construct = on_construct,
	})
end

minetest.register_alias_force("default:dirt_with_dry_grass", "default:dirt_with_grass")
minetest.register_alias_force("default:dirt_with_rainforest_litter", "default:dirt_with_grass")
minetest.register_alias_force("default:dirt_with_snow", "default:dirt_with_grass")


for _, v in pairs({
	"default:grass_1",
	"default:grass_2",
	"default:grass_3",
	"default:grass_4",
	"default:grass_5",
	"default:junglegrass",
}) do
	local def = minetest.registered_nodes[v]
	local tile, _ = def.tiles[1]:gsub("default_", "luscious_")
	minetest.override_item(v, {
		paramtype2 = "color",
		palette_index = 136,
		palette = "luscious_grass_palette.png",
		color = "#7dea1eff",
		tiles = {tile},
		place_param2 = 136,
		on_construct = on_construct,
	})
end

--- I have absolutly no idea what is the purpose but I aplied it to other stuff and it work.
for i = 1, 5 do
	minetest.register_alias_force("default:dry_grass_" .. i, "default:grass_" .. i , "default:desert_" .. i , "ethereal:dry_" .. i, "ethereal:prairie_" .. i )
end

-- content ids
local cn = {
	["ethereal:dry_dirt"] = 1,
	["ethereal:prairie_dirt"] = 1,
    ["default:sand"] = 1,
	["default:desert_sand"] = 1,
	["default:dirt_with_grass"] = 1,
	["default:grass_1"] = 1,
	["default:grass_2"] = 1,
	["default:grass_3"] = 1,
	["default:grass_4"] = 1,
	["default:grass_5"] = 1,
	["default:junglegrass"] = 1,
	["default:leaves"] = 1,
	["default:aspen_leaves"] = 1,
	["default:jungleleaves"] = 1,
	["default:pine_needles"] = 1,
	["default:acacia_leaves"] = 1,
	["default:bush_leaves"] = 1,
	["default:acacia_bush_leaves"] = 1,
}
local cs = {}
for k, _ in pairs(cn) do
	cs[minetest.get_content_id(k)] = 1
end

minetest.register_on_generated(function(minp, maxp, blockseed)
	local v = vector.apply(minp, function(a) return (a - 48) / chunksize end)
	local heatmap = minetest.get_mapgen_object("heatmap")
	local humiditymap = minetest.get_mapgen_object("humiditymap")
	local map = ""
	for i = 1, #heatmap do
		local h1 = heatmap[i]
		local h2 = humiditymap[i]
		h1 = math.floor(math.min(math.max(math.floor(h1), 0), 100) / 6.6)
		h2 = math.floor(math.min(math.max(math.floor(h2), 0), 100) / 6.6)
		map = map .. string.char(h1 + (h2 * 16))
	end
	local p = string.format("%d", minetest.hash_node_position(v))

	local f = assert(io.open(wp .. "/" .. p, "w"), wp .. "/" .. p)
	f:write(minetest.compress(map))
	f:close()

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	local data = vm:get_data()
	local p2data = vm:get_param2_data()
	for z = minp.z, maxp.z do
	for y = minp.y, maxp.y do
		local vi = area:index(minp.x, y, z)
		for x = minp.x, maxp.x do
			local vv = (x - minp.x) + ((z - minp.z) * chunksize)
			if cs[data[vi]] then
				local mv = cmpy(string.byte(map, vv + 1), y)
				p2data[vi] = mv
			end
			vi = vi + 1
		end
	end
	end
	vm:set_param2_data(p2data)
	vm:write_to_map()
end)

local function update_p2(pos, size)
	local minp = {x = pos.x - size[1], y = pos.y, z = pos.z - size[1]}
	local maxp = {x = pos.x + size[1], y = pos.y + size[2], z = pos.z + size[1]}
	for x = minp.x, maxp.x do
	for y = minp.y, maxp.y do
	for z = minp.z, maxp.z do
		local p = vector.new(x, y, z)
		local node = minetest.get_node(p)
		if cn[node.name] then
			on_construct(p)
		end
	end
	end
	end
end

local saplings = {
	["default:sapling"] = {2, 8},
	["default:junglesapling"] = {2, 17},
	["default:pine_sapling"] = {2, 14},
	["default:acacia_sapling"] = {4, 8},
	["default:aspen_sapling"] = {2, 12},
	["default:bush_sapling"] = {1, 3},
	["default:acacia_bush_sapling"] = {1, 3},
}

for k, v in pairs(saplings) do
	minetest.override_item(k, {
		on_timer = function(pos)
			default.grow_sapling(pos)
			update_p2(pos, v)
		end,
	})
end

