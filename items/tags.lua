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
	set_ability = function(self, tag)
		tag.hover_sound = function() return 'entr_woof'..math.random(3) end
	end
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


  Entropy.RareTag(3, "rare", true, "Rare", {x=0,y=0}, 0, nil)
  Entropy.RareTag("cry_epic", "epic", true, "cry_epic", {x=1,y=0}, 0, nil)
  Entropy.RareTag(4, "legendary", true, "Legendary", {x=2,y=0}, 0, true)
  Entropy.RareTag("cry_exotic", "exotic", true, "cry_exotic", {x=3,y=0}, 0, nil)
  Entropy.RareTag("entr_hyper_exotic", "entropic", true, "entr_hyper_exotic", {x=4,y=0}, 0, nil)

  SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_copying_tag",
	atlas = "ascendant_tags",
	pos = {x=5,y=0},
	config = { type = "tag_add", num = 4 },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability.num or "?" } }
	end,
	apply = function(self, tag, context)
		if
			context.type == "tag_add"
			and context.tag.key ~= "tag_double"
			and context.tag.key ~= "tag_cry_triple"
			and context.tag.key ~= "tag_cry_quadruple"
			and context.tag.key ~= "tag_cry_quintuple"
			and context.tag.key ~= "tag_entr_ascendant_copying_tag"
			and context.tag.key ~= "tag_cry_memory"
		then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.RED, function()
				if context.tag.ability and context.tag.ability.orbital_hand then
					G.orbital_hand = context.tag.ability.orbital_hand
				end
				for i = 1, tag.ability.num do
					local tag = Tag(context.tag.key)
					if context.tag.key == "tag_cry_rework" then
						tag.ability.rework_edition = context.tag.ability.rework_edition
						tag.ability.rework_key = context.tag.ability.rework_key
					end
					add_tag(tag)
				end
				G.orbital_hand = nil
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
	set_ability = function(self, tag)
		tag.ability.num = math.floor(pseudorandom("ascendant_copying")*4+4)
	end
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_voucher_tag",
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
				G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
				local voucher_key = Cryptid.next_tier3_key(true)
				G.ARGS.voucher_tag[voucher_key] = true
				G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
				local card = Card(
					G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
					G.shop_vouchers.T.y,
					G.CARD_W,
					G.CARD_H,
					G.P_CARDS.empty,
					G.P_CENTERS[voucher_key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				Cryptid.misprintize(card)
				create_shop_card_ui(card, "Voucher", G.shop_vouchers)
				card:start_materialize()
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true)
				end

				if G.GAME.modifiers.cry_force_sticker == "eternal" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_eternal(true)
					card.ability.eternal = true
				end
				if G.GAME.modifiers.cry_force_sticker == "perishable" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_perishable(true)
					card.ability.perishable = true
				end
				if G.GAME.modifiers.cry_force_sticker == "rental" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_rental(true)
					card.ability.rental = true
				end
				if G.GAME.modifiers.cry_force_sticker == "pinned" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.pinned = true
				end
				if G.GAME.modifiers.cry_force_sticker == "banana" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.ability.banana = true
				end
				if G.GAME.modifiers.cry_sticker_sheet_plus then
					if G.GAME.modifiers.cry_sticker_sheet then
						for k, v in pairs(SMODS.Stickers) do
							v:set_sticker(card, true)
						end
					end
				end
				G.shop_vouchers:emplace(card)
				G.ARGS.voucher_tag = nil
				return true
			end)
			tag.triggered = true
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_saint_tag",
	atlas = "ascendant_tags",
	pos = {x=0,y=1},
	config = { type = "store_joker_create" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue, tag)
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, "cry_candy", nil, nil, nil, "entr_saint")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.GREEN, function()
				card:start_materialize()
				card.ability.couponed = true
				card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entr_saint")).key)
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
}
Entropy.EditionTag("e_negative", "negative", true, {x=1,y=1})
Entropy.EditionTag("e_foil", "foil", true, {x=2,y=1})
Entropy.EditionTag("e_holo", "holo", true, {x=3,y=1})
Entropy.EditionTag("e_polychrome", "poly", true, {x=4,y=1})
Entropy.EditionTag("e_cry_glass", "glass", true, {x=5,y=1})

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_better_voucher_tag",
	atlas = "ascendant_tags",
	pos = {x=6,y=1},
	config = { type = "voucher_add" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		return { vars = { (SMODS.Mods["Tier3Sub"] and 4 or 3) } }
	end,
	apply = function(self, tag, context)
		if context.type == "voucher_add" then
			tag:yep("+", G.C.SECONDARY_SET.Voucher, function()
				G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
				local voucher_key = Cryptid.next_tier3_key(true)
				G.ARGS.voucher_tag[voucher_key] = true
				G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
				local card = Card(
					G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
					G.shop_vouchers.T.y,
					G.CARD_W,
					G.CARD_H,
					G.P_CARDS.empty,
					G.P_CENTERS[voucher_key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				Cryptid.misprintize(card)
				create_shop_card_ui(card, "Voucher", G.shop_vouchers)
				card:start_materialize()
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true)
				end

				if G.GAME.modifiers.cry_force_sticker == "eternal" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_eternal(true)
					card.ability.eternal = true
				end
				if G.GAME.modifiers.cry_force_sticker == "perishable" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_perishable(true)
					card.ability.perishable = true
				end
				if G.GAME.modifiers.cry_force_sticker == "rental" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_rental(true)
					card.ability.rental = true
				end
				if G.GAME.modifiers.cry_force_sticker == "pinned" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.pinned = true
				end
				if G.GAME.modifiers.cry_force_sticker == "banana" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.ability.banana = true
				end
				if G.GAME.modifiers.cry_sticker_sheet_plus then
					if G.GAME.modifiers.cry_sticker_sheet then
						for k, v in pairs(SMODS.Stickers) do
							v:set_sticker(card, true)
						end
					end
				end
				G.shop_vouchers:emplace(card)

				local voucher_key = Cryptid.next_tier3_key(true)
				G.ARGS.voucher_tag[voucher_key] = true
				G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
				local card = Card(
					G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
					G.shop_vouchers.T.y,
					G.CARD_W,
					G.CARD_H,
					G.P_CARDS.empty,
					G.P_CENTERS[voucher_key],
					{ bypass_discovery_center = true, bypass_discovery_ui = true }
				)
				Cryptid.misprintize(card)
				create_shop_card_ui(card, "Voucher", G.shop_vouchers)
				card:start_materialize()
				if G.GAME.modifiers.cry_force_edition and not G.GAME.modifiers.cry_force_random_edition then
					card:set_edition(nil, true)
				elseif G.GAME.modifiers.cry_force_random_edition then
					local edition = Cryptid.poll_random_edition()
					card:set_edition(edition, true)
				end

				if G.GAME.modifiers.cry_force_sticker == "eternal" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_eternal(true)
					card.ability.eternal = true
				end
				if G.GAME.modifiers.cry_force_sticker == "perishable" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_perishable(true)
					card.ability.perishable = true
				end
				if G.GAME.modifiers.cry_force_sticker == "rental" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card:set_rental(true)
					card.ability.rental = true
				end
				if G.GAME.modifiers.cry_force_sticker == "pinned" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.pinned = true
				end
				if G.GAME.modifiers.cry_force_sticker == "banana" or G.GAME.modifiers.cry_sticker_sheet_plus then
					card.ability.banana = true
				end
				if G.GAME.modifiers.cry_sticker_sheet_plus then
					if G.GAME.modifiers.cry_sticker_sheet then
						for k, v in pairs(SMODS.Stickers) do
							v:set_sticker(card, true)
						end
					end
				end
				G.shop_vouchers:emplace(card)

				G.ARGS.voucher_tag = nil
				return true
			end)
			tag.triggered = true
		end
	end,
}


Entropy.EditionTag("e_cry_glitched", "glitched", true, {x=0,y=2})
Entropy.EditionTag("e_cry_gold", "gold", true, {x=1,y=2})
Entropy.EditionTag("e_cry_blur", "blurry", true, {x=2,y=2})
Entropy.EditionTag("e_cry_m", "m", true, {x=3,y=2})
Entropy.EditionTag("e_cry_mosaic", "mosaic", true, {x=4,y=2})
Entropy.EditionTag("e_cry_astral", "astral", true, {x=5,y=2})

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_infdiscard_tag",
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
}

