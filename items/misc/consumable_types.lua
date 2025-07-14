SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Rune",
	primary_colour = G.C.Entropy.Rune,
	secondary_colour = G.C.Entropy.Rune,
	collection_rows = { 4, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_jera"
})

SMODS.UndiscoveredSprite({
	key = "Rune",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 4, y = 0 },
	px = 71,
	py = 95,
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Fraud",
	primary_colour = G.C.Entropy.Fraud,
	secondary_colour = HEX("a54747"),
	collection_rows = { 4, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_master"
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Star",
	primary_colour = G.C.Entropy.Star,
	secondary_colour = G.C.Entropy.Star,
	collection_rows = { 6, 6 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_regulus"
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Omen",
	primary_colour = G.C.Entropy.Omen,
	secondary_colour = G.C.Entropy.Omen,
	collection_rows = { 4, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_changeling"
})

SMODS.UndiscoveredSprite({
	key = "Fraud",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 0, y = 0 },
	px = 71,
	py = 95,
})
SMODS.UndiscoveredSprite({
	key = "Star",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 1, y = 0 },
	px = 71,
	py = 95,
})
SMODS.UndiscoveredSprite({
	key = "Omen",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 2, y = 0 },
	px = 71,
	py = 95,
})

if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
	SMODS.ConsumableType({
		object_type = "ConsumableType",
		key = "Command",
		primary_colour = G.C.Entropy.Command,
		secondary_colour = G.C.Entropy.Command,
		collection_rows = { 4, 4 },
		shop_rate = 0.0,
		loc_txt = {},
		default = "c_entr_memory_leak"
	})
	SMODS.UndiscoveredSprite({
		key = "Command",
		atlas = "undiscovered",
		path = "undiscovered.png",
		pos = { x = 3, y = 0 },
		px = 71,
		py = 95,
	})
end

SMODS.ConsumableType{
	key = "CBlind",
	primary_colour = HEX("ab3a3e"),
	secondary_colour = HEX("ab3a3e"),
	--collection_rows = { 4, 5 },
	shop_rate = 0.0,
	default = "c_entr_bl_small",
    hidden=true,
}