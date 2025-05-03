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
                        eval_card(card, {banishing_card = true, banisher = card, card = card, cardarea = G.jokers})
                        card:start_dissolve()
                        G.GAME.banned_keys[card.config.center.key] = true
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
                            eval_card(card, {banishing_card = true, banisher = card, card = card, cardarea = G.jokers})
                            card:start_dissolve()
                            G.GAME.banned_keys[card.config.center.key] = true
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

function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    percent = percent or 50
    delay = delay or 0.1 
    if dir == 'down' then 
        percent = 1-percent
    end
    sort = sort or false
    local drawn = nil

    G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = delay,
        func = function()
            if card then 
                if from then card = from:remove_card(card) end
                if card then drawn = true end
                local stay_flipped = G.GAME and G.GAME.blind and G.GAME.blind:stay_flipped(to, card, from)
                if G.GAME.modifiers.flipped_cards and to == G.hand then
                    if pseudorandom(pseudoseed('flipped_card')) < 1/G.GAME.modifiers.flipped_cards then
                        stay_flipped = true
                    end
                end
                to:emplace(card, nil, stay_flipped)
            else
                card = to:draw_card_from(from, stay_flipped, discarded_only)
                if card then drawn = true end
            end
            if not mute and drawn then
                if from == G.deck or from == G.hand or from == G.play or from == G.jokers or from == G.consumeables or from == G.discard then
                    G.VIBRATION = G.VIBRATION + 0.6
                end
                play_sound('card1', 0.85 + percent*0.2/100, 0.6*(vol or 1))
            end
            if sort then
                to:sort()
            end
            SMODS.drawn_cards = SMODS.drawn_cards or {}
            if card and card.playing_card then 
                SMODS.drawn_cards[#SMODS.drawn_cards+1] = card 
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_entr_jokerinyellow" then
                        if pseudorandom("kiy") / 2
                        < cry_prob(v.ability.cry_prob, v.ability.extra.odds, v.ability.cry_rigged)
                            / v.ability.extra.odds then
                            SMODS.change_base(card, "Diamonds")
                        end
                        local total = 0
                        for i, c in pairs(G.hand.cards) do
                            if c:is_suit("Diamonds") then total = total + 1 end
                        end
                        if total >= 8 then v:start_dissolve() end
                    end
                end
            end
            return true
        end
      }))
end
return {
    items = {
        jokerinyellow
    }
}
