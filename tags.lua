SMODS.Atlas {
    key = 'tags',
    path = 'tags.png',
    px = 34,
    py = 34
  }

SMODS.Tag({
	atlas = "tags",
	pos = { x = 0, y = 0 },
	config = { level = 1 },
	key = "dog",
	name = "entr-Dog Tag",
	order = 12,
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability.level or 1 } }
	end,
})

SMODS.Sound({
	key = "woof1",
	path = "woof1.ogg",
})
SMODS.Sound({
	key = "woof2",
	path = "woof2.ogg",
})
SMODS.Sound({
	key = "woof3",
	path = "woof3.ogg",
})