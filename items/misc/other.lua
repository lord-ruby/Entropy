local aleph = {
    dependencies = {
        items = {
          "set_entr_misc"
        }
    },
    object_type = "Sticker",
    order = 3200,
    atlas = "entr_stickers",
    pos = { x = 8, y = 0 },
    key = "entr_aleph",
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("c75985"),
    should_apply = false,
	draw = function(self, card, layer)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		G.shared_stickers["entr_aleph"].role.draw_major = card
		G.shared_stickers["entr_aleph"]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		G.shared_stickers["entr_aleph"]:draw_shader(
			"polychrome",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
		G.shared_stickers["entr_aleph"]:draw_shader(
			"voucher",
			nil,
			card.ARGS.send_to_shader,
			notilt,
			card.children.center
		)
	end,
    apply = function(self,card,val)
        card.ability.entr_aleph = true
    end,
}

local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    if not self.ability.entr_aleph or self.ability.bypass_aleph or self.bypass_selfdestruct or self.children.price then
        return start_dissolveref(self, ...)
    end
end

local update_ref = Card.update
function Card:update(dt)
	update_ref(self, dt)
	if self.ability.entr_aleph then
		self.entr_aleph = true
	end
	if self.entr_aleph then
		self.ability.entr_aleph = true
		self.ability.eternal = true
	end
    if self.cry_absolute then
        self.cry_absolute = nil
        self.ability.cry_absolute = nil

        self.entr_aleph = true
        self.ability.entr_aleph = true
		self.ability.eternal = true
    end
end

SMODS.Sticker:take_ownership("eternal", {
	draw = function(self, card)
		local notilt = nil
		if card.area and card.area.config.type == "deck" then
			notilt = true
		end
		if not card.ability.cry_absolute and not card.ability.entr_aleph then
			G.shared_stickers[self.key].role.draw_major = card
			G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
		end
	end,
})

SMODS.Sticker:take_ownership("cry_absolute", {
    no_collection = true,
	no_edeck = true
}, true)

SMODS.PokerHandPart {
	key = "derivative_part",
	func = function(hand)
		local eligible_cards = {}
		local suits = {
			Diamonds = true,
			Spades = true,
			Hearts = true,
			Clubs = true
		}
		for i, card in ipairs(hand) do
			if SMODS.has_no_suit(card) or card.config.center.key == "m_stone" 
			or card.config.center.overrides_base_rank 
			or card.base.suit == "entr_nilsuit" 
			or card.base.value == "entr_nilrank" 
			or not suits[card.base.suit]
			then --card.ability.name ~= "Gold Card"
                eligible_cards[#eligible_cards+1] = card
			end
		end
        local num = 5
		if #eligible_cards >= num then
			return { eligible_cards }
		end
		return {}
	end,
}

SMODS.PokerHand{
	key = "entr_derivative",
	l_chips = 50,
	l_mult = 3,
	chips = 160,
	mult = 16,
	visible = false,
	example = {
		{ "entr_nilsuit_K", true },
		{ "entr_nilsuit_T", true },
		{ "H_entr_nilrank", true },
		{ "entr_nilsuit_7", true },
		{ "entr_nilsuit_2", true },
	},
	evaluate = function(parts, hand)
		if next(parts.entr_derivative_part) then
			return { SMODS.merge_lists(parts.entr_derivative_part) }
		end
		return {}
	end
}

local wormhole = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "wormhole",
	config = { hand_type = "entr_derivative", softlock = true },
	pos = { x = 3, y = 0 },
	order = 1,
	atlas = "consumables2",
	aurinko = true,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_spatial_anomaly"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("entr_derivative", "poker_hands"),
				G.GAME.hands["entr_derivative"].level,
				G.GAME.hands["entr_derivative"].l_mult,
				G.GAME.hands["entr_derivative"].l_chips,
				colours = {
					(
						to_big(G.GAME.hands["entr_derivative"].level) == to_big(1) and G.C.UI.TEXT_DARK
						or G.C.HAND_LEVELS[to_number(math.min(7, G.GAME.hands["entr_derivative"].level))]
					),
				},
			},
		}
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
}

