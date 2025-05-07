SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RTarot",
	primary_colour = G.C.Entropy.RTarot,
	secondary_colour = HEX("a54747"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_master"
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RPlanet",
	primary_colour = G.C.Entropy.RPlanet,
	secondary_colour = G.C.Entropy.RPlanet,
	collection_rows = { 6, 6 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_regulus"
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RSpectral",
	primary_colour = G.C.Entropy.RSpectral,
	secondary_colour = G.C.Entropy.RSpectral,
	collection_rows = { 4, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_changeling"
})


SMODS.ConsumableType{
	key = "CBlind",
	primary_colour = HEX("ab3a3e"),
	secondary_colour = HEX("ab3a3e"),
	--collection_rows = { 4, 5 },
	shop_rate = 0.0,
	default = "c_entr_bl_small",
    hidden=true,
}

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RCode",
	primary_colour = G.C.Entropy.RCode,
	secondary_colour = G.C.Entropy.RCode,
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_memory_leak"
})