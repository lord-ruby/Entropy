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
            local cards = {}
            local jollycount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_jolly() then
                    jollycount = jollycount + 1
                end
            end
            for i = 1, 1+jollycount do
                cards[#cards+1] = G.play.cards[i] or nil
            end
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if next(poker_hands["Pair"]) then
               Entropy.FlipThen(cards, function(card)
                    card:set_edition("e_entr_solar")
               end)
            end
        end
        if context.forcetrigger then
            local cards = {}
            local jollycount = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i]:is_jolly() then
                    jollycount = jollycount + 1
                end
            end
            for i = 1, 1+jollycount do
                cards[#cards+1] = G.play.cards[i] or nil
            end
            Entropy.FlipThen(cards, function(card)
                card:set_edition("e_entr_solar")
            end)
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
    demicoloncompat = true,
    pos = { x = 0, y = 0 },
    atlas = "antireal_joker",
    config = {
        exp_per_slot = 1
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.exp_per_slot,
                G.jokers and (G.jokers.config.card_limit - #G.jokers.cards + (Entropy.HasJoker("j_entr_antireal") or 0)) * card.ability.exp_per_slot or 1
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            local num = (G.jokers.config.card_limit - #G.jokers.cards + Entropy.HasJoker("j_entr_antireal") or 0) * card.ability.exp_per_slot
            if to_big(num) > to_big(0) then
                return {
                    x_asc = num
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			Cryptid.notification_overlay("antireal")
		end
	end,
    entr_credits = {
	idea = {"cassknows"},
	art = {"notmario", "cassknows"}
    }
}

local jokezmann_brain = {
    order = 106,
    object_type = "Joker",
    key = "jokezmann_brain",
    rarity = "cry_epic",
    cost = 15,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    eternal_compat = true,
    demicoloncompat = true,
    pos = { x = 5, y = 2 },
    atlas = "jokers",
    config = {
        extra = {
            odds = 3
        }
    },
    pos = { x = 5, y = 2 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        if not card.edition or card.edition.key ~= "e_cry_oversat" then
            info_queue[#info_queue+1]=G.P_CENTERS.e_cry_oversat
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function (self, card, context)
        if context.ending_shop or context.forcetrigger then
            if G.jokers.config.card_limit - #G.jokers.cards > 0 then
                for i = 1, G.jokers.config.card_limit - #G.jokers.cards do
                    if SMODS.pseudorandom_probability(card, 'jokezmann', 1, card.ability.extra.odds) then
                        local card = create_card("Joker", G.jokers)
                        card:set_edition("e_cry_oversat")
                        card:add_to_deck()
                        card.ability.perishable = true
                        card.ability.perish_tally = 5
                        G.jokers:emplace(card)
                    end
                end
            end
        end
    end,
    entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}

local metamorphosis = {
    order = 107,
    object_type = "Joker",
    key = "metamorphosis",
    rarity = "cry_epic",
    cost = 15,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    eternal_compat = true,
    demicoloncompat = true,
    pos = { x = 0, y = 4 },
    atlas = "jokers",
    config = {
        extra = {
            immutable = {
                rank = nil
            }
        }
    },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card2)
        if not card2.ability.immutable then card2.ability.immutable = {} end
        if not card2.ability.immutable.rank and G.deck then
            local card = pseudorandom_element(G.deck.cards, pseudoseed("metamorphosis"))
            if not card then card = pseudorandom_element(G.hand.cards, pseudoseed("metamorphosis")) end
            if not card then card = pseudorandom_element(G.play.cards, pseudoseed("metamorphosis")) end
            if card then
                card2.ability.immutable.rank = card:get_id()
            end
        end
        if G.jokers then
            local ranks = {
                [14] = "Ace",
                [13] = "King",
                [12] = "Queen",
                [11] = "Jack"
            }
            return {
                vars = {
                    G.localization.misc.ranks[ranks[card2.ability.immutable.rank] or tostring(card2.ability.immutable.rank) or ""]
                }
            }
        end
        return {
            vars = {
                "[Rank]"
            }
        }
    end,
    blueprint_compat=true,
    calculate = function (self, card2, context)
        if context.after then
            local card = pseudorandom_element(G.deck.cards, pseudoseed("metamorphosis"))
            if not card then card = pseudorandom_element(G.hand.cards, pseudoseed("metamorphosis")) end
            if not card then card = pseudorandom_element(G.play.cards, pseudoseed("metamorphosis")) end
            if not card2.ability.immutable then card2.ability.immutable = {} end
            if card then
                card2.ability.immutable.rank = card:get_id()
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card then
            if card2.ability.immutable and context.other_card:get_id() == card2.ability.immutable.rank then
                if not context.retrigger_joker then card2:juice_up() end
                return {
                    func = function()
                        context.joker_main = true
                        context.cardarea = G.jokers
                        local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = G.FUNCS.get_poker_hand_info(G.play.cards)
                        for i, v in pairs(G.jokers.cards) do
                          local res = eval_card(v, {cardarea = G.jokers, joker_main = true, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands})
                          if res and res.jokers then 
                            res = res.jokers
                            for i2, v2 in pairs(res) do
                              if i2 ~= "message" and i2 ~= "colour" then
                                SMODS.calculate_individual_effect({[i2] = v2}, v, i2, v2, false)
                              end
                            end
                            card_eval_status_text(context.other_card, "extra", nil, nil, nil, res)
                          end
                        end
                        context.joker_main = nil
                        context.cardarea = G.play
                    end
                }
            end
            return nil, true
        end
    end,
    entr_credits = {
        art = {"Lfmoth"}
    }
}

local nyctophobia = {
    order = 108,
    object_type = "Joker",
    key = "nyctophobia",
    rarity = "cry_epic",
    cost = 15,
    
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    eternal_compat = true,
    demicoloncompat = true,
    pos = { x = 2, y = 4 },
    soul_pos = {x = 3, y = 4},
    atlas = "jokers",
    loc_vars = function(self, info_queue, card2)
        info_queue[#info_queue+1] = G.P_CENTERS.m_entr_dark
    end,
    blueprint_compat=true,
    calculate = function (self, card2, context)
        if context.setting_blind or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local cons = pseudorandom_element(G.consumeables.cards, pseudoseed("nyctophobia"))
                    if cons then
                        G.GAME.entr_used_cards = G.GAME.entr_used_cards or {}
                        cons:start_dissolve()
                        local num = (G.GAME.entr_used_cards[cons.config.center.key] or 0)*2
                        if cons.getQty then
                            num = num * cons:getQty()
                        end
                        for i = 1, math.max(to_number(math.min(num, 50)), 2) do
                            local card = SMODS.create_card{
                                set = "Enhanced",
                                key = "m_entr_dark"
                            }
                            SMODS.change_base(card, pseudorandom_element({"Spades", "Clubs", "Diamonds", "Hearts"}, pseudoseed("nyctophobia_suit")),
                            pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("nyctophobia_rank")))
                            G.hand:emplace(card)
                            table.insert(G.playing_cards, card)
                        end
                    elseif context.forcetrigger then
                        for i = 1, 2 do
                            local card = SMODS.create_card{
                                set = "Enhanced",
                                key = "m_entr_dark"
                            }
                            SMODS.change_base(card, pseudorandom_element({"Spades", "Clubs", "Diamonds", "Hearts"}, pseudoseed("nyctophobia_suit")),
                            pseudorandom_element({"2", "3", "4", "5", "6", "7", "8", "9", "10", "Ace", "King", "Queen", "Jack"}, pseudoseed("nyctophobia_rank")))
                            G.hand:emplace(card)
                            table.insert(G.playing_cards, card)
                        end
                    end
                    return true
                end
            }))
            return nil, true
        end
    end,
    entr_credits = {
        idea = {"axo"},
        art = {"Lil. Mr. Slipstream"},
    }
}

local caviar = {
    order = 108,
    object_type = "Joker",
    key = "caviar",
    rarity = "cry_epic",
    cost = 15,
    config = {
        tags = 8
    },
    dependencies = {
        items = {
            "set_cry_epic"
        }
    },
    eternal_compat = true,
    pos = {x = 3, y = 0},
    atlas = "placeholder",
    loc_vars = function(self, info_queue, card2)
        return {
            vars = {
                card2.ability.tags
            }
        }
    end,
    pools = {["Food"] = true},
    calculate = function (self, card, context)
        if context.tag_create and Entropy.AscendedTags[context.tag.key] then
            card.ability.tags = card.ability.tags - 1
            if to_number(card.ability.tags) <= 0.00000001 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound("tarot1")
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true
							end,
						}))
						return true
					end,
				}))
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_eaten_ex"), colour = G.C.RARITY.cry_epic }
                )
                return
            end
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_ascended_ex"), colour = G.C.RARITY.cry_epic }
            )
            return {
                tag = Entropy.AscendedTags[context.tag.key] and Tag(Entropy.AscendedTags[context.tag.key])
            }
        end
    end,
}

return {
    items = {
        burnt_m,
        chaos,
        dni,
        trapezium,
        antireal,
        jokezmann_brain,
        metanoia,
        metamorphosis,
        nyctophobia,
        caviar
    }
}