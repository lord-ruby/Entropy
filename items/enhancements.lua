SMODS.Atlas { key = 'enhancements', path = 'enhancements.png', px = 71, py = 95 }
SMODS.Enhancement({
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
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.cry_rigged and card.ability.extra.odds or (G.GAME.probabilities.normal*(card.ability.extra.numerator or 3)),
				card.ability.extra.odds,
            }
		}
	end,
	calculate = function(self, card, context)
        if context.destroy_card and (context.cardarea == G.play or context.cardarea == "unscored")
        and pseudorandom("flesh") < (card.ability.cry_rigged and card.ability.extra.odds or G.GAME.probabilities.normal*(card.ability.extra.numerator/card.ability.extra.odds)) then 
            return { remove = true } 
        end
	end,
})