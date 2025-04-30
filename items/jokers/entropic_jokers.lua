local epitachyno = {
    object_type = "Joker",
    order = "900",
    key = "epitachyno",
    atlas = "exotic_jokers",
    rarity = "entr_entropic",
    pos = {x=0,y=1},
    soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
    config = {
        extra = 1.1,
        exp_mod = 0.05
    },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
                card.ability.exp_mod
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.ending_shop and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
            for i, v in pairs(G.jokers.cards) do
                local check = false
                local exp = card.ability.extra
			    --local card = G.jokers.cards[i]
                if not Card.no(G.jokers.cards[i], "immutable", true) and (G.jokers.cards[i].config.center.key ~= "j_entr_epitachyno" or context.forcetrigger) then
                    Cryptid.with_deck_effects(v, function(card2)
                        Cryptid.misprintize(card2, { min=exp,max=exp }, nil, true, "^", 1)
                    end)
                    check = true
                end
			    if check then
				    card_eval_status_text(
					context.blueprint_card or G.jokers.cards[i],
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				    )
                end
            end
            card.ability.extra = card.ability.extra + card.ability.exp_mod
        end
    end
}


return {
    items = {
        epitachyno
    }
}