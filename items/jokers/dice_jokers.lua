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
        and context.other_card.config.center.key ~= "j_entr_d7"
        and Entropy.probability_cards[context.other_card.config.center.key] 
        and SMODS.pseudorandom_probability(
            card,
            "entr_D7",
            1,
            card and card.ability.extra.odds or self.config.extra.odds
        )
        then
            return {
                message = localize("k_again_ex"),
                repetitions = 1,
                card = card,
            }
        end

        if context.repetition
        and context.other_card
        and context.other_card.config
        and Entropy.probability_cards[context.other_card.config.center.key] 
        and SMODS.pseudorandom_probability(
            card,
            "entr_D7",
            1,
            card and card.ability.extra.odds or self.config.extra.odds
        )
        then
            return {
                message = localize("k_again_ex"),
                repetitions = 1,
                card = card,
            }
        end
    end,
}

local D8 = {
    order = 205,
    object_type = "Joker",
    key = "d8",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 6, y = 5 },
    atlas = "jokers",
    config = {
        denominator = 1
    },
    pools = {["Dice"] = true},
    loc_vars = function(self, q, card)
        return {vars = {
            number_format(card.ability.denominator)
        }} 
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint and not context.repetition then
            return {
                denominator = context.denominator - card.ability.denominator
            }
        end
    end,
}

local D10 = {
    order = 206,
    object_type = "Joker",
    key = "d10",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 7, y = 5 },
    atlas = "jokers",
    config = {
        min_d = -3,
        max_d = 3,
        min_n = -5,
        max_n = 5
    },
    pools = {["Dice"] = true},
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            local n_mod = pseudorandom("d10_n", card.ability.min_n*100, card.ability.max_n*100)/100
            local d_mod = pseudorandom("d10_d", card.ability.min_d*100, card.ability.max_d*100)/100
            local num = context.numerator + n_mod
            if num < 1 then
                num = 1
            end
            local den = context.denominator + d_mod
            if den < 2 then
                den = 2
            end
            return {
                numerator = num,
                denominator = den
            }
        end
    end,
}

local D12 = {
    order = 207,
    object_type = "Joker",
    key = "d12",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_dice_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 8, y = 5 },
    atlas = "jokers",
    config = {
        num_per = 1
    },
    loc_vars = function(self, queue, card)
        return {
            vars = {
                number_format(card.ability.num_per)
            }
        }
    end,
    pools = {["Dice"] = true},
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint and not context.repetition then
            local count = Overflow and G.consumeables:get_total_count() or #G.consumeables.cards
            local num = context.numerator + count * card.ability.num_per
            return {
                numerator = num,
            }
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
    order = 209,
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

return {
    items = {
        D1,
        D4,
        D6,
        eternal_D6,
        D7,
        D8,
        D10,
        D12,
        D100,
        capsule_machine
    }
}