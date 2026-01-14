local D0 = {
    order = 199,
    object_type = "Joker",
    key = "d0",
    rarity = 1,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 9, y = 12 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.fix_probability and not context.blueprint and not context.repetition then
            return {
                numerator = 0
            }
        end
    end,
}

local D1 = {
    order = 200,
    object_type = "Joker",
    key = "d1",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 1, y = 5 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition and not context.blueprint then
            card.ability.triggered = nil
            local eval = function() return not card.ability.triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            return {
                message = localize("k_active_ex")
            }
        end
        if context.pseudorandom_result and not card.ability.triggered then
            return {
                message = localize("k_inactive")
            }
        end
    end,
}

local D4 = {
    order = 201,
    object_type = "Joker",
    key = "d4",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 2, y = 5 },
    atlas = "jokers",
    demicoloncompat = true,
}

local D6 = {
    order = 202,
    object_type = "Joker",
    key = "d6",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 3, y = 5 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        numerator = 0,
        numerator_mod = 1
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card) return {vars = {number_format(card.ability.numerator),number_format(card.ability.numerator_mod)}} end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and not context.blueprint then
            if context.result then
                card.ability.numerator = 0
                if to_big(card.ability.numerator) > to_big(0) then
                    return {
                        message = localize("k_reset")
                    }
                end
            else    
                card.ability.numerator = card.ability.numerator + card.ability.numerator_mod
                return {
                    message = "+"..number_format(card.ability.numerator_mod),
                    colour = G.C.GREEN
                }
            end
        end
        if context.mod_probability and not context.blueprint and not context.repetition then
            return {
                numerator = context.numerator + card.ability.numerator
            }
        end
        if context.forcetrigger then
            card.ability.numerator = card.ability.numerator + card.ability.numerator_mod
            return {
                message = "+"..number_format(card.ability.numerator_mod),
                colour = G.C.GREEN
            }
        end
    end,
}

local eternal_D6 = {
    order = 203,
    object_type = "Joker",
    key = "eternal_d6",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 4, y = 5 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        numerator = 0,
        numerator_mod = 1,
        extra = {
            odds = 2
        }
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {
            numerator,
            denominator,
            number_format(card.ability.numerator),
            number_format(card.ability.numerator_mod)
        }} 
    end,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint and not context.repetition then
            if SMODS.pseudorandom_probability(card, 'eternal_D6', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        local card = pseudorandom_element(G.shop_jokers.cards, pseudoseed("eternal_D6_card"))
                        if card then
                            card:start_dissolve()
                        end
                        return true
                    end
                })
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "numerator",
                    scalar_value = "numerator_mod",
                    scaling_message = {
                        message = "+"..number_format(card.ability.numerator_mod),
                        colour = G.C.GREEN
                    }
                })
            end
        end
        if context.mod_probability and context.trigger_obj ~= card  and not context.blueprint and not context.repetition then
            return {
                numerator = context.numerator + card.ability.numerator
            }
        end
        if (context.end_of_round and not context.individual and not context.repetition and G.GAME.blind.boss and G.GAME.blind.config.blind.key ~= "bl_entr_red")  then
            card.ability.numerator = 0
        end
        if context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "numerator",
                scalar_value = "numerator_mod",
                scaling_message = {
                    message = "+"..number_format(card.ability.numerator_mod),
                    colour = G.C.GREEN
                }
            })
        end
    end,
}

