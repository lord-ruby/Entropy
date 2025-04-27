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
SMODS.Shader({
    key="fractured",
    path="fractured.fs"
})
SMODS.Edition({
    key="fractured",
    shader="fractured",
    config = {
        retrig = 3
    },
	sound = {
		sound = "entr_e_solar",
		per = 1,
		vol = 0.4,
	},
    badge_color = HEX("fca849"),
	disable_base_shader=true,
    loc_vars = function(self,q,card)
        return {vars={card and card.edition and card.edition.retrig or 3}}
    end,
    calculate = function(self, card, context)
		if (
			context.edition
			and context.cardarea == G.jokers
		) or (
			context.main_scoring
			and context.cardarea == G.play
		) then
			local res = { message = localize("cry_demicolon") }
			local cards = Entropy.GetRandomCards({G.jokers, G.hand, G.consumeables, G.play}, card and card.edition and card.edition.retrig or 3, "fractured", function(card) return not card.edition or card.edition.key ~= "e_entr_fractured" end)
			for i, v in pairs(cards) do
				if Cryptid.demicolonGetTriggerable(v) and (not v.edition or v.edition.key ~= "e_entr_fractured") then
					local results = Cryptid.forcetrigger(v, context)
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					card_eval_status_text(
						v,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("cry_demicolon"), colour = G.C.GREEN }
					)
				elseif v.base.id then
					local results = eval_card(v, {cardarea=G.play,main_scoring=true})
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					local results = eval_card(v, {cardarea=G.hand,after=true})
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					card_eval_status_text(
						v,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("cry_demicolon"), colour = G.C.GREEN }
					)
				end
			end
			return res
		end
	end,
	entr_credits = {
		custom={key="shader",text="cassknows"}
	}
})
