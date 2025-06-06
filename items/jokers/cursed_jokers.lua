local jokerinyellow = {
    object_type = "Joker",
    order = 2500+6,
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
            odds = 6
        }
    },
    soul_pos = {x=9,y=1},
    loc_vars = function(self, q, card)
        q[#q+1] = {key ="entr_yellow_sign", set="Other"}
        q[#q+1] = {key ="temporary", set="Other"}
        return {
            vars = {
                math.min(cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged), card.ability.extra.odds),
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
                    delay = 0.2,
                    func = function()
                        local card = pseudorandom_element(cards, pseudoseed("kiy"))
                        if card then
                            eval_card(card, {banishing_card = true, banisher = card, card = card, cardarea = G.jokers})
                            card:start_dissolve()
                            G.GAME.banned_keys[card.config.center.key] = true
                            card_eval_status_text(
                                card,
                                "extra",
                                nil,
                                nil,
                                nil,
                                { message = localize("entr_kiy_banished"), colour = G.C.GREEN }
                            )
                        end
                        return true
                    end
                }))
            end
        end
        if context.after then
            local total = 0
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
                                card_eval_status_text(
                                    card,
                                    "extra",
                                    nil,
                                    nil,
                                    nil,
                                    { message = localize("entr_kiy_banished"), colour = G.C.GREEN }
                                )
                            end
                            return true
                        end
                    })) 
                end
            end
            for i, v2 in pairs(G.hand.cards) do
                if v2:is_suit("Diamonds") then
                    total = total + 1
                end
            end
            if total >= 7 then card:start_dissolve() end
        end
        if context.check then 
			for i, v in pairs(G.hand.cards) do if not v.highlighted then v.kiy_temp = false;v.kiy_temped = false end end
			for i, v in pairs(G.hand.highlighted) do
				v.kiy_temp = true
			end
            local cards = {}
            for i, v in pairs({G.hand.cards, G.jokers.cards, G.consumeables.cards}) do for i2, v2 in pairs(v) do cards[#cards+1] = v2 end end
			for i, v in pairs(G.hand.cards) do
				if v.kiy_temp and not v.kiy_temped and v:is_suit("Diamonds") then
					local card = pseudorandom_element(cards, pseudoseed("kiy"))
                    card.ability.temporary = true
					v.kiy_temp = false
					v.kiy_temped = true
				end
			end
		end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows"}
    }
}

local yellow_sign = {
    atlas = "entr_stickers",
    pos = { x = 5, y = 1 },
    key = "entr_yellow_sign",
    dependencies = {
        items = {
          "set_cry_cursed",
        }
    },
    object_type = "Sticker",
    order = 2500 + 6.66,
    no_sticker_sheet = true,
    prefix_config = { key = false },
    badge_colour = HEX("ffa200"),
    apply = function(self,card,val) 
        card.ability.entr_yellow_sign = true
    end,
    calculate = function(self, card, context)
        if context.after then
            card.ability.entr_yellow_sign = false
        end
    end
}
local suit_ref = Card.is_suit
function Card:is_suit(suit, ...)
    if self.ability.entr_yellow_sign and suit == "Diamonds" then return true 
    else return suit_ref(self, suit, ...) end
end
return {
    items = {
        jokerinyellow,
        yellow_sign
    }
} --yellow
