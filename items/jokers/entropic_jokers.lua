local epitachyno = {
    object_type = "Joker",
    order = "900",
    key = "epitachyno",
    atlas = "exotic_jokers",
    rarity = "entr_entropic"
    pos = {x=0,y=1},
    soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
    config = {
        exponent = 1.15,
        exponent_mod = 0.05
    },
    calculate = function(self, card2, context)
        if (context.ending_shop and not context.repetition and not context.individual) or context.forcetrigger then
			local check = false
            for i, v in pairs(G.jokers.cards) do
                local card = G.jokers.cards[i]
                if not Card.no(G.jokers.cards[i], "immutable", true) then
                    Cryptid.with_deck_effects(G.jokers.cards[i], function(card)
                        Cryptid.misprintize(card, { min = 2, max = 2 }, nil, true)
                    end)
                    check = true
                end
            end
			if check then
				card_eval_status_text(
					context.blueprint_card or card2,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
			end
            card.ability.exponent = card.ability.exponent + card.ability.exponent_mod
			return nil, true
		end
    end
}


return {
    items = {
        epitachyno
    }
}