local D7 = {
    order = 204,
    object_type = "Joker",
    key = "d7",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    pools = {["Dice"] = true},
    eternal_compat = true,
    pos = { x = 5, y = 5 },
    atlas = "jokers",
    blueprint_compat = true,
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, q, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {
            numerator,
            denominator,
        }} 
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check
        and not context.retrigger_joker
        and context.other_card
        and context.other_card.config
        and context.other_card.config.center
        and context.other_card.config.center.key ~= "j_entr_d7"
        and SMODS.pseudorandom_probability(
            card,
            "entr_D7",
            1,
            card and card.ability.extra.odds or self.config.extra.odds
        )
        then
            if not Entropy.probability_cards[context.other_card.config.center.key] and context.other_card.config.center.loc_vars then
                context.other_card.config.center:loc_vars({}, context.other_card)
            end
            if Entropy.probability_cards[context.other_card.config.center.key] then
                return {
                    message = localize("k_again_ex"),
                    repetitions = 1,
                    card = card,
                }
            end
        end

        if context.repetition
        and context.other_card
        and context.other_card.config
        and context.other_card.config.center
        and SMODS.pseudorandom_probability(
            card,
            "entr_D7",
            1,
            card and card.ability.extra.odds or self.config.extra.odds
        )
        then
            if not Entropy.probability_cards[context.other_card.config.center.key] and context.other_card.config.center.loc_vars then
                context.other_card.config.center:loc_vars({}, context.other_card)
            end
            if Entropy.probability_cards[context.other_card.config.center.key] then
                return {
                    message = localize("k_again_ex"),
                    repetitions = 1,
                    card = card,
                }
            end
        end
    end,
}

local D100 = {
    order = 208,
    object_type = "Joker",
    key = "d100",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 0, y = 6 },
    atlas = "jokers",
    config = {
        min_m = 0.75,
        max_m = 1.1,
        min_m2 = 0.95,
        max_m2 = 1.25
    },
    pools = {["Dice"] = true},
    calculate = function(self, card, context)
        if context.mod_probability and context.trigger_obj and not context.blueprint and not context.repetition and context.trigger_obj.ability then
            local num = context.numerator * (context.trigger_obj.ability.immutable and context.trigger_obj.ability.immutable.d100_modifier or 1)
            local denom = context.denominator * (context.trigger_obj.ability.immutable and context.trigger_obj.ability.immutable.d100_d_modifier or 1)
            return {
                numerator = num,
                denominator = denom
            }
        end
        if context.pseudorandom_result and context.trigger_obj then
            local pcard = context.trigger_obj
            if not pcard.ability.immutable then
                pcard.ability.immutable = {}
            end
            pcard.ability.immutable.d100_d_modifier = pseudorandom("d100_d", card.ability.min_m * 1000, card.ability.max_m * 1000)/1000
            pcard.ability.immutable.d100_modifier = pseudorandom("d100", card.ability.min_m2 * 1000, card.ability.max_m2 * 1000)/1000
            return {
                message = localize("k_randomised"),
                colour = G.C.GREEN
            }
        end
    end,
}

local capsule_machine = {
    order = 211,
    object_type = "Joker",
    key = "capsule_machine",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 2, y = 6 },
    atlas = "jokers",
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other", key="perishable", vars = {5,5}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        local card = SMODS.add_card{
                            set = "Dice",
                            area = G.jokers,
                            key_append = "entr_capsule_machine"
                        }
                        card.ability.perishable = true
                        card.ability.perish_tally = 5
                        return true
                    end
                })
            end
        end
    end,
}

local dice_shard = {
    order = 209,
    object_type = "Joker",
    key = "dice_shard",
    rarity = 3,
    cost = 10,
    eternal_compat = true,
    pos = { x = 9, y = 5 },
    atlas = "jokers",
    config = {
        left = 1,
        left_mod = 1
    },
    dependencies = {
        items = {
            "set_entr_actives",
            "set_entr_dice_jokers",
        }
    },
    perishable_compat = true,
    pools = {["Dice"] = true},
    loc_vars = function(self, q, card)
        local name = "None"
        local cards = Entropy.GetHighlightedCards({G.jokers, G.shop_jokers, G.shop_booster, G.shop_vouchers}, card, 1, card.ability.extra)
        if cards and #cards > 0 then
            if cards[1].config.center.set == "Joker" or G.GAME.modifiers.cry_beta and cards[1].consumable then
                local first = cards[1]
                local ind = ReductionIndex(cards[1], cards[1].config.center.set )-1
                while G.P_CENTER_POOLS[cards[1].config.center.set ][ind].no_doe or G.P_CENTER_POOLS[cards[1].config.center.set][ind].no_collection do
                    ind = ind - 1
                end
                if ind < 1 then ind = 1 end
                name = localize { type = 'name_text', key = G.P_CENTER_POOLS[cards[1].config.center.set][ind].key, set = G.P_CENTER_POOLS[cards[1].config.center.set][ind].set }
                q[#q+1] = G.P_CENTER_POOLS[cards[1].config.center.set][ind]
            end
        end
        return {
            vars = {
                card.ability.left,
                card.ability.left_mod,
                name
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.blueprint and not context.individual and not context.repetition) or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", scaling_message = {message = "+"..number_format(card.ability.left_mod)}})
        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.jokers}, card, 1, 1)
        return num > 0 and num <= 1 and to_big(card.ability.left) > to_big(0)
    end,
    use = function(self, card)
        card.ability.left = card.ability.left - 1
        Entropy.FlipThen(Entropy.GetHighlightedCards({G.jokers}, card, 1, 1), function(card)
            local ind = ReductionIndex(card, card.config.center.set)-1
            while G.P_CENTER_POOLS[card.config.center.set][ind] and G.P_CENTER_POOLS[card.config.center.set][ind].no_doe or G.P_CENTER_POOLS[card.config.center.set].no_collection do
                ind = ind - 1
            end
            if ind < 1 then ind = 1 end
            if G.P_CENTER_POOLS.Joker[ind] then
                card:set_ability(G.P_CENTERS[G.P_CENTER_POOLS.Joker[ind].key])
            end
            G.jokers:remove_from_highlighted(card)
        end)
    end
}

