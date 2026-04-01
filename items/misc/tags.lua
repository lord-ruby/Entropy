Entropy.Tag{
	order = -10,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 0, y = 0 },
	config = { level = 1 },
	key = "dog",
	name = "entr-Dog Tag",
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag and tag.ability and tag.ability.level or 1 } }
	end,
	set_ability = function(self, tag)
		tag.hover_sound = function() return 'entr_woof'..math.random(3) end
	end,
	shiny_atlas = "entr_shiny_tags",
}

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

Entropy.Tag{
	order = -9.66,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 0, y = 1 },
	key = "neon",
	config = { type = "store_joker_modify", edition = "entr_neon" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_neon
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_neon", true)
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
	shiny_atlas = "entr_shiny_tags",
}

Entropy.Tag{
	order = -9.33,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 1, y = 1 },
	key = "lowres",
	config = { type = "store_joker_modify", edition = "entr_lowres" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_lowres
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_lowres", true)
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
	shiny_atlas = "entr_shiny_tags",
	min_ante = 2
}


Entropy.Tag{
	order = -9,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 1, y = 0 },
	config = { level = 1 },
	key = "sunny",
	name = "entr-Sunny Tag",
	min_ante = 3,
	config = { type = "store_joker_modify", edition = "entr_sunny" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_sunny
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_sunny", true)
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
	shiny_atlas = "entr_shiny_tags",
}

Entropy.Tag{
	order = -8,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 2, y = 0 },
	config = { level = 1 },
	key = "solar",
	name = "entr-Solar Tag",
	min_ante = 9,
	config = { type = "store_joker_modify", edition = "entr_solar" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
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
	shiny_atlas = "entr_shiny_tags",
	entr_credits = {
		art = {"Grahkon"}
	}
}

Entropy.Tag{
	order = -7,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 3, y = 0 },
	config = { level = 1 },
	key = "fractured",
	name = "entr-fractured Tag",
	min_ante = 9,
	config = { type = "store_joker_modify", edition = "entr_fractured" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_fractured
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_fractured", true)
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
	shiny_atlas = "entr_shiny_tags",
}


Entropy.Tag{
	order = -6,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 4, y = 0 },
	config = { level = 1 },
	key = "freaky",
	name = "entr-freaky Tag",
	min_ante = 4,
	config = { type = "store_joker_modify", edition = "entr_freaky" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_freaky
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_freaky", true)
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
	shiny_atlas = "entr_shiny_tags",
}

Entropy.Tag{
	order = -5,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 2, y = 1 },
	key = "kaleidoscopic",
	config = { type = "store_joker_modify", edition = "entr_kaleidoscopic" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_kaleidoscopic
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_kaleidoscopic", true)
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
	min_ante = 4,
}

Entropy.Tag{
	order = -4,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 4, y = 1 },
	key = "gilded",
	config = { type = "store_joker_modify", edition = "entr_gilded" },
	loc_vars = function(self, info_queue, tag)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_gilded
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_modify" then
			local _applied = nil
			if Cryptid.forced_edition and Cryptid.forced_edition() then
				tag:nope()
			end
			if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
				local lock = tag.ID
				G.CONTROLLER.locks[lock] = true
				context.card.temp_edition = true
				tag:yep("+", G.C.DARK_EDITION, function()
					context.card:set_edition("e_entr_gilded", true)
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
	min_ante = 3,
}

Entropy.Tag{
	order = -3,
	dependencies = {
	  items = {
		"set_entr_tags"
	  }
	},
	atlas = "tags",
	pos = { x = 3, y = 1 },
	key = "arcane",
	name = "entr-Arcane Tag",
	config = { type = "immediate" },
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				add_rune(Tag(Entropy.get_random_rune("entr_arcane_tag", true)))
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_tags",
}


--ascendant tags

SMODS.Atlas {
    key = 'ascendant_tags',
    path = 'ascendant_tags.png',
    px = 34,
    py = 34
  }


  SMODS.Atlas {
    key = 'shiny_ascendant_tags',
    path = 'shiny_ascendant_tags.png',
    px = 34,
    py = 34
  }


  local rare = Entropy.rare_tag(3, "rare", true, "Rare", {x=0,y=0}, 0, nil,3)
  local legendary = Entropy.rare_tag(4, "legendary", true, "Legendary", {x=2,y=0}, 0, true,5)

  Entropy.Tag{
    order = 8,
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_copying",
	atlas = "ascendant_tags",
	pos = {x=5,y=0},
	config = { type = "tag_add", num = 4 },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability and tag.ability.num or "?" } }
	end,
	config = {
		num = 4
	},
	apply = function(self, tag, context)
		if
			context.type == "tag_add"
			and context.tag.key ~= "tag_double"
			and context.tag.key ~= "tag_cry_triple"
			and context.tag.key ~= "tag_cry_quadruple"
			and context.tag.key ~= "tag_cry_quintuple"
			and context.tag.key ~= "tag_entr_ascendant_copying"
			and context.tag.key ~= "tag_cry_memory"
		then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.RED, function()
				for i = 1, to_number(tag.ability.num) do
					local tag = Tag(context.tag.key)
					if context.tag.key == "tag_cry_rework" then
						tag.ability.rework_edition = context.tag.ability.rework_edition
						tag.ability.rework_key = context.tag.ability.rework_key
					end
					add_tag(tag)
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
	set_ability = function(self, tag)
		tag.ability.num = math.floor(pseudorandom("ascendant_copying")*3+4)
	end
}

