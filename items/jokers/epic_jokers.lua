local burnt_m = {
    order = 100,
    object_type = "Joker",
    key = "burnt_m",
    config = {
        per_jolly=1
    },
    rarity = "cry_epic",
    cost = 10,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    atlas = "jokers",
    pools = { ["M"] = true },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.sol) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
		end
        info_queue[#info_queue+1] = G.P_CENTERS.e_cry_m
        return {
            vars = {
                center.config.per_jolly
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then

            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if next(poker_hands["Pair"]) then
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                    G.play.cards[1]:set_edition("e_entr_solar")
                    return true
                end}))
                local jollycount = 0
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i]:is_jolly() then
                        jollycount = jollycount + 1
                    end
                end
                if jollycount > 0 then
                    for i = 2, 2+jollycount do
                        local card2 = G.play.cards[i]
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                            if card2 then card:set_edition("e_entr_solar") end
                            return true
                        end}))
                    end
                end
            end
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                G.play.cards[1]:set_edition("e_entr_solar")
                return true
            end}))
            local jollycount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_jolly() then
                    jollycount = jollycount + 1
                end
            end
            if jollycount > 0 then
                for i = 2, 2+jollycount do
                    local card2 = G.play.cards[i]
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                        if card2 then card:set_edition("e_entr_solar") end
                        return true
                    end}))
                end
            end
        end
	end
}

local chaos= {
    order = 101,
    object_type = "Joker",
    key = "chaos",
    rarity = "cry_epic",
    cost = 15,
    unlocked = true,

    eternal_compat = true,
    pos = { x = 0, y = 1 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, center)
    end,
}

local dni = {
    order = 102,
    object_type = "Joker",
    key = "dni",
    config = {
        suit = "Spades"
    },
    rarity = "cry_epic",
    cost = 10,
    unlocked = true,

    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.suit or "Spades",
                colours = {
                    G.C.SUITS[card.ability.suit or "Spades"]
                }
            },
        }
    end,
    calculate = function (self, card, context)
        if context.destroy_card and (context.cardarea == G.play) then
            if context.destroy_card:is_suit(card.ability.suit) then
                return {remove = true}
            end
        end
        if context.after then
            card.ability.suit = pseudorandom_element(G.deck.cards, pseudoseed("dni")).base.suit
        end
    end,
    entr_credits = {
        art = {"cassknows"}
    }
}

local trapezium = {
    order = 103,
    object_type = "Joker",
    key = "trapezium_cluster",
    name="entr-trapezium_cluster",
    config = {
        forcetrigger=5
    },
    rarity = "cry_epic",
    cost = 10,
    unlocked = true,

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.retrig) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_fractured
		end
        return {
            vars = {
                number_format(center.ability.forcetrigger)
            },
        }
    end,
    calculate = function(self, card, context)
        --if forcetrigger > 30 then forcetrigger = 30 end
		if
			(context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.retrig
			and card ~= context.other_joker)
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
            return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5)
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.retrig then
				return {
					asc = lenient_bignum(card.ability.asc),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			(context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.retrig
			and not context.end_of_round)
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
                return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5)
			end
		end
        if context.forcetrigger then
            return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5)
        end
	end
}
return {
    items = {
        burnt_m,
        chaos,
        dni,
        trapezium_cluster
    }
}