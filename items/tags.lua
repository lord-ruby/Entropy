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

SMODS.Tag({
	atlas = "tags",
	pos = { x = 1, y = 0 },
	config = { level = 1 },
	key = "solar",
	name = "entr-Solar Tag",
	order = 13,
	min_ante = 9,
	config = { type = "store_joker_modify", edition = "entr_solar" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_solar", true)
					context.card.ability.couponed = true
					context.card:set_cost()
					context.card.temp_edition = nil
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				_applied = true
				tag.triggered = true
			end
		end
	end,
})