local oekrep = {
    order = 400,
    object_type = "Joker",
    key = "oekrep",
    config = {
        qmult = 4
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    
    config = {
        extra = {odds = 3, numerator = 2}
    },

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    atlas = "reverse_legendary",
    loc_vars = function(self, q, card)
        q[#q+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator, card.ability.extra.odds, "entr_oekrep")
        return {
            vars = {
                new_numerator,
                new_denominator
            }
        }
    end,
    immutable = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.starting_shop then
            for i, v in pairs(G.shop_booster.cards) do
                if SMODS.pseudorandom_probability(card, 'entr_oekrep', card.ability.extra.numerator, card.ability.extra.odds) and v.config.center.kind ~= "Standard" then 
                    v:set_edition("e_negative")
                end
            end
        end
    end,
}

local tocihc = {
    order = 401,
    object_type = "Joker",
    key = "tocihc",
    config = {
        qmult = 4
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    soul_pos = { x = 3, y = 1 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        local ret = localize("k_none")
		if Cryptid.safe_get(G.GAME, "blind", "in_blind") then
			for i, v in pairs(G.GAME.round_resets.blind_states) do
                if v == "Current" or v == "Select" then
                    if i == "Boss" then
                        ret = "???"
                    else    
                        ret = localize({ type = "name_text", key = G.GAME.round_resets.blind_tags.Small, set = "Tag" })
                    end
                end
            end
		end
        return {
            vars = {ret}
        }
    end,
    immutable = true,
    calculate = function (self, card, context)
        if (context.entr_reversing_blind) or context.forcetrigger then
            local tag
            local type = G.GAME.blind:get_type()

            if type == "Boss" then
                tag = Tag(get_next_tag_key())
            else
                tag = Tag(G.GAME.round_resets.blind_tags[type])     
                --card:juice_up()
            end
            if Cryptid.is_shiny then
                for i = 0, 10 do
                    if not tag.ability.shiny or tag.ability.shine == false then
                        tag.ability.shiny=Cryptid.is_shiny()
                    end
                end
            end
            return {
                message = localize("k_skipped_q"),
                colour = Entropy.reverse_legendary_gradient,
                func = function()
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            add_tag(tag)
                            return true
                        end
                    })
                end
            }
        end
    end
}

local teluobirt = {
    order = 403,
    object_type = "Joker",
    key = "teluobirt",
    rarity = "entr_reverse_legendary",
    cost = 20,
    
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    soul_pos = { x = 1, y = 1 },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.xmult
            },
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    calculate = function (self, card, context)
        if (context.individual and context.cardarea == G.play) then
            local num_jacks = 0
            for i, v in pairs(G.play.cards) do
                if v.base.id == 11 then
                    num_jacks = num_jacks + 1
                end
            end
            if context.other_card.base.id == 11 then
                return {
                    Xchip_mod = num_jacks,
                    message = localize({
                        type = "variable",
                        key = "a_xchips",
                        vars = { num_jacks },
                    }),
                    colour = { 0.8, 0.45, 0.85, 1 }
                }
            end
        end
        if context.repetition and context.cardarea == G.play and context.other_card.base.id == 11 then
            local order = 1
            for i, v in pairs(G.play.cards) do
                if v.unique_val == context.other_card.unique_val then
                    order = i
                end
            end
            if order > 1 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = order-1,
                    card = card,
                }
            end
        end
    end
}

local oinac = {
    order = 404,
    object_type = "Joker",
    key = "oinac",
    rarity = "entr_reverse_legendary",
    cost = 20,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    config = {
        extra = {
            emult = 1,
            emult_mod = 0.05
        }
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.emult_mod,
                card.ability.extra.emult
            },
        }
    end,
    demicoloncompat = true,
    calculate = function (self, card2, context)
        if context.destroy_card and context.cardarea == G.play and context.destroying_card then
                local card = copy_card(context.destroying_card)
                SMODS.change_base(card, card.base.suit, Entropy.HigherCardRank(card))
                card:add_to_deck()
                table.insert(G.playing_cards, card)
                G.hand:emplace(card)
                playing_card_joker_effects({ card })
                if context.destroying_card:is_face() then
                    card2.ability.extra.emult = (card2.ability.extra.emult or 1) + (card2.ability.extra.emult_mod or 0.1)
                    return {
                        message = "Upgraded",
                        remove = true
                    }
                else    
                    return {
                        remove = true
                    }
                end
        end
        if context.joker_main or context.forcetrigger then
            return {
				Echip_mod = card2.ability.extra.emult,
				message = localize({
					type = "variable",
					key = "a_powchips",
					vars = { card2.ability.extra.emult },
				}),
				colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
			}
        end
    end,
	entr_credits = {
		idea = {
			"cassknows",
		},
	},
}

