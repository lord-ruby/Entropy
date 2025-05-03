local jokerinyellow = {
    object_type = "Joker",
    order = -666,
    dependencies = {
		items = {
			"set_cry_cursed",
		},
	},
    key = "jokerinyellow",
    rarity = "cry_cursed",
    atlas = "jokers",
    pos = {x=8,y=1},
    cost=0,
    blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
    demicoloncompat = true,
    no_dbl = true,
    config = {
        extra = {
            odds = 7
        }
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                math.min(cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged)*2, card.ability.extra.odds),
                card.ability.extra.odds,
            }
        }
    end,
	calculate = function(self, card, context)
        if context.forcetrigger then
            if context.forcetrigger then
                local cards = {}
                for i, v in pairs(G.jokers.cards) do
                    if not v.ability.eternal and not v.ability.cry_absolute and v.config.center.key ~= "j_entr_jokerinyellow" then
                        cards[#cards+1]=v
                    end
                end

                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = delay,
                    func = function()
                        local card = pseudorandom_element(cards, pseudoseed("kiy"))
                        if card then
                            eval_card(card, {banishing_card = true, banisher = card, card = card, cardarea = G.jokers})
                            card:start_dissolve()
                            G.GAME.banned_keys[card.config.center.key] = true
                        end
                        return true
                    end
                }))
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("entr_kiy_banished"), colour = G.C.GREEN }
                )
            end
        end
        if context.after then
            for i, v2 in pairs(G.play.cards) do
                if v2:is_suit("Diamonds") then
                    local cards = {}
                    for i, v in pairs(G.jokers.cards) do
                        if not v.ability.eternal and not v.ability.cry_absolute and v.config.center.key ~= "j_entr_jokerinyellow" then
                            cards[#cards+1]=v
                        end
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            local card = pseudorandom_element(cards, pseudoseed("kiy"))
                            if card then
                                eval_card(card, {banishing_card = true, banisher = card, card = card, cardarea = G.jokers})
                                card:start_dissolve()
                                G.GAME.banned_keys[card.config.center.key] = true
                            end
                            return true
                        end
                    })) 
                    card_eval_status_text(
                        card,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("entr_kiy_banished"), colour = G.C.GREEN }
                    )
                end
            end
        end
    end
}

return {
    items = {
        jokerinyellow
    }
}
