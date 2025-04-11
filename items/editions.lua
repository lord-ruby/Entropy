SMODS.Edition({
    key="solar",
    shader=false,
    config = {
        sol = 1.4
    },
    badge_color = HEX("fca849"),
    loc_vars = function(self,q,card)
        return {vars={card.edition.sol or 1}}
    end,
    calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { asc = card.edition.sol or 1 } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
})