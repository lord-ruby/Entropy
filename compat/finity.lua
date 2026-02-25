if FinisherBossBlindStringMap then

    local ee_hand_funcs = {
        function(self, card, context)
            if context.joker_main then
                local card = pseudorandom_element(G.playing_cards, pseudoseed("ee_hand1"))
                card:set_edition("e_entr_sunny")
            end
        end,
        function(self, card, context)
            G.GAME.nodebuff = true
        end,
        function(self, card, context)
            if context.joker_main then
                for i, v in ipairs(G.jokers.cards) do
                    local card = G.jokers.cards[i]
                    if not Card.no(card, "immutable", true) then
                        Cryptid.manipulate(G.jokers.cards[i], { value = 1.66 })
                        check = true
                    end
                end
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
            end
        end,
        function(self, card, context)
            if context.joker_main then
                local res = {}
                if #G.jokers.cards > 1 then
                    local v = pseudorandom_element(G.jokers.cards, pseudoseed("ee_hand4"))
                    while v == card do
                        v = pseudorandom_element(G.jokers.cards, pseudoseed("ee_hand4"))
                    end
                    if Cryptid.demicolonGetTriggerable(v)then
                        local results = Cryptid.forcetrigger(v, context)
                        if results then
                            for i, v in pairs(results) do
                                for i2, result in pairs(v) do
                                    if Entropy.is_number(result) then
                                        res[i2] = Entropy.stack_eval_returns(res[i2], result, i2)
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
            end
        end
    }

    local ee_discard_funcs = {
        function(self, card, context)
            if context.pre_discard then
                if #G.hand.highlighted == 1 then
                    local cards = {}
                    for i, v in ipairs(G.hand.cards) do if not v.highlighted then cards[#cards+1] = v end end
                    pseudoshuffle(cards, pseudoseed('ee_discard1'))
                    local actual = {}
                    for i = 1, 2 do
                        actual[i] = cards[i]
                    end
                    Entropy.flip_then(actual, function(card)
                        card:set_edition(G.hand.highlighted[1] and G.hand.highlighted[1].edition and G.hand.highlighted[1].edition.key)
                    end)
                end
            end
        end,
        function(self, card, context)
            if context.joker_main then
                for i, v in ipairs(G.play.cards) do
                    local card2 = copy_card(v)
                    card2.ability.banana = true
                    card2:add_to_deck()
                    G.hand:emplace(card2)
                    card2:set_edition("e_negative")
                    table.insert(G.playing_cards, card2)
                end
            end
        end,
        function(self, card, context)
            if context.pre_discard then
                for i = 1, #G.hand.highlighted do
                    add_tag(Tag(pseudorandom_element(Entropy.AscendedTags, pseudoseed("ee_discard3"))))
                end
            end
        end,
        function(self, card, context)
            if context.joker_main then
                return {
                    emult = 3
                }
            end
        end,
    }

    local endless_entropy = {
        object_type = "Joker",
        key = "endlessentropy",
        order = 10^300,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "ee_atlas",
        pos = {x=0, y=0},
        soul_pos = {x = 4, y = 3, extra = {x=0,y=1}},
        entr_credits = {
            art = {"missingnumber"}
        },
        loc_vars = function(self, q, card)
            return {
                vars = {
                    localize("k_ee_hand_"..(card.ability.immutable.ee_handeffect or 1)),
                    localize("k_ee_discard_"..(card.ability.immutable.ee_discardeffect or 1))
                }
            }
        end,
        config = {
            immutable = {
                ee_discardeffect = 1,
                ee_handeffect = 1
            }
        },
        calculate = function(self, card, context)
            local ret = {}
            local ret1 = ee_hand_funcs[card.ability.immutable.ee_handeffect or 1](self, card, context)
            local ret2 = ee_discard_funcs[card.ability.immutable.ee_discardeffect or 1](self, card, context)
            for i, v in pairs(ret1 or {}) do ret[i]=v end
            for i, v in pairs(ret2 or {}) do ret[i]=v end
            if context.joker_main then
                G.GAME.nodebuff = false
                card.ability.immutable.ee_handeffect = (card.ability.immutable.ee_handeffect or 1) + 1
                if card.ability.immutable.ee_handeffect > 4 then card.ability.immutable.ee_handeffect = 1 end
                if card.ability.immutable.ee_handeffect == 2 then G.GAME.nodebuff = true end
                card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y= (card.ability.immutable.ee_discardeffect or 1)-1})
            end
            if context.pre_discard then
                card.ability.immutable.ee_discardeffect = (card.ability.immutable.ee_discardeffect or 1) + 1
                if card.ability.immutable.ee_discardeffect > 4 then card.ability.immutable.ee_discardeffect = 1 end
                card.children.floating_sprite2:set_sprite_pos({x=1, y=(card.ability.immutable.ee_discardeffect or 1)-1})
                card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y= (card.ability.immutable.ee_discardeffect or 1)-1})
            end
            if ret1 or ret2 then return ret end
        end,
        in_pool = function()
            return false
        end,
        add_to_deck = function(self, card)
            card.children.floating_sprite2:set_sprite_pos({x=1,y=0})
            card.children.floating_sprite:set_sprite_pos({x=pseudorandom_element({2,3,4}, pseudoseed("ee_X")), y = 0})
        end
    }


    local scarlet_sun = {
        object_type = "Joker",
        key = "scarlet_sun",
        order = 10^10 + 1,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=0},
        soul_pos = {x = 1, y = 0},
        entr_credits = {
            art = {"missingnumber"}
        },
        config = {
            asc_power = 1
        },
        loc_vars = function(self, q, card)
            q[#q+1] = G.P_CENTERS.e_entr_sunny
            return {
                vars = {
                    card.ability.asc_power
                }
            }
        end,
        calculate = function(self, card, context)
            if context.before then
                local hearts = {}
                for i, v in pairs(context.scoring_hand) do
                    if v:is_suit("Hearts") then hearts[#hearts+1] = v end
                end
                Entropy.flip_then(hearts, function(c) c:set_edition("e_entr_sunny") end)
            end
            if context.individual and context.cardarea == G.play then
                return {
                    plus_asc = card.ability.asc_power
                }
            end
        end,
        in_pool = function()
            return false
        end,
    }

    local olive_orchard = {
        object_type = "Joker",
        key = "olive_orchard",
        order = 10^10 + 2,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=3},
        soul_pos = {x = 1, y = 3},
        entr_credits = {
            art = {"missingnumber"}
        },
        config = {
            oxmult = 1,
            xmult_gain = 0.25,
            odds = 2
        },
        loc_vars = function(self, q, card)
            local n, d = SMODS.get_probability_vars(card, 1, card.ability.odds, "entr_olive_orchard")
            return {
                vars = {
                    card.ability.oxmult,
                    card.ability.xmult_gain,
                    n, d
                }
            }
        end,
        calculate = function(self, card, context)
            if context.card_perishing then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "oxmult",
                    scalar_value = "xmult_gain"
                })
            end
            if context.k_setting_blind then
                if SMODS.pseudorandom_probability(card, "entr_olive_orchard", 1, card.ability.odds) then
                    local jokers = {}
                    for i, v in pairs(G.jokers.cards) do
                        if v ~= card then jokers[#jokers+1] = v end
                    end
                    local joker = pseudorandom_element(jokers, pseudoseed("entr_orchard_joker"))
                    if joker then
                        local copy = copy_card(joker)
                        copy:add_to_deck()
                        G.jokers:emplace(copy)
                        copy:set_edition("e_negative")
                        copy.ability.perishable = true
                        copy.ability.perish_tally = 5
                    end
                end
            end
            if context.joker_main then
                return {
                    xmult = card.ability.oxmult
                }
            end
        end,
        in_pool = function()
            return false
        end,
    }

    local burgundy_baracuda = {
        object_type = "Joker",
        key = "burgundy_baracuda",
        order = 10^10 + 3,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=1},
        soul_pos = {x = 1, y = 1},
        entr_credits = {
            art = {"missingnumber"}
        },
        config = {
            bxmult = 1,
            xmult_gain = 0.25,
        },
        loc_vars = function(self, q, card)
            return {
                vars = {
                    card.ability.bxmult,
                    card.ability.xmult_gain,
                }
            }
        end,
        calculate = function(self, card, context)
            if context.ending_shop and #G.consumeables.cards > 0 then
                local cards = pseudorandom_element(G.consumeables.cards, pseudoseed("entr_baracuda"))
                if not SMODS.is_eternal(cards) then
                    cards:start_dissolve()
                end
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "bxmult",
                    scalar_value = "xmult_gain"
                })
            end
            if context.joker_main then
                return {
                    xmult = card.ability.bxmult
                }
            end
        end,
        in_pool = function()
            return false
        end,
    }

    local citrine_comet = {
        object_type = "Joker",
        key = "citrine_comet",
        order = 10^10 + 4,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=4},
        soul_pos = {x = 1, y = 4},
        entr_credits = {
            art = {"missingnumber"}
        },
        calculate = function(self, card, context)
            if context.hand_drawn then
                for i, v in pairs(context.hand_drawn) do
                    if pseudorandom("entr_comet") < 0.5 then
                        local copy = copy_card(v)
                        copy:add_to_deck()
                        G.hand:emplace(copy)
                        copy:set_edition("e_negative")
                        copy.ability.temporary = true
                        table.insert(G.playing_cards, copy)
                    end
                end
            end
        end,
        in_pool = function()
            return false
        end,
    }

    local diamond_dawn = {
        object_type = "Joker",
        key = "diamond_dawn",
        order = 10^10 + 4,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=2},
        soul_pos = {x = 1, y = 2},
        entr_credits = {
            art = {"missingnumber"}
        },
        config = {
            dollars_earn = 0
        },
        loc_vars = function(self, _, card)
            return {
                vars = {
                    card.ability.dollars_earn
                }
            }
        end,
        calculate = function(self, card, context)
            if context.after then
                Entropy.flip_then({G.play.cards[#G.play.cards]}, function(c)
                    card.ability.dollars_earn = card.ability.dollars_earn + c:get_chip_bonus()
                    SMODS.change_base(c, "entr_nilsuit", "entr_nilrank")
                end)
            end
        end,
        calc_dollar_bonus = function(self, card)
            local ret = card.ability.dollars_earn
            card.ability.dollars_earn = 0
            G.E_MANAGER:add_event(Event{
                func = function()
                    SMODS.calculate_effect{card = card, message = localize("k_reset"), colour = G.C.RED}
                    return true
                end
            })
            if ret > 0 then
                return ret
            end
        end,
        in_pool = function()
            return false
        end,
    }

    local alabaster_anchor = {
        object_type = "Joker",
        key = "alabaster_anchor",
        order = 10^10 + 5,
        rarity = "finity_showdown",
        cost = 10,
        atlas = "finity_jokers",
        pos = {x=0, y=5},
        soul_pos = {x = 1, y = 5},
        entr_credits = {
            art = {"missingnumber"}
        },
        config = {
            low = 0.9,
            high = 1.2
        },
        loc_vars = function(self, q, card)
            return {
                vars ={
                    card.ability.high,
                    card.ability.low
                }
            }
        end,
        calculate = function(self, card, context)
            if context.pre_discard then
                local cards = {}
                for i, v in pairs(G.jokers.cards) do
                    if v ~= card then cards[#cards+1] = v end
                end
                pseudoshuffle(cards, pseudoseed("entr_anchor"))
                if cards[1] then
                    Cryptid.manipulate(G.jokers.cards[i], { value = card.ability.high })
                end
                if cards[2] then
                    Cryptid.manipulate(G.jokers.cards[i], { value = card.ability.low })
                end
            end
        end,
        in_pool = function()
            return false
        end,
    }
    FinisherBossBlindStringMap["bl_entr_endless_entropy_phase_four"] = {"j_entr_endlessentropy", "Endless Entropy"}
    FinisherBossBlindStringMap["bl_entr_scarlet_sun"] = {"j_entr_scarlet_sun", "Scarlet Sun"}
    FinisherBossBlindStringMap["bl_entr_olive_orchard"] = {"j_entr_olive_orchard", "Olive Orchard"}
    FinisherBossBlindStringMap["bl_entr_burgundy_baracuda"] = {"j_entr_burgundy_baracuda", "Burgundy Baracuda"}
    FinisherBossBlindStringMap["bl_entr_citrine_comet"] = {"j_entr_citrine_comet", "Citrine Comet"}
    FinisherBossBlindStringMap["bl_entr_diamond_dawn"] = {"j_entr_diamond_dawn", "Diamond Dawn"}
    FinisherBossBlindStringMap["bl_entr_alabaster_anchor"] = {"j_entr_alabaster_anchor", "Alabaster Anchor"}
    return {
        items = {
            scarlet_sun,
            olive_orchard,
            burgundy_baracuda,
            citrine_comet,
            diamond_dawn,
            alabaster_anchor,
            sorrowful_styx,
            callous_choir,
            pristine_pandora,
            condemned_cassandra,
            limitless_labyrinth,
            endless_entropy
        }
    }
end