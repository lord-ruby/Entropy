local burnt_m = {
    order = 100,
    object_type = "Joker",
    key = "burnt_m",
    config = {
        per_jolly=1
    },
    rarity = "cry_epic",
    cost = 10,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
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
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
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
            local card2 = pseudorandom_element(G.deck.cards, pseudoseed("dni"))
            card.ability.suit = card2 and card2.base.suit or card.ability.suit
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
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
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
            return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5, context)
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.retrig then
                return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5, context)
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
                return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5, context)
			end
		end
        if context.forcetrigger then
            return Entropy.RandomForcetrigger(card, card and card.ability.forcetrigger or 5, context)
        end
	end
}

local metanoia = {
    order = 104,
    object_type = "Joker",
    key = "metanoia",
    rarity = "cry_epic",
    cost = 10,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 5, y = 0 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1]=G.P_CENTERS.m_entr_flesh
    end,
    calculate = function (self, card, context)
        if (context.pre_discard) then
            Entropy.FlipThen(G.hand.highlighted, function(card)
                card:set_ability(G.P_CENTERS.m_entr_flesh)
            end)
        end
    end,
}
SMODS.Atlas { key = 'antireal_joker', path = 'antireal_joker.png', px = 71, py = 95 }
local antireal = {
    order = 105,
    object_type = "Joker",
    key = "antireal",
    rarity = "cry_epic",
    cost = 15,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    atlas = "antireal_joker",
    config = {
        exp_per_slot = 1
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.exp_per_slot,
                G.jokers and (G.jokers.config.card_limit - #G.jokers.cards + (HasJoker("j_entr_antireal") or 0)) * card.ability.exp_per_slot or 1
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                exp_asc = (G.jokers.config.card_limit - #G.jokers.cards + HasJoker("j_entr_antireal") or 0) * card.ability.exp_per_slot
            }
        end
    end,
    entr_credits = {
	idea = {"cassknows"},
	art = {"notmario", "cassknows"}
    }
}
return {
    items = {
        burnt_m,
        chaos,
        dni,
        trapezium,
        metanoia,
        antireal
    }
}
