Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+1,
	name = "entr-alpha",
	key = "alpha",
	pos = { x = 0, y = 0 },
	atlas = "altblinds",
	boss_colour = HEX("882b2b"),
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
			return { remove = check and not SMODS.is_eternal(context.destroy_card) }
		end
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+2,
	name = "entr-beta",
	key = "beta",
	pos = { x = 0, y = 1 },
	atlas = "altblinds",
	boss_colour = HEX("cb8dd7"),
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
            Entropy.handle_card_limit(G.hand, -1)
            G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
            G.GAME.blind.triggered = true
		end
    end,
    defeat = function()
        if not G.GAME.blind.disabled then
            Entropy.handle_card_limit(G.hand, G.GAME.beta_modifer)
            G.GAME.beta_modifer = nil
        end
    end,
    disable = function()
		Entropy.handle_card_limit(G.hand, G.GAME.beta_modifer)
        G.GAME.beta_modifer = nil
    end,
    set_blind = function()
        Entropy.handle_card_limit(G.hand, -1)
        G.GAME.beta_modifer = (G.GAME.beta_modifer or 0) + 1
    end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+3,
	name = "entr-gamma",
	key = "gamma",
	pos = { x = 0, y = 2 },
	atlas = "altblinds",
	boss_colour = HEX("55d6ed"),
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 2,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
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
		local suits_unused = #SMODS.Suit.obj_buffer -1 - discovered
		G.GAME.blind.triggered = true
		if suits_unused > 1 then
			return mult * (1/suits_unused), hand_chips, true
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+4,
	name = "entr-delta",
	key = "delta",
	pos = { x = 0, y = 3 },
	atlas = "altblinds",	
	boss_colour = HEX("e56a2f"),
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
function Entropy.evaluate_play_misc(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
	local mult = SMODS.Scoring_Parameters["mult"].current
	local hand_chips = SMODS.Scoring_Parameters["chips"].current
    if Entropy.blind_is("bl_entr_delta") and to_big(G.GAME.round_resets.hands) > to_big(G.GAME.current_round.hands_left) and not G.GAME.blind.disabled then
        local used = G.GAME.round_resets.hands - G.GAME.current_round.hands_left
        used = math.max(used,2)
        mult = mult / used
        G.GAME.blind.triggered = true
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
    if Entropy.blind_is("bl_entr_epsilon") and #G.play.cards > 1 and not G.GAME.blind.disabled then
        local used = #G.play.cards
        used = math.max(used,1)
        mult = mult / used
        G.GAME.blind.triggered = true
        update_hand_text({delay=0}, {mult=mult})
        delay(0.4)
    end
	if Entropy.blind_is("bl_entr_rho") and #G.play.cards > 1 and not G.GAME.blind.disabled then
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
	if Entropy.blind_is("bl_entr_omicron") and to_big(G.GAME.round_resets.hands) <= to_big(G.GAME.current_round.hands_left) and not G.GAME.blind.disabled then
		mult = 0
		hand_chips = 0
	end
	SMODS.Scoring_Parameters["mult"]:modify(mult - SMODS.Scoring_Parameters["mult"].current)
	SMODS.Scoring_Parameters["chips"]:modify(hand_chips - SMODS.Scoring_Parameters["chips"].current)
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end

local calc_scoreref = SMODS.calculate_round_score
function SMODS.calculate_round_score(...)
	if G.GAME.blind and Entropy.blind_is("bl_entr_omicron") and not G.GAME.blind.config.done and not G.GAME.blind.disabled then return 0 end
	return calc_scoreref(...)
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+5,
	name = "entr-epsilon",
	key = "epsilon",
	pos = { x = 0, y = 4 },
	atlas = "altblinds",
	boss_colour = HEX("cf4082"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+6,
	name = "entr-zeta",
	key = "zeta",
	pos = { x = 0, y = 5 },
	atlas = "altblinds",
	boss_colour = HEX("d76b0e"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+7,
	name = "entr-eta",
	key = "eta",
	pos = { x = 0, y = 6 },
	atlas = "altblinds",
	boss_colour = Entropy.eta_gradient,
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
            G.GAME.blind.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit"))
            for i, v in ipairs(G.I.CARD) do
				if v.is_playing_card and v:is_playing_card() then
                	SMODS.recalc_debuff(v)
				end
            end
            G.GAME.blind.loc_debuff_lines = {}
			G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
			G.GAME.blind:set_text()
			G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
        end
    end,
    recalc_debuff = function(self, card, from_blind)
        if card.base.suit == G.GAME.blind.suit_debuffed and card.is_playing_card and card:is_playing_card() then
            return true
        end
        return false
    end,
    set_blind = function()
        G.GAME.blind.effect.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit"))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.2,
			func = function()
			G.GAME.blind.effect.loc_debuff_lines = {}
			G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
			G.GAME.blind:set_text()
			G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+8,
	name = "entr-theta",
	key = "theta",
	pos = { x = 0, y = 7 },
	atlas = "altblinds",
	boss_colour = Entropy.cmult_gradient,
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

local function _set_iota()
	G.GAME.iotablind = pseudorandom_element(G.P_BLINDS).key
	while not G.P_BLINDS[G.GAME.iotablind].boss 
		or G.P_BLINDS[G.GAME.iotablind].boss.showdown 
		or G.P_BLINDS[G.GAME.iotablind].altpath 
		or not SMODS.add_to_pool(G.P_BLINDS[G.GAME.iotablind])
	do
		G.GAME.iotablind = pseudorandom_element(G.P_BLINDS).key
	end
end

function Entropy.get_iota()
    return {[G.GAME.iotablind.key] = G.GAME.iotablind}
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+9,
	key = "iota",
	pos = { x = 0, y = 8 },
	atlas = "altblinds",
    boss_colour = Entropy.entropic_gradient,
    mult=2,
    dollars = 6,
    boss = {
        min = 1
    },
	altpath=true,
    loc_vars = function()
        if not G.GAME.blind.effect.suit_debuffed then G.GAME.blind.effect.suit_debuffed = pseudorandom_element({"Spades", "Hearts", "Diamonds", "Clubs"}, pseudoseed("eta_suit")) end
		_set_iota()
        return {
            vars = {G.GAME.iotablind and G.localization.descriptions["Blind"][G.GAME.iotablind].name or "[random blind]"}
        }
    end,
    collection_loc_vars = function()
        return {
            vars = {"[random blind]"}
        }
    end,
	in_pool = function() return G.GAME.entr_alt end,
	set_blind = function()
		if not G.GAME.iotablind then
			_set_iota()
		end
		G.GAME.blind.loc_debuff_lines = {}
		G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
		G.GAME.blind:set_text()
		G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
	end,
	defeat = function()
		G.GAME.iotablind = nil
	end,
	calculate = function(self, blind, context)
		if not G.GAME.blind.disabled then
			if context.after then
				G.E_MANAGER:add_event(Event{
					func = function()
						Spectrallib.defeat_copied_blinds(Spectrallib.get_copied_blinds(blind), self, silent)
						_set_iota()
						Spectrallib.set_copied_blinds(Spectrallib.get_copied_blinds(blind), self, silent, reset)
						G.GAME.blind.loc_debuff_lines = {}
						G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
						G.GAME.blind:set_text()
						G.FUNCS.HUD_blind_debuff(G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff'))
						SMODS.juice_up_blind()
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
							play_sound('tarot2', 0.76, 0.4);return true end}))
						play_sound('tarot2', 1, 0.4)
						for i, v in pairs(G.I.CARD) do
							if v.set_debuff then
								SMODS.recalc_debuff(v)
							end
						end
						return true
					end
				})
			end
		end
	end,
	get_copied_blinds = function()
		return G.GAME.iotablind
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+10,
	name = "entr-kappa",
	key = "kappa",
	pos = { x = 0, y = 9 },
	atlas = "altblinds",
	boss_colour = HEX("544f61"),
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
	if Entropy.blind_is("bl_entr_kappa") and not G.GAME.blind.disabled then 
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

local never_scoresref = SMODS.never_scores
function SMODS.never_scores(card, ...)
	if (next(SMODS.find_card("j_splash")) or SMODS.always_scores(card, ...)) and Entropy.blind_is("bl_entr_kappa") then return true end
	return never_scoresref(card, ...)
end

local always_scoresref = SMODS.always_scores
function SMODS.always_scores(card, ...)
	if card.config.center.key == "j_entr_false_vacuum_collapse" or card.config.center.key == "phoenix_a" then return true end
	return always_scoresref(card, ...)
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+11,
	name = "entr-lambda",
	key = "lambda",
	pos = { x = 0, y = 10 },
	atlas = "altblinds",
	boss_colour = HEX("59dca7"),
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
			local _, _, _, hand = G.FUNCS.get_poker_hand_info(G.play.cards)
			Entropy.flip_then(hand, function(card)
				card.ability.debuff_timer = 5
				card.ability.debuff_timer_max = 5
			end)
			delay(0.5)
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+12,
	name = "entr-mu",
	key = "mu",
	pos = { x = 0, y = 11 },
	atlas = "altblinds",
	boss_colour = HEX("a730b9"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+13,
	name = "entr-nu",
	key = "nu",
	pos = { x = 0, y = 12 },
	atlas = "altblinds",
	boss_colour = HEX("eeba64"),
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
		if context.individual and context.cardarea == G.play and not G.GAME.blind.disabled then
			G.GAME.cry_payload = to_big((G.GAME.cry_payload or 1)) * to_big(0.8)
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+14,
	name = "entr-xi",
	key = "xi",
	pos = { x = 0, y = 13 },
	atlas = "altblinds",
	boss_colour = HEX("dc568b"),
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
		if context.pre_discard and not G.GAME.blind.effect.discarded and not G.GAME.blind.disabled then
			for i, v in pairs(G.hand.highlighted) do
				local c = v
				G.E_MANAGER:add_event(Event{
					trigger = "after",
					func = function()
						c.ability.eternal = true
						c:juice_up()
						return true
					end
				})
				delay(0.3)
			end
			delay(0.3)
			G.GAME.blind.effect.discarded = true
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+15,
	name = "entr-omicron",
	key = "omicron",
	pos = { x = 0, y = 14 },
	atlas = "altblinds",
	boss_colour = HEX("7d7aff"),
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
			G.E_MANAGER:add_event(Event {
				trigger = "after",
				func = function()
					G.GAME.blind.config.done = true
					return true
				end
			})
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+16,
	name = "entr-pi",
	key = "pi",
	pos = { x = 0, y = 15 },
	atlas = "altblinds",
	boss_colour = HEX("687ee7"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+17,
	name = "entr-rho",
	key = "rho",
	pos = { x = 0, y = 16 },
	atlas = "altblinds",
	boss_colour = HEX("f03464"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+18,
	name = "entr-sigma",
	key = "sigma",
	pos = { x = 0, y = 17 },
	atlas = "altblinds",
	boss_colour = Entropy.cmult_gradient,
    mult=2,
    dollars = 6,
    altpath=true,
	boss = {
		min = 1,
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	set_blind = function()
		G._sigma_bypass = true
		local avg = math.ceil((G.GAME.current_round.hands_left+G.GAME.current_round.discards_left)/2)
		if avg-G.GAME.current_round.hands_left > 0 then ease_hands_played(avg-G.GAME.current_round.hands_left) end
		if avg-G.GAME.current_round.discards_left > 0 then ease_discard(avg-G.GAME.current_round.discards_left) end
		G._sigma_bypass = nil
		G.GAME.blind.triggered = true
		ease_colour(G.C.UI.HANDS, {0.8, 0.45, 0.85, 1})
        ease_colour(G.C.UI.DISCARDS, {0.8, 0.45, 0.85, 1})
		play_sound('gong', 0.94, 0.3)
		play_sound('gong', 0.94*1.5, 0.2)
		play_sound('tarot1', 1.5)
	end,
	defeat = function()
		ease_colour(G.C.UI.HANDS, copy_table(G.C.BLUE))
        ease_colour(G.C.UI.DISCARDS, copy_table(G.C.RED))
	end,
	disable = function()
		ease_colour(G.C.UI.HANDS, copy_table(G.C.BLUE))
        ease_colour(G.C.UI.DISCARDS, copy_table(G.C.RED))
	end
}




local ease_discard_ref = ease_discard
function ease_discard(amt, ...)
	ease_discard_ref(amt, ...)
	if Spectrallib.blind_is("bl_entr_sigma") and not G._sigma_bypass and not G.GAME.blind.disabled then
		G._sigma_bypass = true
		ease_hands_played(amt, ...)
		G.E_MANAGER:add_event(Event{
			func = function()
				if G.GAME.current_round.hands_left <= 0 then
					end_round()
				end
				return true
			end
		})
		G._sigma_bypass = nil
	end
end

local ease_hands_ref = ease_hands_played
function ease_hands_played(amt, ...)
	ease_hands_ref(amt, ...)
	if Spectrallib.blind_is("bl_entr_sigma") and not G._sigma_bypass and not G.GAME.blind.disabled then
		G._sigma_bypass = true
		ease_discard(amt, ...)
		G._sigma_bypass = nil
	end
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+19,
	name = "entr-tau",
	key = "tau",
	pos = { x = 0, y = 18 },
	atlas = "altblinds",
	boss_colour = HEX("87c5b6"),
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
			Entropy.change_selection_limit(-1)
		end
	end,
	disable = function()
		Entropy.change_selection_limit(-G.GAME.tau)
		G.GAME.tau = nil
	end,
	defeat = function()
		if not G.GAME.blind.disabled then
			Entropy.change_selection_limit(-G.GAME.tau)
			G.GAME.tau = nil
		end
	end,
	set_blind = function()
		G.GAME.tau = G.GAME.tau or 0
		G.GAME.tau = G.GAME.tau + 1
		Entropy.change_selection_limit(1)
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+20,
	name = "entr-upsilon",
	key = "upsilon",
	pos = { x = 0, y = 19 },
	atlas = "altblinds",
	boss_colour = HEX("f3851b"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+21,
	name = "entr-phi",
	key = "phi",
	pos = { x = 0, y = 20 },
	atlas = "altblinds",
	boss_colour = Entropy.cmult_gradient,
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
        if not allowed[card.base.id] and card.base.id and card:is_playing_card() then
            return true
        end
        return false
    end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+22,
	name = "entr-chi",
	key = "chi",
	pos = { x = 0, y = 21 },
	atlas = "altblinds",
	boss_colour = HEX("655eb0"),
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

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+23,
	name = "entr-psi",
	key = "psi",
	pos = { x = 0, y = 22 },
	atlas = "altblinds",
	boss_colour = HEX("c3ba93"),
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
			if pseudorandom("psi_blind") < G.GAME.probabilities.normal / 2 then
				Entropy.flip_then({context.other_card}, function(card)
					card:set_ability(G.P_CENTERS.m_entr_disavowed)
				end)
			end
		end
	end,
	loc_vars = function() return {vars = {G.GAME.probabilities.normal}} end,
	collection_loc_vars = function() return {vars = {1}} end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1000+24,
	name = "entr-omega",
	key = "omega",
	pos = { x = 0, y = 23 },
	atlas = "altblinds",
	boss_colour = Entropy.pearl_gradient,
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
			local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
			if text == G.GAME.current_round.most_played_poker_hand then
				G.GAME.blind.triggered = true
				ease_blind_chips(G.GAME.blind.chips, {{"xchips", nil, 3}, {"chips1", nil, 4}})
			end
		end
	end,
	loc_vars = function() return {vars = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}} end,
	collection_loc_vars = function() return {vars = {"[most played hand]"}} end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1025+0,
	name = "entr-styx",
	key = "styx",
	pos = { x = 0, y = 0 },
	atlas = "altshowdowns",
	boss_colour = HEX("988f72"),
    mult=3,
    dollars = 10,
    altpath=true,
	boss = {
		min = 1,
		showdown = true
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
    set_blind = function()
		G.GAME.blind.fastened = G.GAME.cry_fastened
		G.GAME.cry_fastened = true
		G.GAME.entr_fastened = true
	end,
	disable = function()
		G.GAME.cry_fastened = G.GAME.blind.fastened
		G.GAME.entr_fastened = nil
	end,
	defeat = function()
		G.GAME.cry_fastened = G.GAME.blind.fastened
		G.GAME.entr_fastened = nil
	end,
	calculate = function(self, blind, context)
		if context.before and not G.GAME.blind.disabled then
			if #G.jokers.cards > 1 then
				local joker_1 = pseudorandom("styx_joker1", 1, #G.jokers.cards)
				local joker_2 = pseudorandom("styx_joker2", 1, #G.jokers.cards)
				local tries = 20
				while G.jokers.cards[joker_2] == G.jokers.cards[joker_1] and tries > 0 do
					joker_2 = pseudorandom("styx_joker2_repoll", 1, #G.jokers.cards)
					tries = tries - 1
				end
				local temp = G.jokers.cards[joker_2]
				G.jokers.cards[joker_2] = G.jokers.cards[joker_1]
				G.jokers.cards[joker_1] = temp
			end
			if #G.play.cards > 1 then
				local play_1 = pseudorandom("styx_play1", 1, #G.play.cards)
				local play_2 = pseudorandom("styx_play2", 1, #G.play.cards)
				local tries = 20
				while G.play.cards[play_2] == G.play.cards[play_1] and tries > 0 do
					play_2 = pseudorandom("styx_play2_repoll", 1, #G.play.cards)
					tries = tries - 1
				end
				local temp = G.play.cards[play_2]
				G.play.cards[play_2] = G.play.cards[play_1]
				G.play.cards[play_1] = temp
			end
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1025+1,
	name = "entr-choir",
	key = "choir",
	pos = { x = 0, y = 1 },
	atlas = "altshowdowns",
	boss_colour = HEX("b2bbaa"),
    mult=2,
    dollars = 10,
    altpath=true,
	boss = {
		min = 1,
		showdown = true
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	calculate = function(self, blind, context)
		if context.post_trigger and not context.other_card.debuff and not G.GAME.blind.disabled then
			context.other_card:set_debuff(true)
			context.other_card:juice_up()
			G.GAME.blind.triggered = true
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1025+2,
	name = "entr-pandora",
	key = "pandora",
	pos = { x = 0, y = 2 },
	atlas = "altshowdowns",
	boss_colour = HEX("4e2252"),
    mult=3,
    dollars = 10,
    altpath=true,
	boss = {
		min = 1,
		showdown = true
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	loc_vars = function()
		return {vars = {2*G.GAME.probabilities.normal}}
	end,
	collection_loc_vars = function ()
		return {vars = {2}}
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1025+3,
	name = "entr-cassandra",
	key = "cassandra",
	pos = { x = 0, y = 3 },
	atlas = "altshowdowns",
	boss_colour = HEX("7f3127"),
    mult=3,
    dollars = 10,
    altpath=true,
	boss = {
		min = 1,
		showdown = true
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	loc_vars = function()
		return {vars = {G.GAME.probabilities.normal}}
	end,
	collection_loc_vars = function ()
		return {vars = {1}}
	end,
	calculate = function(self, blind, context)
		if context.before and not G.GAME.blind.disabled then
			for i, v in ipairs(G.jokers.cards) do
				if pseudorandom("cassandra") < G.GAME.probabilities.normal / (5) then
					v:set_debuff(true)
					G.GAME.blind.triggered = true
					v:juice_up()
				end
			end
		end
	end
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 1025+4,
	name = "entr-labyrinth",
	key = "labyrinth",
	pos = { x = 0, y = 4 },
	atlas = "altshowdowns",
	boss_colour = HEX("acb1b6"),
    mult=3,
    dollars = 10,
    altpath=true,
	boss = {
		min = 1,
		showdown = true
	},
    in_pool = function()
        return G.GAME.entr_alt
    end,
	set_blind = function()
		Entropy.handle_card_limit(G.hand, 3)
		Entropy.change_selection_limit(1)
		G.GAME.blind.cards = {}
	end,
	defeat = function()
		if not G.GAME.blind.disabled then
			Entropy.handle_card_limit(G.hand, -3)
			Entropy.change_selection_limit(-1)
			for i, v in ipairs(G.GAME.blind.cards) do v.ability.forced_selection = nil end
		end
	end,
	disable = function()
		Entropy.handle_card_limit(G.hand, -3)
		Entropy.change_selection_limit(-1)
		for i, v in ipairs(G.GAME.blind.cards) do v.ability.forced_selection = nil end
	end
}
local highlighted_ref = Card.highlight
function Card:highlight(is_highlighted)
	highlighted_ref(self, is_highlighted)
	if Entropy.blind_is("bl_entr_labyrinth") then
		if is_highlighted and self.area == G.hand then
			if not self.ability.forced_selection then
				local cards = {}
				for i, v in ipairs(G.hand.cards) do
					if not v.ability.forced_selection and not v.highlighted then
						cards[#cards+1]=v
					end
				end
				local card = pseudorandom_element(cards, pseudoseed("labyrinth"))
				if card then
					card.ability.forced_selection = true
					G.GAME.blind.cards[#G.GAME.blind.cards + 1] = card
					card:highlight(true)
				end
				G.GAME.blind.cards[#G.GAME.blind.cards + 1] = self 
			end
			self.ability.forced_selection = true
		end
	end
end

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 998,
	key = "small",
	pos = { x = 0, y = 24 },
	atlas = "altblinds",
	boss_colour = HEX("3a55ab"),
    mult=1,
    dollars = 3,
    altpath=true,
	small = {min = 1,},
	name = "entr-Small Blind",
    in_pool = function()
        return G.GAME.entr_alt
    end,
}

Entropy.Blind{
	dependencies = {
        items = {
          "set_entr_altpath"
        }
    },
	
    order = 999,
	key = "big",
	pos = { x = 0, y = 25 },
	atlas = "altblinds",
	boss_colour = HEX("e0a23a"),
    mult=1.5,
    dollars = 4,
    altpath=true,
	name = "entr-Big Blind",
	small = {min = 1,},
    in_pool = function()
        return G.GAME.entr_alt
    end,
}
