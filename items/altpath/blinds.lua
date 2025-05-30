local alpha = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+1,
	name = "entr-alpha",
	key = "alpha",
	pos = { x = 0, y = 0 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if
			context.full_hand
			and context.destroy_card
			and (context.cardarea == G.play)
			and not G.GAME.blind.disabled
		then
            local check = nil
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in ipairs(scoring_hand) do
                if i == 1 and v == context.destroy_card then check = true end
            end
            G.GAME.blind.triggered = true
			return { remove = check and not context.destroy_card.ability.eternal }
		end
    end
}

local beta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+2,
	name = "entr-beta",
	key = "beta",
	pos = { x = 0, y = 1 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if
			context.after
			and not G.GAME.blind.disabled
		then
            G.hand.config.card_limit = G.hand.config.card_limit - 1
            G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
            G.GAME.blind.triggered = true
		end
    end,
    defeat = function()
        if not G.GAME.blind.disabled then
            G.hand.config.card_limit = G.hand.config.card_limit + G.GAME.beta_modifer
            G.GAME.beta_modifer = nil
        end
    end,
    disable = function()
        G.hand.config.card_limit = G.hand.config.card_limit + G.GAME.beta_modifer
        G.GAME.beta_modifer = nil
    end,
    set_blind = function()
        G.hand.config.card_limit = G.hand.config.card_limit - 1
        G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
    end
}

local gamma = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+3,
	name = "entr-gamma",
	key = "gamma",
	pos = { x = 0, y = 2 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.after and not G.GAME.blind.disabled then
            local suits = {}
            local discovered = 0
			for i, v in ipairs(G.play.cards) do
				if v.config.center.key == "m_cry_abstract" then
					if not suits["abstract"] then
						suits["abstract"] = true
						discovered = discovered + 1
					end
				else
					if not suits[v.base.suit] then
						suits[v.base.suit] = true
						discovered = discovered + 1
					end
				end
			end
            discovered = math.max(discovered, 2)
            G.GAME.current_round.current_hand.mult = G.GAME.current_round.current_hand.mult * (1-1/discovered)
            update_hand_text({delay = 0}, {mult = G.GAME.current_round.current_hand.mult})
            G.GAME.blind.triggered = true
		end
	end,
}

local delta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+4,
	name = "entr-delta",
	key = "delta",
	pos = { x = 0, y = 3 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
    end
}
local eval_ref = evaluate_play_main
function evaluate_play_main (text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = eval_ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    if Entropy.BlindIs("bl_entr_delta") and G.GAME.round_resets.hands > G.GAME.current_round.hands_left and not G.GAME.blind.disabled then
        local used = G.GAME.round_resets.hands - G.GAME.current_round.hands_left
        used = math.max(used,2)
        mult = mult / used
        G.GAME.blind.triggered = true
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
    if Entropy.BlindIs("bl_entr_epsilon") and #G.play.cards > 1 and not G.GAME.blind.disabled then
        local used = #G.play.cards
        used = math.max(used,1)
        mult = mult / used
        G.GAME.blind.triggered = true
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
	if Entropy.BlindIs("bl_entr_rho") and #G.play.cards > 1 and not G.GAME.blind.disabled then
        local used = 1
        local ranks = {}
		for i, v in ipairs(G.play.cards) do
			if not ranks[v.base.id] then
				ranks[v.base.id] = true
				used = used + 1
			end
		end
        G.GAME.blind.triggered = true
		mult = mult / used
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end

local epsilon = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+5,
	name = "entr-epsilon",
	key = "epsilon",
	pos = { x = 0, y = 4 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
    end
}

local zeta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+6,
	name = "entr-zeta",
	key = "zeta",
	pos = { x = 0, y = 5 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    debuff_hand = function(self, cards, hand, handname, check)
        if #cards == 3 or #cards == 5 then return true end
        return false
    end
}

local eta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+7,
	name = "entr-eta",
	key = "eta",
	pos = { x = 0, y = 6 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
        if context.after then
            G.GAME.blind.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit"))
            for i, v in ipairs(G.hand.cards) do
                SMODS.recalc_debuff(v)
            end
            for i, v in ipairs(G.deck.cards) do
                SMODS.recalc_debuff(v)
            end
            G.GAME.blind:set_text()
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.base.suit == G.GAME.blind.suit_debuffed then
            return true
        end
        return false
    end,
    set_blind = function()
        G.GAME.blind.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit"))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
			G.GAME.blind:set_text()
			return true
		end}))
    end,
    loc_vars = function()
        if not G.GAME.blind.suit_debuffed then  return {
            vars = {"[suit]"}
        } end
        return {
            vars = {localize(G.GAME.blind.suit_debuffed, "suits_singular")}
        }
    end,
    collection_loc_vars = function()
        return {
            vars = {"[suit]"}
        }
    end
}

