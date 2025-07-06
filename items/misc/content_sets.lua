SMODS.ContentSet({
	key = "inversions",
	atlas = "consumables",
	pos = { x = 3, y = 0 },
	cry_order = -2,
})

SMODS.ContentSet({
	key = "tags",
	atlas = "tags",
	pos = { x = 0, y = 0 },
	cry_order = -1,
    cry_tag = true,
})

SMODS.ContentSet({
	key = "blinds",
	atlas = "blinds",
	pos = { x = 1, y = 1 },
    cry_blind = true,
	cry_order = 0,
})

SMODS.ContentSet({
	key = "decks",
	atlas = "decks",
	pos = { x = 4, y = 0 },
	cry_order = 1,
})

SMODS.ContentSet({
	key = "misc",
	atlas = "enhancements",
	pos = { x = 0, y = 0 },
	cry_order = 2,
})

if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
	SMODS.ContentSet({
		key = "entropics",
		atlas = "exotic_jokers",
		pos = { x = 3, y = 2 },
		soul_pos = { x = 5, y = 2, extra = { x = 4, y = 2 } },
		cry_order = 3,
	})
end

SMODS.ContentSet({
	key = "vouchers",
	atlas = "vouchers",
	pos = { x = 2, y = 0 },
	cry_order = 4,
})

SMODS.ContentSet({
	key = "spectrals",
	atlas = "consumables",
	pos = { x = 5, y = 8 },
	cry_order = 5,
})

SMODS.ContentSet({
	key = "misc_jokers",
	atlas = "jokers",
	pos = { x = 0, y = 0 },
	cry_order = 6,
})

SMODS.ContentSet({
	key = "altpath",
	atlas = "altblinds",
	pos = { x = 0, y = 0 },
	cry_order = 7,
	cry_blind = true,
})