SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Rune",
	primary_colour = G.C.Entropy.Rune,
	secondary_colour = G.C.Entropy.Rune,
	collection_rows = { 6, 6 },
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

SMODS.UndiscoveredSprite({
	key = "Pact",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 5, y = 0 },
	px = 71,
	py = 95,
})

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Fraud",
	primary_colour = G.C.Entropy.Fraud,
	secondary_colour = HEX("a54747"),
	collection_rows = { 5, 6 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_master",
	can_be_pulled = true,
})

SMODS.UndiscoveredSprite({
	key = "CBlind",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 999, y = 0 },
	px = 71,
	py = 95,
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
	default = "c_entr_changeling",
	can_be_pulled = true,
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
		default = "c_entr_memory_leak",
		can_be_pulled = true,
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

SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "Pact",
	primary_colour = G.C.Entropy.Pact,
	secondary_colour = G.C.Entropy.Pact,
	collection_rows = { 6, 6 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_envy",
	can_be_pulled = true,
})

SMODS.ConsumableType{
	key = "CBlind",
	primary_colour = HEX("ab3a3e"),
	secondary_colour = HEX("ab3a3e"),
	--collection_rows = { 4, 5 },
	shop_rate = 0.0,
	default = "c_entr_bl_small",
    hidden=true,
	can_be_pulled = true,
}

SMODS.ObjectType({
	key = "Sunny",
	default = "j_entr_sunny_joker",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})
SMODS.ObjectType({
	key = "Dice",
	default = "j_entr_d1",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
		self:inject_card(G.P_CENTERS.j_oops)
	end,
})

SMODS.UndiscoveredSprite({
	key = "CBlind",
	atlas = "undiscovered",
	path = "undiscovered.png",
	pos = { x = 999, y = 999 },
	px = 71,
	py = 95,
})