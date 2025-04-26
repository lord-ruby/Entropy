SMODS.Shader({
    key="solar",
    path="solar.fs"
})
SMODS.Sound({
	key = "e_solar",
	path = "e_solar.ogg",
})

SMODS.Edition({
    key="solar",
    shader="solar",
    config = {
        sol = 1.4
    },
	sound = {
		sound = "entr_e_solar",
		per = 1,
		vol = 0.4,
	},
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
        return {vars={card and card.edition and card.edition.sol or 1.4}}
    end,
    calculate = function(self, card, context)
		if
			(
				context.edition
				and context.cardarea == G.jokers
				and card.config.trigger
			) or (
				context.main_scoring
				and context.cardarea == G.play
			)
		then
			return { asc = card and card.edition and card.edition.sol or 1.4 }
		end
		if context.joker_main then
			card.config.trigger = true
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
})

AurinkoAddons.entr_solar = function(card, hand, instant, amount)
	if to_big(G.GAME.hands[hand].AscensionPower or 0) > to_big(0) then
		local num = G.GAME.hands[hand].AscensionPower * (card.edition.sol-1)
		Entropy.ReversePlanetUse(hand, card, num)
	end
end