function Entropy.l_chipsmult(hand, card, l_chips, l_mult)
	update_hand_text({delay = 0}, {handname = hand, level = G.GAME.hands[hand].level, mult = Entropy.ascend_hand(G.GAME.hands[hand].mult, hand), chips = Entropy.ascend_hand(G.GAME.hands[hand].chips, hand)})
	delay(1)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	update_hand_text({delay = 0}, {handname = localize("k_level_chips"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	delay(2)
	G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips + l_chips
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {chips = G.GAME.hands[hand].l_chips, StatusText = true})
	delay(0.7)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	update_hand_text({delay = 0}, {handname = localize("k_level_mult"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	delay(2)
	G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult + l_mult
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {mult = G.GAME.hands[hand].l_mult, StatusText = true})
	delay(0.7)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	delay(1.3)
end

function Entropy.xl_chips(hand, card, l_chips)
	update_hand_text({delay = 0}, {handname = hand, level = G.GAME.hands[hand].level, mult = Entropy.ascend_hand(G.GAME.hands[hand].mult, hand), chips = Entropy.ascend_hand(G.GAME.hands[hand].chips, hand)})
	delay(1)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	update_hand_text({delay = 0}, {handname = localize("k_level_chips"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	delay(2)
	G.GAME.hands[hand].l_chips = G.GAME.hands[hand].l_chips * l_chips
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {chips = "X"..number_format(l_chips), StatusText = true})
	delay(0.7)
	update_hand_text({delay = 0}, {handname = localize("k_level_mult"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	delay(1.3)
end

function Entropy.xl_mult(hand, card, l_mult)
	update_hand_text({delay = 0}, {handname = hand, level = G.GAME.hands[hand].level, mult = Entropy.ascend_hand(G.GAME.hands[hand].mult, hand), chips = Entropy.ascend_hand(G.GAME.hands[hand].chips, hand)})
	delay(1)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	update_hand_text({delay = 0}, {handname = localize("k_level_mult"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	delay(2)
	G.GAME.hands[hand].l_mult = G.GAME.hands[hand].l_mult * l_mult
	update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {mult = "X"..number_format(l_mult), StatusText = true})
	delay(0.7)
	update_hand_text({delay = 0}, {handname = localize("k_level_mult"), chips = G.GAME.hands[hand].l_chips, mult = G.GAME.hands[hand].l_mult})
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
		play_sound('tarot1')
		if card and card.juice_up then card:juice_up(0.8, 0.5) end
		G.TAROT_INTERRUPT_PULSE = true
		return true end 
	}))
	delay(1.3)
end

local tyche = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "tyche",
	pos = { x = 0, y = 1 },
	order = 2,
	atlas = "consumables2",
	aurinko = true,
	config = {
		l_chips = 10,
		l_mult = 1,
	},
	loc_vars = function(self, q, card)
		return {
			vars = {
				number_format(card.ability.l_chips),
				number_format(card.ability.l_mult)
			}
		}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_q"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area)
		local hands = {}
		for i, v in pairs(G.GAME.hands) do
			if v.visible then
				hands[#hands+1] = i
			end
		end
		local hand = pseudorandom_element(hands, pseudoseed("entr_tyche"))
		Entropy.l_chipsmult(hand, card, card.ability.l_chips, card.ability.l_mult)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	can_use = function() return true end
}

local theia = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "theia",
	pos = { x = 1, y = 1 },
	order = 3,
	atlas = "consumables2",
	aurinko = true,
	config = {
		l_chips = 5,
		l_mult = 0.5,
	},
	loc_vars = function(self, q, card)
		return {
			vars = {
				number_format(card.ability.l_chips),
				number_format(card.ability.l_mult)
			}
		}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_planet_q"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area)
		local hand = "High Card"
		for i, v in pairs(G.GAME.hands) do
			if to_big(v.level) > to_big(G.GAME.hands[hand].level) then
				hand = i
			end
		end
		Entropy.l_chipsmult(hand, card, card.ability.l_chips, card.ability.l_mult)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	can_use = function() return true end
}

local chiron = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "chiron",
	pos = { x = 2, y = 1 },
	order = 4,
	atlas = "consumables2",
	aurinko = true,
	config = {
		xl_chips = 1.1,
	},
	loc_vars = function(self, q, card)
		return {
			vars = {
				number_format(card.ability.xl_chips),
			}
		}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_moon"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area)
		local hands = {}
		for i, v in pairs(G.GAME.hands) do
			if v.visible then
				hands[#hands+1] = i
			end
		end
		local hand = pseudorandom_element(hands, pseudoseed("entr_chrion"))
		Entropy.xl_chips(hand, card, card.ability.xl_chips)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	can_use = function() return true end
}

local neith = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "neith",
	pos = { x = 3, y = 1 },
	order = 5,
	atlas = "consumables2",
	aurinko = true,
	config = {
		xl_mult = 1.1,
	},
	loc_vars = function(self, q, card)
		return {
			vars = {
				number_format(card.ability.xl_mult),
			}
		}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_moon"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area)
		local hands = {}
		for i, v in pairs(G.GAME.hands) do
			if v.visible then
				hands[#hands+1] = i
			end
		end
		local hand = pseudorandom_element(hands, pseudoseed("entr_neith"))
		Entropy.xl_mult(hand, card, card.ability.xl_mult)
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	can_use = function() return true end
}

local sputnik = {
	dependencies = {
		items = {
			"set_entr_misc"
		},
	},
	object_type = "Consumable",
	set = "Planet",
	key = "sputnik",
	pos = { x = 4, y = 1 },
	order = 6,
	atlas = "consumables2",
	aurinko = true,
	config = {
		hands = 3
	},
	loc_vars = function(self, q, card)
		return {
			vars = {
				number_format(card.ability.hands),
			}
		}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[1] = create_badge(localize("k_satellite"), get_type_colour(self or card.config, card), nil, 1.2)
	end,
	use = function(self, card, area)
		local hands = {}
		for i, v in pairs(G.GAME.hands) do
			if v.visible then
				hands[#hands+1] = i
			end
		end
		pseudoshuffle(hands, pseudoseed("entr_sputnik"))
		for i = 1, math.min(card.ability.hands, #hands) do
			SMODS.smart_level_up_hand(card, hands[i], nil, 1)
		end
	end,
	demicoloncompat = true,
	force_use = function(self, card, area)
		card:use_consumeable(area)
	end,
	can_use = function() return true end
}


return {
    items = {
        aleph,
		wormhole,
		tyche,
		theia,
		chiron,
		neith,
		sputnik
    }
}