local flesh = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 10000+1,
	object_type = "Enhancement",
	key = "flesh",
	atlas = "enhancements",
	pos = { x = 0, y = 0 },
    config = {
		extra = {
            numerator = 3,
			odds = 4,
		},
	},
	weight = 2,
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.cry_rigged and card.ability.extra.odds or (G.GAME.probabilities.normal*(card.ability.extra.numerator or 3)),
				card.ability.extra.odds,
            }
		}
	end,
	calculate = function(self, card, context)
        if (context.pre_discard and context.cardarea == G.hand and card.highlighted
        and pseudorandom("flesh") < (card.ability.cry_rigged and card.ability.extra.odds or G.GAME.probabilities.normal*(card.ability.extra.numerator/card.ability.extra.odds))) then 
            card.ability.temporary2 = true
			card:remove_from_deck()
            card:start_dissolve()
			SMODS.calculate_context({remove_playing_cards = true, removed={card}})
        end
		if context.forcetrigger then
			card.ability.temporary2 = true
			card:remove_from_deck()
            card:start_dissolve()
			SMODS.calculate_context({remove_playing_cards = true, removed={card}})
		end
	end,
	entr_credits = {
		art = {"Lil. Mr. Slipstream"}
	}
}
local disavowed = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 10000+2,
	object_type = "Enhancement",
	key = "disavowed",
	atlas = "enhancements",
	pos = { x = 1, y = 0 },
	weight = 0,
	no_doe = true,
	set_ability = function(self,card) 
		card.ability.disavow = true
	end
}

local prismatic = {
	dependencies = {
        items = {
          "set_entr_entropics"
        }
    },
	order = 10000+4,
	object_type = "Enhancement",
	key = "prismatic",
	atlas = "enhancements",
	pos = { x = 0, y = 1 },
    config = {
		extra = {
            eemult = 1,
			eemult_mod = 0.01
		},
	},
	no_doe = true,
	upgrade_order = 9999,
	no_code = true,
	in_pool = function()
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.eemult,
				card.ability.extra.eemult_mod
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			card.ability.extra.eemult = card.ability.extra.eemult + card.ability.extra.eemult_mod
			return {
				eemult = card.ability.extra.eemult
			}
		end
	end,
	entr_credits = {
		art = {"Lil. Mr. Slipstream"}
	}
}

local dark = {
	dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	order = 6999,
	object_type = "Enhancement",
	key = "dark",
	atlas = "enhancements",
	pos = { x = 1, y = 1 },
    config = {
		xchips = 1,
		xchip_mod = 0.025
	},
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.xchip_mod,
				card.ability.xchips
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.main_scoring then
			local cards = {}
			local suits = {}
			for i, v in ipairs(G.play.cards) do
				if v.config.center.key == "m_cry_abstract" or v.config.center.key == "m_stone" or v.config.center.key == "m_wild" then
					if not suits[v.config.center.key] then
						suits[v.config.center.key] = true
						cards[#cards+1]=true
					end
				else
					if not suits[v.base.suit] then
						suits[v.base.suit] = true
						cards[#cards+1]=true
					end
				end
			end
			for i, v in ipairs(cards) do
				card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
				card.ability.xchips = card.ability.xchips + card.ability.xchip_mod
				delay(0.3)
			end
			return {
				xchips = card.ability.xchips
			}
		end
	end,
}

return {
    items = {
        flesh,
        disavowed,
		prismatic,
		dark
    }
}