local entropy_card = {
    order = 405,
    object_type = "Joker",
    key = "entropy_card",
    config = {
        x_asc_mod = 1,
        num = 1091 --sun
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    soul_pos = { x = 0, y = 2 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        if Entropy.config.asc_power_tutorial then info_queue[#info_queue+1] = {set = "Other", key = "asc_power_tutorial"} end
        return {
            vars = {
                number_format(card.ability.x_asc_mod),
                number_format(1+card.ability.num*card.ability.x_asc_mod)
            }
        }
    end,
    calculate = function (self, card, context)
       if context.joker_main or context.forcetrigger then
            return {
                asc = 1+card.ability.num*card.ability.x_asc_mod
            }
       end
    end
}


local kciroy = {
    order = 402,
    object_type = "Joker",
    key = "kciroy",
    config = {
        csl = 23,
        hs = 8,
        neededd = 114,
        currd = 0,
        echips = 1,
        echips_mod = 0.5
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    soul_pos = { x = 2, y = 1 },
    atlas = "reverse_legendary",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.min(card.ability.hs, 1000),
                card.ability.csl,
                card.ability.echips_mod,
                card.ability.neededd,
                card.ability.currd,
                card.ability.echips,
            },
        }
    end,
    entr_credits = {
		idea = {
			"cassknows",
		},
	},
    demicoloncompat = true,
    add_to_deck = function(self, card)
        Entropy.ChangeFullCSL(card.ability.csl)
        G.hand:change_size(math.min(card.ability.hs, 1000))
    end,
    remove_from_deck = function(self, card)
        Entropy.ChangeFullCSL(-card.ability.csl)
        G.hand:change_size(-math.min(card.ability.hs, 1000))
    end,
    calculate = function (self, card, context)
        if (context.pre_discard and not context.retrigger_joker and not context.blueprint) or context.forcetrigger then
            card.ability.currd = card.ability.currd + #G.hand.highlighted
            while card.ability.currd >= card.ability.neededd do
                card.ability.currd = card.ability.currd - card.ability.neededd
                card.ability.echips = card.ability.echips + card.ability.echips_mod
            end
            if context.forcetrigger then
                card.ability.echips = card.ability.echips + card.ability.echips_mod
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
				Echip_mod = card.ability.echips,
				message = localize({
					type = "variable",
					key = "a_powchips",
					vars = { card.ability.echips },
				}),
				colour = { 0.8, 0.45, 0.85, 1 }, --plasma colors
			}
        end
    end
}

local ybur = {
    order = 405,
    object_type = "Joker",
    key = "ybur",
    config = {
        e_chips = 1,
        e_chips_mod = 0.05,
        active = true
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    pos = {x=2, y=0},
    soul_pos = {x = 1, y = 0},
    atlas = "ruby_atlas",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.e_chips,
                card.ability.e_chips_mod,
                card.ability.active and localize("k_active") or localize("k_inactive")
            },
        }
    end,
    calculate = function (self, card, context)
        if context.game_over and card.ability.active then
            for i, card in pairs(SMODS.find_card("j_entr_ybur")) do
                card.ability.active = false
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "e_chips",
                    scalar_value = "e_chips_mod",
                    scaling_message = {
                        message = localize({
                            type = "variable",
                            key = "a_powchips",
                            vars = { card.ability.e_chips },
                        }),
                        colour = { 0.8, 0.45, 0.85, 1 }
                    }
                })
            end
            return {
                saved = localize(pseudorandom("ybur") < 0.5 and "k_saved_heroic" or "k_saved_just")
            }
        end
        if context.joker_main or context.forcetrigger then
            if to_big(card.ability.e_chips) ~= to_big(1) then
                return {
                    echips = card.ability.e_chips,
                }
            end
        end
        if context.skip_blind and not context.blueprint and not context.repetition then
            card.ability.active = false
            return {
                message = localize("k_inactive")
            }
        end
        if (context.end_of_round and not context.individual and not context.repetition) then
            if G.GAME.blind_on_deck == "Boss" then
                card.ability.active = true
                return {
                    message = localize("k_reset")
                }
            end
        end
    end,
    pronouns = "she_her",
}

local zelavi = {
    order = 406,
    object_type = "Joker",
    key = "zelavi",
    config = {
        x_chips = 1,
        x_chips_mod = 0.2
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    entr_credits = {
        art = {"Lil. Mr. Slipstream"},
        idea = {"Lil. Mr. Slipstream"},
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    pos = {x=2, y=1},
    soul_pos = {x = 3, y = 1},
    atlas = "ruby_atlas",
    demicoloncompat=true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.p_spectral_mega_1
        return {
            vars = {
                card.ability.x_chips,
                card.ability.x_chips_mod
            },
        }
    end,
    calculate = function (self, card, context)
        if context.open_booster and context.card.config.center.kind == "Spectral" then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "x_chips",
                scalar_value = "x_chips_mod",
            })
        end
        if context.joker_main or context.forcetrigger then
            if to_big(card.ability.x_chips) ~= to_big(1) then
                return {
                    xchips = card.ability.x_chips,
                }
            end
        end
        if context.starting_shop then
            if G.shop_booster.cards[1] then
                G.shop_booster.cards[1]:set_ability(G.P_CENTERS.p_spectral_mega_1)
            end
        end
    end,
    pronouns = "he_they",
}