Entropy.EditionTag("e_cry_oversat", "oversat", true, {x=0,y=3})
Entropy.EditionTag("e_entr_solar", "solar", true, {x=1,y=3})

SMODS.Tag({
	shiny_atlas="entr_shiny_ascendant_tags",
	atlas = "ascendant_tags",
	pos = { x = 2, y = 3 },
	config = { level = 1 },
	key = "ascendant_cat_tag",
	name = "entr-Ascendant-Cat Tag",
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability.level or 1 } }
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
	end,
	in_pool = function() return false end
})

SMODS.Tag({
	shiny_atlas="entr_shiny_ascendant_tags",
	atlas = "ascendant_tags",
	pos = { x = 3, y = 3 },
	config = { level = 1 },
	key = "ascendant_dog_tag",
	name = "entr-Ascendant-Dog Tag",
	loc_vars = function(self, info_queue, tag)
		return { vars = { tag.ability.level or 1 } }
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
	in_pool = function() return false end
})

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_canvas_tag",
	atlas = "ascendant_tags",
	pos = {x=4,y=3},
	config = { type = "store_joker_create" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue, tag)
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card
			if not G.GAME.banned_keys["j_cry_canvas"] then
				card = create_card("Joker", context.area, nil, nil, nil, nil, "j_cry_canvas")
				create_shop_card_ui(card, "Joker", context.area)
				card.states.visible = false
				tag:yep("+", G.C.RED, function()
					card:start_materialize()
					card:set_cost()
					return true
				end)
			else
				tag:nope()
			end
			tag.triggered = true
			return card
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_unbounded_tag",
	atlas = "ascendant_tags",
	pos = {x=5,y=3},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_spectral_normal_1
		info_queue[#info_queue + 1] = { set = "Spectral", key = "c_cry_pointer" }
		info_queue[#info_queue + 1] = { set = "RSpectral", key = "c_entr_beyond" }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_entr_unbounded"
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
}

SMODS.Booster({
	shiny_atlas="entr_shiny_ascendant_tags",
    key = "unbounded",
    set = "Booster",
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("FF0000")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 4, y = 0 },
    cost = 6,
    draw_hand = true,
    weight = 0,
    draw_hand = true,
	update_pack = SMODS.Booster.update_pack,
	loc_vars = SMODS.Booster.loc_vars,
	ease_background_colour = function(self)
		ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
	end,
	create_UIBox = function(self)
		return create_UIBox_spectral_pack()
	end,
	particles = function(self)
		G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
			timer = 0.015,
			scale = 0.1,
			initialize = true,
			lifespan = 3,
			speed = 0.2,
			padding = -1,
			attach = G.ROOM_ATTACH,
			colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
			fill = true,
		})
		G.booster_pack_sparkles.fade_alpha = 1
		G.booster_pack_sparkles:fade(1, 0)
	end,
	create_card = function(self, card, i)
		if
			i % 2 == 1
			and Cryptid.enabled("c_entr_beyond") == true
			and not G.GAME.banned_keys["c_entr_beyond"]
			and not (G.GAME.used_jokers["c_entr_beyond"] and not next(find_joker("Showman")))
		then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_entr_beyond")
		elseif
			not (G.GAME.used_jokers["c_cry_pointer"] and not next(find_joker("Showman"))) and not G.GAME.banned_keys["c_cry_pointer"]
		then
			return create_card("Spectral", G.pack_cards, nil, nil, true, true, "c_cry_pointer")
		else
			return create_card("Spectral", G.pack_cards, nil, nil, true, true)
		end
	end,
	group_key = "k_spectral_pack",
	cry_digital_hallucinations = {
		colour = G.C.SECONDARY_SET.Spectral,
		loc_key = "k_plus_spectral",
		create = function()
			local ccard
			if pseudorandom(pseudoseed("diha")) < 0.5 then
				ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_cry_pointer")
			else
				ccard = create_card("Spectral", G.consumeables, nil, nil, true, true, "c_entr_beyond")
			end
			ccard:set_edition({ negative = true }, true)
			ccard:add_to_deck()
			G.consumeables:emplace(ccard)
		end,
	},
})

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_ejoker_tag",
	atlas = "ascendant_tags",
	pos = {x=6,y=3},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_buffoon_mega_1
		return { vars = {} }
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
				card:set_edition(pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entr_saint")).key)
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
}


SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_universal_tag",
	atlas = "ascendant_tags",
	pos = {x=0,y=4},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
		return { vars = {tag.ability.hand and localize(tag.ability.hand,'poker_hands') or "[poker hand]"} }
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				G.GAME.hands[tag.ability.hand].AscensionPower = (G.GAME.hands[tag.ability.hand].AscensionPower or 0) + 6
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
	end
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_ebundle_tag",
	atlas = "ascendant_tags",
	pos = {x=1,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_ethereal" }
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_cry_console" }
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_entr_ascendant_twisted_tag" }
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_cry_bundle" }
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.ATTENTION, function()
				local tags = { "ethereal", "cry_console", "entr_ascendant_twisted_tag", "cry_bundle" }
				for i, v in ipairs(tags) do
					local _tag = Tag("tag_" .. v, true)
					_tag.ability.shiny = Cryptid.is_shiny()
					add_tag(_tag)
					if i == 1 then
						tag.triggered = true
						_tag:apply_to_run({ type = "new_blind_choice" })
					end
				end
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_twisted_tag",
	atlas = "ascendant_tags",
	pos = {x=2,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_entr_twisted_pack_mega
		return { vars = {} }
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
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_stock_tag",
	atlas = "ascendant_tags",
	pos = {x=3,y=4},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				ease_dollars(G.GAME.dollars * 1.5)
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_blind_tag",
	atlas = "ascendant_tags",
	pos = {x=4,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		return { vars = {} }
	end,
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
}

SMODS.Booster({
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
    weight = -999,
    hidden = true,
    kind = "CBlind",
    create_card = function (self, card, i) 
        return create_card("BlindTokens", G.pack_cards, nil, nil, true, true, nil, "blind")
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, HEX("709284"))
		ease_background_colour({ new_colour = HEX("709284"), special_colour = HEX("3e5149"), contrast = 2 })
	end
})


SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_reference_tag",
	atlas = "ascendant_tags",
	pos = {x=5,y=4},
	config = { type = "new_blind_choice" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_entr_reference
		return { vars = {} }
	end,
	apply = function(self, tag, context)
		if context.type == "new_blind_choice" then
			local lock = tag.ID
			G.CONTROLLER.locks[lock] = true
			tag:yep("+", G.C.SECONDARY_SET.Spectral, function()
				local key = "p_entr_reference"
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
}

SMODS.Booster({
	shiny_atlas="entr_shiny_ascendant_tags",
    key = "reference_pack",
    set = "Booster",
    config = { extra = 5, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
                colours = {
                    HEX("851628")
                }
            },
        }
    end,
    atlas = 'booster', pos = { x = 5, y = 0 },
    group_key = "k_reference_pack",
    cost = 8,
    draw_hand = true,
    weight = -9999,
    hidden = true,
    kind = "Joker",
    create_card = function (self, card, i) 
        return create_card("Reference", area or G.pack_cards, nil, nil, true, true, nil, "reference")
    end,
    ease_background_colour = function(self)
		ease_colour(G.C.DYN_UI.MAIN, G.C.BLUE)
		ease_background_colour({ new_colour = G.C.RED, special_colour = G.C.BLUE, contrast = 2 })
	end
})

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_cavendish_tag",
	atlas = "ascendant_tags",
	pos = {x=0,y=5},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
		info_queue[#info_queue + 1] = {
			set = "Joker",
			key = "j_cavendish",
			specific_vars = { 3, G.GAME.probabilities.normal or 1, 1000 },
		}
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GOLD, function()
				local card = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_cavendish")
				card:add_to_deck()
				G.jokers:emplace(card)
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_credit_tag",
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
}


SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_topup_tag",
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
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_better_topup_tag",
	atlas = "ascendant_tags",
	pos = {x=3,y=5},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.RED, function()
				for i = 1, 3 do
					if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
						local card = create_card("Joker", G.jokers, nil, 3, nil, nil, nil, "bettertop")
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
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_booster_tag",
	atlas = "ascendant_tags",
	pos = {x=4,y=5},
	config = { type = "immediate" },
	in_pool = function() return false end or nil,
	loc_vars = function(self, info_queue,tag)
	end,
	apply = function(self, tag, context)
		if context.type == "immediate" then
			tag:yep("+", G.C.GREEN, function()
				for i = 1, 3 do
					G.GAME.boostertag = (G.GAME.boostertag or 0) + 1.5
				end
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag {
	shiny_atlas="entr_shiny_ascendant_tags",
	key = "ascendant_effarcire_tag",
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
			G.GAME.round_resets.temp_handsize = #G.deck.cards
		end
	end,
}