local nostalgic_d6 = {
    order = 210,
    object_type = "Joker",
    key = "nostalgic_d6",
    rarity = 3,
    cost = 8,
    eternal_compat = true,
    pos = {x = 5, y = 14},
    atlas = "jokers",
    config = {
        dollars = 4
    },
    dependencies = {
        items = {
            "set_entr_actives",
        }
    },
    perishable_compat = true,
    pools = {Dice = true},
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollars
            }
        }
    end,
    can_use = function(self, card)
        return G.STATE == G.STATES.SMODS_BOOSTER_OPENED and (Entropy.kind_to_set(SMODS.OPENED_BOOSTER.config.center.kind) or SMODS.OPENED_BOOSTER.config.center.create_card)
    end,
    use = function(self, card)
        ease_dollars(-card.ability.dollars)
        for i, v in pairs(G.pack_cards.cards) do
            v:start_dissolve()
            local p_card
            local k = SMODS.OPENED_BOOSTER and Entropy.kind_to_set(SMODS.OPENED_BOOSTER.config.center.kind, true)
            if not k and SMODS.OPENED_BOOSTER.config.center.create_card and type(SMODS.OPENED_BOOSTER.config.center.create_card) == "function" then
                local _card_to_spawn = SMODS.OPENED_BOOSTER.config.center:create_card(SMODS.OPENED_BOOSTERr, i)
                local spawned
                if type((_card_to_spawn or {}).is) == 'function' and _card_to_spawn:is(Card) then
                    spawned = _card_to_spawn
                else
                    spawned = SMODS.create_card(_card_to_spawn)
                end
                p_card = spawned
            else
                if k == "Planet" or k == "Tarot" then
                    local rune
                    local rare_rune
                    if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
                    if G.GAME.entr_diviner then
                        if pseudorandom("entr_generate_rune") < 0.06 then rune = true end
                    end
                    if rune then
                        k = "Rune"
                    end
                end
                p_card = SMODS.create_card {
                    set = k or "Joker",
                    area = k == "Twisted" and G.consumeables or nil,
                    key_append = "entr_nostalgic_d6",
                }
            end
            G.pack_cards.cards[i] = p_card
            p_card.area = G.pack_cards
            if G.GAME.modifiers.glitched_items then
                local gc = {p_card.config.center.key}
                for i = 1, G.GAME.modifiers.glitched_items - 1 do
                gc[#gc+1] = Entropy.GetPooledCenter(p_card.config.center.set).key
                end
                p_card.ability.glitched_crown = gc
            end
        end
    end,
    entr_credits = {idea = {"Grahkon"}}
}

return {
    items = {
        D0,
        D1,
        D4,
        D6,
        eternal_D6,
        D7,
        D8,
        D10,
        D12,
        D100,
        dice_shard,
        nostalgic_d6,
        capsule_machine
    }
}