function Entropy.missing_ranks()
    local ranks = {}
    for i, v in pairs(SMODS.Ranks) do
        if not v.original_mod and not v.mod then ranks[v.id] = 0 end
    end
    for i, v in pairs(G.playing_cards or {}) do
        if ranks[v.base.id] then
            ranks[v.base.id] = ranks[v.base.id] + 1
        end
    end
    local total = 0
    for i, v in pairs(ranks) do
        if v == 0 then total = total + 1 end
    end
    return total
end

local ssac = {
    order = 407,
    object_type = "Joker",
    key = "ssac",
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    eternal_compat = true,
    pos = {x=2, y=2},
    soul_pos = {x = 1, y = 2},
    atlas = "ruby_atlas",
    demicoloncompat=true,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"},
        idea = {"cassknows"},
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.ceil(Entropy.missing_ranks() / 2)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main  then
            for i = 1, math.min(math.ceil(Entropy.missing_ranks() / 2), (context.blueprint or context.repetition) and 1 or 99999) do
                local j_r = (Cryptid.forcetrigger(G.jokers.cards[#G.jokers.cards], context) or {}).jokers
                local c_r = G.consumeables.cards[#G.consumeables.cards] and Cryptid.forcetrigger(G.consumeables.cards[#G.consumeables.cards], context) or {}
                local v = G.play.cards[#G.play.cards]
                if G.play.cards and v then
                    local results = eval_card(v, {cardarea=G.play,main_scoring=true, forcetrigger=true, individual=true}) or {}
                    if results then
                        for i, v2 in pairs(results) do
                            for i2, result in pairs(type(v2) == "table" and v2 or {}) do
                                SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
                            end
                        end
                    end
                    local results = eval_card(v, {cardarea=G.hand,main_scoring=true, forcetrigger=true, individual=true}) or {}
                    if results then
                        for i, v2 in pairs(results) do
                            for i2, result in pairs(type(v2) == "table" and v2 or {}) do
                                SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
                            end
                        end
                    end
                end
                for i, v in pairs(j_r or {}) do
                    SMODS.calculate_individual_effect(j_r, card, i, v, false)
                end
                for i, v in pairs(c_r) do
                    SMODS.calculate_individual_effect(j_r, card, i, v, false)
                end
            end
        end
    end,
    pronouns = "she_her",
}

local axeh = {
    order = 409,
    object_type = "Joker",
    key = "axeh",
    config = {
        asc_mod = 3
    },
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    pos = {x=2, y=4},
    soul_pos = {x = 1, y = 4},
    atlas = "ruby_atlas",
    demicoloncompat=true,
    entr_credits = {
        art = {"HexaCryonic"},
        idea = {"HexaCryonic"},
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.j_entr_sunny_joker
        return {
            vars = {
                card.ability.asc_mod
            },
        }
    end,
    add_to_deck = function(self, card, from_debuff) 
        if not from_debuff then
            SMODS.add_card{
                area = G.jokers,
                key = "j_entr_sunny_joker"
            }
        end
    end,
    pronouns = "she_her",
}

local nokharg  = {
    order = 410,
    object_type = "Joker",
    key = "nokharg",
    dependencies = {
        items = {
          "set_entr_inversions",
        }
    },
    rarity = "entr_reverse_legendary",
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    pos = {x=0, y=1},
    soul_pos = {x = 1, y = 0},
    atlas = "grahkon_atlas",
    demicoloncompat=true,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"},
        idea = {"Grahkon"},
    },
    config = {
        blind_size = 1,
        blind_size_mod = 0.1
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.blind_size,
                card.ability.blind_size_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and not context.blueprint and not card.getting_sliced) or context.forcetrigger then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.HUD_blind:recalculate()
        end
        if (context.after and G.GAME.current_round.discards_left >= G.GAME.round_resets.discards) or context.forcetrigger then
            local cards=  {}
            for i, v in pairs(G.play.cards) do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card_copied = copy_card(v, nil, nil, G.playing_card)
                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.hand:emplace(card_copied)
                card_copied.states.visible = nil
                cards[#cards+1] = card_copied
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end
                }))
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "blind_size",
                    scalar_value = "blind_size_mod"
                })
            end
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = cards })
                            return true
                        end
                    }))
                end
            }
        end
    end,
    pronouns = "he_him",
}

return {
    items = {
        oekrep,
        tocihc,
        teluobirt,
        oinac,
        kciroy,
        ybur,
        ssac,
        zelavi,
        axeh,
        nokharg,
        SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load and entropy_card or nil, --lazy so this goes here
    }
}
