SMODS.Atlas { key = 'enhancements', path = 'enhancements.png', px = 71, py = 95 }
local flesh = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 1,
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
			SMODS.calculate_context({remove_playing_cards = true, removed={card}})
		end
	end,
}

local disavowed = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 2,
	object_type = "Enhancement",
	key = "disavowed",
	atlas = "enhancements",
	pos = { x = 1, y = 0 },
	weight = 0,
	set_ability = function(self,card) 
		card.ability.disavow = true
	end
}

return {
	items = {
		flesh,
		disavowed
	}
}