if (SMODS.Mods["Cryptid"] or {}).can_load then
	Entropy.Tag{
		dependencies = {
			items = {
				"set_entr_tags",
			}
		},
		order = 9,
		shiny_atlas="entr_shiny_ascendant_tags",
		key = "ascendant_voucher",
		atlas = "ascendant_tags",
		pos = {x=6,y=0},
		config = { type = "voucher_add" },
		in_pool = function() return false end or nil,
		loc_vars = function(self, info_queue)
			return { vars = { (SMODS.Mods["Tier3Sub"] and 4 or 3) } }
		end,
		apply = function(self, tag, context)
			if context.type == "voucher_add" then
				tag:yep("+", G.C.SECONDARY_SET.Voucher, function()
					SMODS.add_voucher_to_shop(Cryptid.next_tier3_key(true), true)
					return true
				end)
				tag.triggered = true
			end
		end,
		shiny_atlas = "entr_shiny_asc_tags",
	}
else
	Entropy.Tag{
		dependencies = {
			items = {
				"set_entr_tags",
			}
		},
		order = 9,
		shiny_atlas="entr_shiny_ascendant_tags",
		key = "ascendant_voucher",
		atlas = "ascendant_tags",
		pos = {x=6,y=0},
		config = { type = "voucher_add" },
		in_pool = function() return false end or nil,
		loc_vars = function(self, info_queue)
			return { vars = { (SMODS.Mods["Tier3Sub"] and 4 or 3) }, key = "tag_entr_ascendant_voucher_cryptidless" }
		end,
		apply = function(self, tag, context)
			if context.type == "voucher_add" then
				tag:yep("+", G.C.SECONDARY_SET.Voucher, function()
					for i = 1, 2 do
						SMODS.add_voucher_to_shop(nil, true)
					end
					return true
				end)
				tag.triggered = true
			end
		end,
		shiny_atlas = "entr_shiny_asc_tags",
	}
end
Entropy.edition_tag("e_negative", "negative", true, {x=1,y=1}, 10.1)
Entropy.edition_tag("e_foil", "foil", true, {x=2,y=1},10.2)
Entropy.edition_tag("e_holo", "holo", true, {x=3,y=1},10.3)
Entropy.edition_tag("e_polychrome", "poly", true, {x=4,y=1},10.4)

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 18,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_infdiscard",
	atlas = "ascendant_tags",
	pos = {x=6,y=2},
	config = { type = "round_start_bonus", num = 999 },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.num } }
	end,
	apply = function(self, tag, context)
		if context.type == "round_start_bonus" then
			tag:yep("+", G.C.BLUE, function()
				return true
			end)
			ease_discard(tag.config.num)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.edition_tag("e_entr_neon", "neon", true, {x=7,y=4},18.33)
Entropy.edition_tag("e_entr_lowres", "lowres", true, {x=7,y=3},18.66)
Entropy.edition_tag("e_entr_sunny", "sunny", true, {x=6,y=4},19)
Entropy.edition_tag("e_entr_solar", "solar", true, {x=1,y=3},20, {
	art = {"Grahkon"}
})
Entropy.edition_tag("e_entr_fractured", "fractured", true, {x=6,y=5},20.5)
Entropy.edition_tag("e_entr_freaky", "freaky", true, {x=7,y=5},20.75)

