local epitachyno = {
    object_type = "Joker",
    order = 900,
    key = "epitachyno",
    atlas = "exotic_jokers",
    rarity = "entr_entropic",
    pos = {x=0,y=1},
    soul_pos = { x = 1, y = 1, extra = { x = 2, y = 1 } },
    config = {
        extra = 1.1,
        exp_mod = 0.05
    },
    dependencies = {
        items={"set_entr_entropics"}
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

local helios = {
    order = 401,
    object_type = "Joker",
    key = "helios",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    config = {
        extra = 1.1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                1.75 + ((G.GAME.sunnumber or 0)),
                (card.ability.extra or 1.1) + 0.4
            },
        }
    end,
    add_to_deck = function()
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 308
        G.GAME.HyperspaceActuallyUsed = G.GAME.used_vouchers.v_cry_hyperspacetether
        G.GAME.used_vouchers.v_cry_hyperspacetether = true
    end,
    remove_from_deck = function()
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 308
        G.GAME.used_vouchers.v_cry_hyperspacetether = G.GAME.HyperspaceActuallyUsed
    end
}

local xekanos = {
    order = 402,
    object_type = "Joker",
    key = "xekanos",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    config = {
        ante_mod = 1.5,
        ante_mod_mod = 0.1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    immutable = true,
    demicoloncompat = true,
    soul_pos = { x = 2, y = 3, extra = { x = 1, y = 3 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.ante_mod > 0 and "-"..card.ability.ante_mod or 1,
                card.ability.ante_mod > 0 and card.ability.ante_mod_mod or 0
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.selling_card and not context.retrigger_joker) or context.forcetrigger then
            if not context.card then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            elseif context.card.ability.set == "Joker" and Entropy.RarityAbove("3",context.card.config.center.rarity,true) then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            end
        end
    end
}

return {
    items = {
        epitachyno,
        helios,
        xekanos
    }
}