local theta = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+8,
	name = "entr-theta",
	key = "theta",
	pos = { x = 0, y = 7 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=1,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
}

local iota = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+9,
	key = "iota",
	pos = { x = 0, y = 8 },
	atlas = "altblinds",
    boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    boss = {
        min = 1
    },
    loc_vars = function()
        if not G.GAME.blind.suit_debuffed then G.GAME.blind.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit")) end
        return {
            vars = {G.GAME.iotablind and G.localization.descriptions["Blind"][G.GAME.iotablind.key].name or "[random blind]"}
        }
    end,
    collection_loc_vars = function()
        return {
            vars = {"[random blind]"}
        }
    end,
	in_pool = function() return G.GAME.entr_alt end,
	calculate = function(self, blind, context)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.calculate then
				s:calculate(blind, context)
			end
		end
        if context.after then
            G.GAME.iotablind = pseudorandom_element(G.P_BLINDS) 
            while not G.GAME.iotablind.boss or G.GAME.iotablind.boss.showdown do
                G.GAME.iotablind = pseudorandom_element(G.P_BLINDS) 
            end
            G.GAME.blind:set_text()
        end
	end,
	set_blind = function(self, reset, silent)
        G.GAME.iotablind = pseudorandom_element(G.P_BLINDS) 
        while not G.GAME.iotablind.boss or G.GAME.iotablind.boss.showdown do
            G.GAME.iotablind = pseudorandom_element(G.P_BLINDS) 
        end
        G.GAME.blind:set_text()
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.set_blind then
				s:set_blind(reset, silent)
			end
			if s.name == "The Eye" and not reset then
				G.GAME.blind.hands = {
					["Flush Five"] = false,
					["Flush House"] = false,
					["Five of a Kind"] = false,
					["Straight Flush"] = false,
					["Four of a Kind"] = false,
					["Full House"] = false,
					["Flush"] = false,
					["Straight"] = false,
					["Three of a Kind"] = false,
					["Two Pair"] = false,
					["Pair"] = false,
					["High Card"] = false,
				}
			end
			if s.name == "The Mouth" and not reset then
				G.GAME.blind.only_hand = false
			end
			if s.name == "The Fish" and not reset then
				G.GAME.blind.prepped = nil
			end
			if s.name == "The Water" and not reset then
				G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
				ease_discard(-G.GAME.blind.discards_sub)
			end
			if s.name == "The Needle" and not reset then
				G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
				ease_hands_played(-G.GAME.blind.hands_sub)
			end
			if s.name == "The Manacle" and not reset then
				G.hand:change_size(-1)
			end
			if s.name == "Amber Acorn" and not reset and #G.jokers.cards > 0 then
				G.jokers:unhighlight_all()
				for k, v in ipairs(G.jokers.cards) do
					v:flip()
				end
				if #G.jokers.cards > 1 then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.2,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 0.85)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1.15)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1)
									return true
								end,
							}))
							delay(0.5)
							return true
						end,
					}))
				end
			end

			--add new debuffs
			for _, v in ipairs(G.playing_cards) do
				self:debuff_card(v)
			end
			for _, v in ipairs(G.jokers.cards) do
				if not reset then
					self:debuff_card(v, true)
				end
			end
		end
	end,
	defeat = function(self, silent)
		for k, _ in pairs(Entropy.GetIota()) do
			if G.P_BLINDS[k].defeat then
				G.P_BLINDS[k]:defeat(silent)
			end
			if G.P_BLINDS[k].name == "The Manacle" and not self.disabled then
				G.hand:change_size(1)
			end
		end
	end,
	press_play = function(self)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.press_play then
				s:press_play()
			end
			if s.name == "The Hook" then
				G.E_MANAGER:add_event(Event({
					func = function()
						local any_selected = nil
						local _cards = {}
						for k, v in ipairs(G.hand.cards) do
							_cards[#_cards + 1] = v
						end
						for i = 1, 2 do
							if G.hand.cards[i] then
								local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("ObsidianOrb"))
								G.hand:add_to_highlighted(selected_card, true)
								table.remove(_cards, card_key)
								any_selected = true
								play_sound("card1", 1)
							end
						end
						if any_selected then
							G.FUNCS.discard_cards_from_highlighted(nil, true)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
				delay(0.7)
			end
			if s.name == "Crimson Heart" then
				if G.jokers.cards[1] then
					G.GAME.blind.triggered = true
					G.GAME.blind.prepped = true
				end
			end
			if s.name == "The Fish" then
				G.GAME.blind.prepped = true
			end
			if s.name == "The Tooth" then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						for i = 1, #G.play.cards do
							G.E_MANAGER:add_event(Event({
								func = function()
									G.play.cards[i]:juice_up()
									return true
								end,
							}))
							ease_dollars(-1)
							delay(0.23)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
			end
		end
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		local new_mult = mult
		local new_chips = hand_chips
		local trigger = false
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.modify_hand then
				local this_trigger = false
				new_mult, new_chips, this_trigger = s:modify_hand(cards, poker_hands, text, new_mult, new_chips)
				trigger = trigger or this_trigger
			end
			if s.name == "The Flint" then
				G.GAME.blind.triggered = true
				new_mult = math.max(math.floor(new_mult * 0.5 + 0.5), 1)
				new_chips = math.max(math.floor(new_chips * 0.5 + 0.5), 0)
				trigger = true
			end
		end
		return new_mult or mult, new_chips or hand_chips, trigger
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		G.GAME.blind.debuff_boss = nil
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.debuff_hand and s:debuff_hand(cards, hand, handname, check) then
				G.GAME.blind.debuff_boss = s
				return true
			end
			if s.debuff then
				G.GAME.blind.triggered = false
				if s.debuff.hand and next(hand[s.debuff.hand]) then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_ge and #cards < s.debuff.h_size_ge then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_le and #cards > s.debuff.h_size_le then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.name == "The Eye" then
					if G.GAME.blind.hands[handname] then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						G.GAME.blind.hands[handname] = true
					end
				end
				if s.name == "The Mouth" then
					if s.only_hand and s.only_hand ~= handname then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						s.only_hand = handname
					end
				end
			end
			if s.name == "The Arm" then
				G.GAME.blind.triggered = false
				if to_big(G.GAME.hands[handname].level) > to_big(1) then
					G.GAME.blind.triggered = true
					if not check then
						level_up_hand(G.GAME.blind.children.animatedSprite, handname, nil, -1)
						G.GAME.blind:wiggle()
					end
				end
			end
			if s.name == "The Ox" then
				G.GAME.blind.triggered = false
				if handname == G.GAME.current_round.most_played_poker_hand then
					G.GAME.blind.triggered = true
					if not check then
						ease_dollars(-G.GAME.dollars, true)
						G.GAME.blind:wiggle()
					end
				end
			end
		end
		return false
	end,
	drawn_to_hand = function(self)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.drawn_to_hand then
				s:drawn_to_hand()
			end
			if s.name == "Cerulean Bell" then
				local any_forced = nil
				for k, v in ipairs(G.hand.cards) do
					if v.ability.forced_selection then
						any_forced = true
					end
				end
				if not any_forced then
					G.hand:unhighlight_all()
					local forced_card = pseudorandom_element(G.hand.cards, pseudoseed("ObsidianOrb"))
					if focred_card then
						forced_card.ability.forced_selection = true
						G.hand:add_to_highlighted(forced_card)
					end
				end
			end
			if s.name == "Crimson Heart" and G.GAME.blind.prepped and G.jokers.cards[1] then
				local jokers = {}
				for i = 1, #G.jokers.cards do
					if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then
						jokers[#jokers + 1] = G.jokers.cards[i]
					end
					G.jokers.cards[i]:set_debuff(false)
				end
				local _card = pseudorandom_element(jokers, pseudoseed("ObsidianOrb"))
				if _card then
					_card:set_debuff(true)
					_card:juice_up()
					G.GAME.blind:wiggle()
				end
			end
		end
	end,
	stay_flipped = function(self, area, card)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.stay_flipped and s:stay_flipped(area, card) then
				return true
			end
			if area == G.hand then
				if
					s.name == "The Wheel"
					and pseudorandom(pseudoseed("ObsidianOrb")) < G.GAME.probabilities.normal / 7
				then
					return true
				end
				if
					s.name == "The House"
					and G.GAME.current_round.hands_played == 0
					and G.GAME.current_round.discards_used == 0
				then
					return true
				end
				if s.name == "The Mark" and card:is_face(true) then
					return true
				end
				if s.name == "The Fish" and G.GAME.blind.prepped then
					return true
				end
			end
		end
	end,
	debuff_card = function(self, card, from_blind)
		if card and type(card) == "table" and card.area then
			for k, _ in pairs(Entropy.GetIota()) do
				s = G.P_BLINDS[k]
				if s.debuff_card then
					s:debuff_card(card, from_blind)
				end
				if s.debuff and not G.GAME.blind.disabled and card.area ~= G.jokers then
					--this part is buggy for some reason
					if s.debuff.suit and Card.is_suit(card, s.debuff.suit, true) then
						card:set_debuff(true)
						return
					end
					if s.debuff.is_face == "face" and Card.is_face(card, true) then
						card:set_debuff(true)
						return
					end
					if s.name == "The Pillar" and card.ability.played_this_ante then
						card:set_debuff(true)
						return
					end
					if s.debuff.value and s.debuff.value == card.base.value then
						card:set_debuff(true)
						return
					end
					if s.debuff.nominal and s.debuff.nominal == card.base.nominal then
						card:set_debuff(true)
						return
					end
				end
				if s.name == "Crimson Heart" and not G.GAME.blind.disabled and card.area == G.jokers then
					return
				end
				if s.name == "Verdant Leaf" and not G.GAME.blind.disabled and card.area ~= G.jokers then
					card:set_debuff(true)
					return
				end
			end
		end
	end,
	cry_before_play = function(self)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.cry_before_play then
				s:cry_before_play()
			end
		end
	end,
	cry_after_play = function(self)
		for k, _ in pairs(Entropy.GetIota()) do
			s = G.P_BLINDS[k]
			if s.cry_after_play then
				s:cry_after_play()
			end
		end
	end,
}

local kappa = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+10,
	name = "entr-kappa",
	key = "kappa",
	pos = { x = 0, y = 9 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
}

local hand_info = G.FUNCS.get_poker_hand_info
G.FUNCS.get_poker_hand_info = function(_cards)
	local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = hand_info(_cards)
	if Entropy.BlindIs("bl_entr_kappa") and not G.GAME.blind.disabled then 
		scoring_hand2 = {}
		for i, v in ipairs(_cards) do
			if not SMODS.in_scoring(v, scoring_hand or {}) then
				scoring_hand2[#scoring_hand2+1]=v
			end
		end
		return text, disp_text, poker_hands, scoring_hand2 or {}, non_loc_disp_text, percent, percent_delta
	end
	return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end

local lambda = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+11,
	name = "entr-lambda",
	key = "lambda",
	pos = { x = 0, y = 10 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		local _, _, _, hand = G.FUNCS.get_poker_hand_info(G.play.cards)
		if context.after then
			Entropy.FlipThen(hand, function(card)
				card.ability.perishable = true
				card.ability.perish_tally = 5
			end)
			delay(0.5)
		end
	end
}

local mu = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+12,
	name = "entr-mu",
	key = "mu",
	pos = { x = 0, y = 11 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	debuff_hand = function(self, cards, hand, handname, check)
		local total = 0
		for i, v in ipairs(cards) do
			total = total + v.base.nominal
		end
		if total > 30 then return true end
	end
}

local nu = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+13,
	name = "entr-nu",
	key = "nu",
	pos = { x = 0, y = 12 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.individual and context.cardarea == G.play then
			G.GAME.cry_payload = to_big((G.GAME.cry_payload or 1)) * to_big(0.8)
		end
	end
}

local xi = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+14,
	name = "entr-xi",
	key = "xi",
	pos = { x = 0, y = 13 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.discarded then
			Entropy.FlipThen(G.hand.highlighted, function(card)
				card.ability.eternal = true
			end)
			G.GAME.blind.discarded = true
		end
	end
}

local omicron = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+15,
	name = "entr-xi",
	key = "xi",
	pos = { x = 0, y = 14 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.after and not G.GAME.blind.played then
			Entropy.FlipThen(G.play.cards, function(card)
				card.ability.eternal = true
			end)
			G.GAME.blind.played = true
		end
	end
}

local pi = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+16,
	name = "entr-pi",
	key = "pi",
	pos = { x = 0, y = 15 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.pre_discard then
			Entropy.FlipThen(G.hand.highlighted, function(card)
				card.ability.perishable = true
				card.ability.perish_tally = 5
			end)
		end
	end
}

local rho = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+17,
	name = "entr-rho",
	key = "rho",
	pos = { x = 0, y = 16 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
	end
}

local sigma = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+18,
	name = "entr-sigma",
	key = "sigma",
	pos = { x = 0, y = 17 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if not G.GAME.blind.disabled then
			if context.before then
				ease_discard(-1)
				G.GAME.blind.triggered = true
			end
			if context.pre_discard then
				ease_hands_played(-1)
				if to_big(G.GAME.current_round.hands_left) <= to_big(0) then
					end_round()
				end
				G.GAME.blind.triggered = true
			end
		end
	end,
	setting_blind = function()
		local avg = math.ceil((G.GAME.round_resets.hands+G.GAME.round_resets.discards)/2)
		ease_hands_played(avg-G.GAME.round_resets.hands)
		ease_discard(abg-G.GAME.round_resets.discards)
		G.GAME.blind.triggered = true
	end
}

local tau = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+19,
	name = "entr-tau",
	key = "tau",
	pos = { x = 0, y = 18 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			G.GAME.tau = G.GAME.tau - 1
			Entropy.ChangeFullCSL(-1)
		end
	end,
	disable = function()
		Entropy.ChangeFullCSL(-G.GAME.tau)
		G.GAME.tau = nil
	end,
	defeat = function()
		if not G.GAME.blind.disabled then
			Entropy.ChangeFullCSL(-G.GAME.tau)
			G.GAME.tau = nil
		end
	end,
	set_blind = function()
		G.GAME.tau = G.GAME.tau or 0
		G.GAME.tau = G.GAME.tau + 1
		Entropy.ChangeFullCSL(1)
	end
}

local upsilon = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+20,
	name = "entr-upsilon",
	key = "upsilon",
	pos = { x = 0, y = 19 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.individual and context.cardarea == G.play and context.other_card and not G.GAME.blind.disabled then
			SMODS.calculate_individual_effect({plus_asc = -0,25}, context.other_card, 'plus_asc', -0.25, false)
		end
	end,
}

local phi = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+21,
	name = "entr-phi",
	key = "phi",
	pos = { x = 0, y = 20 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    recalc_debuff = function(self, card, from_blind)
		allowed = {
			[14] = true,
			[6]=true,
			[8]=true,
			[3]=true,
			[9]=true
			
		}
        if not allowed[card.base.id] then
            return true
        end
        return false
    end,
}

local chi = {
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	object_type = "Blind",
    order = 1000+22,
	name = "entr-chi",
	key = "chi",
	pos = { x = 0, y = 21 },
	atlas = "altblinds",
	boss_colour = HEX("907c7c"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    calculate = function(self, blind, context)
		if context.before and not G.GAME.blind.disabled then
			local ranks = {}
			for i, v in ipairs(G.play.cards) do
				if not ranks[v.base.id] then
					v:set_debuff(true)
					ranks[v.base.id] = true
				end
			end
		end
	end
}


return {
    items = {
        alpha,
        beta,
        gamma,
        delta,
        epsilon,
        zeta,
        eta,
        theta,
        iota,
		kappa,
		lambda,
		mu,
		nu,
		xi,
		omicron,
		pi,
		rho,
		sigma,
		tau,
		upsilon,
		phi,
		chi
    }
}