Entropy.edition_tag("e_entr_kaleidoscopic", "kaleidoscopic", true, {x=7,y=2},20.9)
Entropy.edition_tag("e_entr_gilded", "gilded", true, {x=7,y=0},20.95)

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 22,
	shiny_atlas="entr_shiny_ascendant_tags",
	atlas = "ascendant_tags",
	pos = { x = 3, y = 3 },
	config = { level = 1 },
	key = "ascendant_dog",
	name = "entr-Ascendant-Dog Tag",
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability and tag.ability.level or 1 } }
	end,
	level_func = function(level,one,tag)
		tag.ability.level2 = (tag.ability.level2 or 0) + 1
		return level * 2
	end,
	set_ability = function(self, tag)
		tag.ability.level2 = (tag.ability.level2 or 0) + 1
		tag.level_func = self.level_func
		tag.get_edition = function(tag)
			return G.P_CENTER_POOLS.Edition[(tag.ability.level2%#G.P_CENTER_POOLS.Edition)+1]
		end
		tag.hover_sound = function() return 'entr_woof'..math.random(3) end
	end,
	in_pool = function() return false end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 25,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_ejoker",
	atlas = "ascendant_tags",
	pos = {x=6,y=3},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_buffoon_mega_1
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_buffoon_mega_1"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card:set_edition(SMODS.poll_edition({guaranteed = true, key = "entr_ejoker"}))
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true, true)
				end
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}


Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 26,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_universal",
	atlas = "ascendant_tags",
	pos = {x=0,y=4},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
		return { vars = {tag.ability and tag.ability.hand and localize(tag.ability.hand,'poker_hands') or "[poker hand]"} }
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				G.GAME.hands[tag.ability.hand].AscensionPower = (G.GAME.hands[tag.ability.hand].AscensionPower or 0) + 3
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	set_ability = function(self, tag)
		tag.ability.hand = "High Card"
		local order = pseudorandom_element(G.GAME.hands, pseudoseed("universal"))
		while not order.visible do
			order = pseudorandom_element(G.GAME.hands, pseudoseed("universal"))
		end
		for i, v in pairs(G.GAME.hands) do
			if v.order == order.order then tag.ability.hand = i end
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 28,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_twisted",
	atlas = "ascendant_tags",
	pos = {x=2,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_entr_twisted_pack_mega
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_entr_twisted_pack_mega"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true, true)
				end
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 29,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_stock",
	atlas = "ascendant_tags",
	pos = {x=3,y=4},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			ease_dollars(G.GAME.dollars)
			tag:yep("+", G.C.GOLD, function()
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 29,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_blind",
	atlas = "ascendant_tags",
	pos = {x=4,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_entr_blind"
				local card = Card(
					G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
					G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
					G.CARD_W * 1.27,
					G.CARD_H * 1.27,
					G.P_CARDS.empty,
					G.P_CENTERS[key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({ config = { ref_table = card } })
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true, true)
				end
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

SMODS.Booster{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = -10000+95.5,
	shiny_atlas="entr_shiny_ascendant_tags",
    key = "blind",
    set = "Booster",
    config = { extra = 5, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            },
        }
    end,
    atlas = 'booster', pos = { x = 3, y = 0 },
    group_key = "k_blind_pack",
    cost = 8,
    draw_hand = true,
    weight = 0,
	in_pool = function() return false end,
    hidden = true,
    kind = "CBlind",
    create_card = function (self, card, i) 
        return create_card("BlindTokens", G.pack_cards, nil, nil, true, true, nil, "blind")
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("709284"))
		ease_background_colour({ new_colour = HEX("709284"), special_colour = HEX("3e5149"), contrast = 2 })
	end,
	cry_digital_hallucinations = {
		colour = G.C.GREEN,
		loc_key = "k_reference_pack",
		create = function()
			local ccard = create_card("BlindTokens", area or G.pack_cards, nil, nil, true, true, nil, "reference")
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 32,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_credit",
	atlas = "ascendant_tags",
	pos = {x=1,y=5},
	config = { type = "shop_final_pass" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "shop_final_pass" then
			tag:yep("+", G.C.GOLD, function()
				G.GAME.round_resets.temp_reroll_cost = -5
				calculate_reroll_cost(true)
				if G.shop_jokers and G.shop_booster then 
					for k, v in pairs(G.shop_jokers.cards) do
						v.ability.couponed = true
						v:set_cost()
					end
					for k, v in pairs(G.shop_vouchers.cards) do
						v.ability.couponed = true
						v:set_cost()
					end
					for k, v in pairs(G.shop_booster.cards) do
						v.ability.couponed = true
						v:set_cost()
					end
				end
				return true
			end)
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 33,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_topup",
	atlas = "ascendant_tags",
	pos = {x=2,y=5},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GREEN, function()
				for i = 1, 3 do
					if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card = create_card("Joker", G.jokers, nil, 0.8, nil, nil, nil, "bettertop")
						card:add_to_deck()
						G.jokers:emplace(card)
					end
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
    dependencies = {
    	items = {
        	"set_entr_tags",
        }
    },
	order = 36,
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_effarcire",
	atlas = "ascendant_tags",
	pos = {x=5,y=5},
	config = { type = "round_start_bonus" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "round_start_bonus" then
			tag:yep("+", G.C.GREEN, function()
				return true
			end)
			G.hand:change_size(#G.deck.cards)
			G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + #G.deck.cards
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}

Entropy.Tag{
	order = 37,
	dependencies = {
	  items = {
		"set_entr_tags",
	  }
	},
	atlas = "ascendant_tags",
	pos = { x = 7, y = 1 },
	key = "ascendant_arcane",
	name = "entr-Arcane Tag",
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				add_rune(Tag(Entropy.get_random_rune("entr_arcane_tag")))
				add_rune(Tag(Entropy.get_random_rune("entr_arcane_tag")))
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	shiny_atlas = "entr_shiny_asc_tags",
}