local surreal = {
    order = 1,
    object_type = "Joker",
    key = "surreal_joker",
    config = {
        qmult = 4
    },
    rarity = 1,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                " "..card.ability.qmult
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            G.GAME.current_round.current_hand.mult = card.ability.qmult
            update_hand_text({delay = 0}, {chips = G.GAME.current_round.current_hand.chips and hand_chips, mult = card.ability.qmult})
            return {
                Eqmult_mod = not Entropy.BlindIs("bl_entr_theta") and card.ability.qmult,
                Eqchips_mod = Entropy.BlindIs("bl_entr_theta") and card.ability.qmult
            }
        end
    end
}

local tesseract = {
    order = 2,
    object_type = "Joker",
    key = "tesseract",
    config = {
        degrees = 90
    },
    rarity = 1,
    cost = 3,
    
    pools = { ["Meme"] = true },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.degrees)
            },
        }
    end,
}

local strawberry_pie = {
    order = 4,
    object_type = "Joker",
    key = "strawberry_pie",
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 2, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Food"] = true },
}

local recursive_joker = {
    order = 5,
    object_type = "Joker",
    key = "recursive_joker",
    config = {
        used_this_round = false
    },
    rarity = 2,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.used_this_round and "Inactive" or "Active"
            },
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            card.ability.used_this_round = false
        end
        if (context.selling_card and context.card == card and not card.ability.used_this_round) or context.forcetrigger then
            card.ability.used_this_round = true
            local card = copy_card(card)
            if context.forcetrigger and card.ability.desync then
                card.ability.context = Entropy.RandomContext()
            end
            card:add_to_deck()
            G.jokers:emplace(card)
        end
    end
}
local dr_sunshine = {
    order = 6,
    object_type = "Joker",
    key = "dr_sunshine",
    config = {
        plus_asc = 0,
        plus_asc_mod = 0.25
    },
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.plus_asc_mod),
                number_format(card.ability.plus_asc),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint or context.forcetrigger then
            for i, v in pairs(context.removed or {1}) do
                card.ability.plus_asc = (card.ability.plus_asc or 0) + (card.ability.plus_asc_mod or 0.25)
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("entr_ascended"), colour = G.C.GREEN }
				)
            end
        end
        if (context.joker_main or context.forcetrigger) and to_big(card.ability.plus_asc) > to_big(0) then
            return {
                plus_asc = card.ability.plus_asc
            }
        end
    end
}

local sunny_joker = {
    order = 7,
    object_type = "Joker",
    key = "sunny_joker",
    config = {
        plus_asc = 2
    },
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.plus_asc),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                plus_asc = card.ability.plus_asc
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local antidagger = {
    order = 8,
    object_type = "Joker",
    key = "antidagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    immutable = true,
    eternal_compat = true,
    pos = { x = 6, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    config = { extra = { odds = 6 } },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
            },
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            local keys = {}
            for i, v in pairs(G.GAME.banned_keys) do
                keys[#keys+1]=i
            end
            if #keys > 0 then
                local key = pseudorandom_element(keys, pseudoseed("antidagger"))
                while not G.P_CENTERS[key] or G.P_CENTERS[key].set ~= "Joker" do
                    key = pseudorandom_element(keys, pseudoseed("antidagger"))
                end
                G.GAME.banned_keys[key] = nil
                local c = SMODS.create_card({
                    area = G.jokers,
                    set="Joker",
                    key = key
                })
                c:add_to_deck()
                G.jokers:emplace(c)
            end
            if pseudorandom("antidagger")
            < cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged)
                / card.ability.extra.odds then
                    local joker = pseudorandom_element(G.jokers.cards, pseudoseed("antidagger"))
                    G.GAME.banned_keys["j_entr_antidagger"] = true
                    G.GAME.banned_keys[joker.config.center.key] = true
                    joker.getting_sliced = true
                    eval_card(joker, {banishing_card = true, banisher = card, card = joker, cardarea = joker.area})
                    joker:start_dissolve()
                    card:start_dissolve()
                    play_sound("slice1", 0.96 + math.random() * 0.08)
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows"}
    }
}

local solar_dagger = {
    order = 9,
    object_type = "Joker",
    key = "solar_dagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    config = { x_asc = 1 },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.x_asc)
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and not (context.blueprint_card or self).getting_sliced) or context.forcetrigger then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i+1] and not G.jokers.cards[i+1].ability.eternal then check = i+1 end
            end
            if check then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sliced_card = G.jokers.cards[check]
                        sliced_card.getting_sliced = true
                        card.ability.x_asc =
                            lenient_bignum(to_big(card.ability.x_asc) + sliced_card.sell_cost * 0.1)
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("ff9000") }, nil, 1.6)
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        return true
                    end,
                }))
            end
        end
        if context.joker_main then
            return {
                asc = card.ability.x_asc
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows", "Strum"}
    }
}

local insatiable_dagger = {
    order = 10,
    object_type = "Joker",
    key = "insatiable_dagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    immutable = true,
    pos = { x = 4, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.setting_blind and not (context.blueprint_card or self).getting_sliced) or context.forcetrigger then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i-1] then check = i-1 end
            end
            if check and not G.jokers.cards[#G.jokers.cards].eternal then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sliced_card = G.jokers.cards[#G.jokers.cards]
                        sliced_card.getting_sliced = true
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("a800ff") }, nil, 1.6)
                        G.GAME.banned_keys[sliced_card.config.center.key] = true
                        eval_card(sliced_card, {banishing_card = true, banisher = card, card = sliced_card, cardarea = sliced_card.area})
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        local check2
                        if not Card.no(G.jokers.cards[check], "immutable", true) then
                            Cryptid.manipulate(G.jokers.cards[check], { value = sliced_card.sell_cost * 0.05 + 1 })
                            check2 = true
                        end
                        if check2 then
                            card_eval_status_text(
                                G.jokers.cards[check],
                                "extra",
                                nil,
                                nil,
                                nil,
                                { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                            )
                        end
                        return true
                    end,
                }))
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
	    art = {"Lyman"}
    }
}

local rusty_shredder = {
    order = 11,
    object_type = "Joker",
    key = "rusty_shredder",
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    immutable = true,
    eternal_compat = true,
    pos = { x = 7, y = 1 },
    atlas = "jokers",
    config = {extra = {odds = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
        info_queue[#info_queue+1] = {key = "temporary", set = "Other"}
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.pre_discard) then
            for i, v in pairs(G.hand.highlighted) do
                if pseudorandom("rusty_shredder")
                < cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged) / card.ability.extra.odds then
                    local c = copy_card(v)
                    c:set_edition("e_negative")
                    c.ability.temporary = true
                    c:add_to_deck()
                    G.hand:emplace(c)
                end
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"lfmoth"}
    }
}

local chocolate_egg = {
    order = 12,
    object_type = "Joker",
    key = "chocolate_egg",
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Food"] = true, ["Candy"] = true },
    calculate = function(self, card, context)
        if (context.banishing_card and context.cardarea == G.jokers) or context.forcetrigger then
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("entr_opened"), colour = G.C.GREEN }
            )
            card.ability.no_destroy = true
            local c = create_card("Joker", G.jokers, nil, "cry_epic")
            c:add_to_deck()
            G.jokers:emplace(c)
            c:set_edition("e_entr_sunny")
        end
        if context.selling_self then card.ability.no_destroy = true end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"missingnumber"}
    }
}

local lotteryticket = {
    order = 13,
    object_type = "Joker",
    key = "lotteryticket",
    rarity = 2,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    demicoloncompat=true,
    eternal_compat = true,
    pos = { x = 9, y = 0 },
    atlas = "jokers",
    config = {extra = {odds = 5, odds2 = 5, lose=1, payoutsmall = 20, payoutlarge = 50}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
                card.ability.extra.odds2*card.ability.extra.odds,
                card.ability.extra.lose,
                card.ability.extra.payoutsmall,
                card.ability.extra.payoutlarge
            },
        }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if pseudorandom("lottery")
                    < cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged) / card.ability.extra.odds then
                        if pseudorandom("lottery")
                        < cry_prob(card.ability.cry_prob, card.ability.extra.odds2, card.ability.cry_rigged) / card.ability.extra.odds2 then
                            ease_dollars(card.ability.extra.payoutlarge-card.ability.extra.lose)
                        else
                            ease_dollars(card.ability.extra.payoutsmall-card.ability.extra.lose)
                        end
                    else
                        ease_dollars(-card.ability.extra.lose)
                    end
                    return true
                end
            }))
        end
        if context.forcetrigger then
            ease_dollars(card.ability.extra.payoutlarge-card.ability.extra.lose)
        end
    end,
}

local devilled_suns = {
    order = 14,
    object_type = "Joker",
    key = "devilled_suns",
    rarity = 2,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    demicoloncompat=true,
    eternal_compat = true,
    pos = { x = 1, y = 2 },
    atlas = "jokers",
    config = { base = 2, per_sunny = 2},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_entr_sunny
        return {
            vars = {
                card.ability.base,
                card.ability.per_sunny
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            local num = card.ability.base
            for i, v in pairs(G.jokers.cards) do
                if v:is_sunny() then num = num + card.ability.per_sunny end
            end
            return {
                plus_asc = num
            }
        end
    end,
    entr_credits = {
        art = {"Grahkon"},
        idea = {"Grahkon"}
    }
}

local eden = {
    order = 15,
    object_type = "Joker",
    key = "eden",
    name="entr-eden",
    config = {
        asc=5
    },
    rarity = 2,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and center.edition.key ~= "e_entr_sunny") then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_sunny
		end
        return {
            vars = {
                number_format(center.ability.asc)
            },
        }
    end,
    calculate = function(self, card, context)
		if
			(context.other_joker
			and context.other_joker.edition
			and context.other_joker:is_sunny()
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
			return {
				plus_asc = lenient_bignum(card.ability.asc),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card:is_sunny() then
				return {
					plus_asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
		if
			(context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card:is_sunny()
			and not context.end_of_round)
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					plus_asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
        if context.forcetrigger then
            return {
                plus_asc = lenient_bignum(card.ability.asc),
                card = card,
            }
        end
	end
}

local seventyseven = {
    order = 16,
    object_type = "Joker",
    key = "seventyseven",
    config = {
        chips=100
    },
    rarity = 1,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            return {
                eq_chips = card.ability.chips
            }
        end
	end
}

local skullcry = {
    order = 17,
    object_type = "Joker",
    key = "skullcry",
    config = {
        base=10,
        percent = 5
    },
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.base),
                number_format(center.ability.percent)
            },
        }
    end,
    calculate = function(self, card, context)
		if context.game_over and to_big(G.GAME.chips) > to_big(math.log(G.GAME.blind.chips, card.ability.base)) then
            G.GAME.saved_message = localize("k_saved_skullcry")
            if to_big(math.abs(G.GAME.chips - math.log(G.GAME.blind.chips, card.ability.base))) > to_big(math.log(G.GAME.blind.chips, card.ability.base) * card.ability.percent/100) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_saved_ex'),
                saved = "k_saved_skullcry",
                colour = G.C.RED
            }
        end
	end,
    entr_credits = {
        custom = {key="wish", text="denserver10"}
    }
}
local dating_simbo = {
    order = 18,
    object_type = "Joker",
    key = "dating_simbo",
    config = {
        chips = 0
    },
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 9, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.destroying_card and not context.blueprint and context.cardarea == G.play then
            if context.destroying_card:is_suit("Hearts") then
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.FILTER }
				)
                local card2 = context.destroying_card
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
                        card2:juice_up()
                        return true
                    end
                }))
                card.ability.chips = card.ability.chips + math.max(context.destroying_card.base.nominal + (context.destroying_card.ability.bonus or 0), 0)            
                return { remove = not context.destroying_card.ability.eternal }
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.chips
            }
        end
	end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lyman"}
    }
}

local sweet_tooth = {
    order = 19,
    object_type = "Joker",
    key = "sweet_tooth",
    config = {
        chips = 20,
        chip_exp = 1.1
    },
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips),
                number_format(center.ability.chip_exp)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.chips
            }
        end
        if context.ending_shop and not context.blueprint then
            local check
            for i, v in ipairs(G.jokers.cards) do
                if Cryptid.safe_get(v.config.center, "pools", "Candy") or v:is_food() then
                    v:start_dissolve()
                    check = true
                end
            end
            if check then
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = localize("k_upgrade_ex"), colour = G.C.FILTER }
                )
                card.ability.chips = to_big(card.ability.chips) ^ to_big(card.ability.chip_exp)
            end
        end
	end,
    entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}


local bossfight = {
    order = 20,
    object_type = "Joker",
    key = "bossfight",
    config = {
        chips = 20,
        cards = 4
    },
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 3 },
    soul_pos = {x = 2, y = 3},
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(math.floor(center.ability.cards)),
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.after or context.forcetrigger then
            local cards = #G.play.cards
            if cards == math.floor(card.ability.cards) or context.forcetrigger then
                Entropy.FlipThen(G.hand.cards, function(card2)
                    card2.ability.bonus = (card2.ability.bonus or 0) + card.ability.chips
                end)
            end
        end
	end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lyman"}
    }
}

local phantom_shopper = {
    order = 21,
    object_type = "Joker",
    key = "phantom_shopper",
    config = {
        rarity = "Common",
        progress = 0,
        needed_progress = 4
    },
    rarity = 2,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                localize("k_"..string.lower(center.ability.rarity)),
                number_format(center.ability.needed_progress),
                number_format(center.ability.needed_progress - center.ability.progress),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            SMODS.add_card{
                set="Joker",
                area = G.jokers,
                rarity = card.ability.rarity,
                legendary = card.ability.rarity == "Legendary"
            }
        end
        if (context.ending_shop and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
            card.ability.progress = card.ability.progress + 1
            if card.ability.progress >= card.ability.needed_progress then
                card.ability.progress = 0
                card.ability.rarity = ({
                    Common = "Uncommon",
                    Uncommon = "Rare",
                    Rare = "cry_epic",
                    cry_epic = "Legendary"
                })[card.ability.rarity] or card.ability.rarity
            else
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = number_format(card.ability.progress).."/"..number_format(card.ability.needed_progress), colour = G.C.FILTER }
                )
            end
        end
	end,
    entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}

local sunny_side_up = {
    order = 21,
    object_type = "Joker",
    key = "sunny_side_up",
    config = {
        asc = 12,
        asc_mod = 2
    },
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {
        --["Sunny"] = true,
        ["Food"] = true
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.asc),
                number_format(center.ability.asc_mod),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            local asc = card.ability.asc
            card.ability.asc = card.ability.asc - card.ability.asc_mod
            if to_big(card.ability.asc) > to_big(0) then
                return {
                    plus_asc = asc
                }
            else    
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
            end
        end
	end,
    entr_credits = {
        idea = {"footlongdingledong"},
        art = {"footlongdingledong"}
    }
}

local sunflower_seeds = {
    order = 23,
    object_type = "Joker",
    key = "sunflower_seeds",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        needed = 3,
        left = 3
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 7, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {
        --["Sunny"] = true,
        ["Food"] = true
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_entr_sunny
        return {
            vars = {
                number_format(card.ability.needed),
                number_format(card.ability.left)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and ((G.GAME.current_round.current_hand.cry_asc_num or 0) + (G.GAME.asc_power_hand or 0)) ~= 0 then
            card.ability.left = card.ability.left - 1
            if card.ability.left <= 0 then
                local cards = {}
                for i, v in ipairs(G.jokers.cards) do
                    if not v.edition and v ~= card then cards[#cards+1] = v end
                end
                local jcard = pseudorandom_element(cards, pseudoseed("code_m"))
                Entropy.FlipThen({jcard}, function(card)
                    card:set_edition("e_entr_sunny")
                end)
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
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
            end
            return {
                message = number_format(card.ability.needed-card.ability.left).."/"..number_format(card.ability.needed),
                colour = G.C.GOLD,
            }
        end
	end,
    in_pool = function()
		if G.GAME.cry_asc_played and G.GAME.cry_asc_played > 0 then
			return true
		end
        return false
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local tenner = {
    order = 23,
    object_type = "Joker",
    key = "tenner",
    rarity = 1,
    cost = 4,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        dollars = 10
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.dollars),
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.3,
                blockable = false,
                func = function()
                    G.GAME.dollars = 0
                    ease_dollars(card.ability.dollars)
                    return true
                end
            }))
            return {
                message = localize("$").." = "..number_format(card.ability.dollars),
                colour = G.C.GOLD,
            }
        end
	end,
    entr_credits = {
        art = {"missingnumber"},
        idea = {"missingnumber", "cassknows"}
    }
}


local sticker_sheet = {
    order = 24,
    object_type = "Joker",
    key = "sticker_sheet",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        per_sticker = 2
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 9, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.per_sticker),
                number_format(card.ability.per_sticker * Entropy.CountStickers())
            }
        }
    end,
    calculate = function(self, card2, context)
        if context.joker_main or context.forcetrigger then
            local stickers = {
                "eternal",
                "banana",
                "perishable",
                "cry_rigged",
                "cry_global_sticker",
                "rental",
                "entr_hotfix",
                "scarred",
                "pinned",
                "entr_pseudorandom",
                "entr_pure",
                "desync"
            }
            local card = pseudorandom_element(G.play.cards, pseudoseed("sticker_sheet"))
            local sticker = pseudorandom_element(stickers, pseudoseed("sticker_sheet_sticker"))
            card.ability[sticker] = true
            if sticker == "perishable" then card.ability.perish_tally = 5 end
            card:juice_up()
            return {
                mult = card2.ability.per_sticker * Entropy.CountStickers()
            }
        end
	end,
}


local fourbit = {
    order = 25,
    object_type = "Joker",
    key = "fourbit",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        needed = 16,
        left = 16
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 4 },
    pixel_size = { w = 53, h = 53 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.needed),
                number_format(card.ability.left)
            }
        }
    end,
    calculate = function(self, card2, context)
        if context.joker_main and not context.blueprint then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, card in pairs(scoring_hand) do
                card2.ability.left = card2.ability.left - 1
                if to_big(card2.ability.left) <= to_big(0) then
                    card2.ability.left = card2.ability.needed
                    Entropy.FlipThen({card}, function(card)
                        card:set_ability(Entropy.Get4bit())
                    end)
                    card_eval_status_text(
                        card2,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                    )
                else
                    card_eval_status_text(
                        card2,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = number_format(card2.ability.needed - card2.ability.left) .."/"..number_format(card2.ability.needed), colour = G.C.GREEN }
                    )
                end
            end
        end
	end,
}

local crimson_flask = {
    order = 26,
    object_type = "Joker",
    key = "crimson_flask",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 7, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult = 1,
        xmult_joker = 0.25,
        xmult_card = 0.05
    },
    loc_vars = function(self, q, card) return {vars = {number_format(card.ability.xmult_joker), number_format(card.ability.xmult_card), number_format(card.ability.xmult)}} end,
    calculate = function(self, card, context)
        if context.joker_debuffed or context.forcetrigger then
            card.ability.xmult = card.ability.xmult + card.ability.xmult_joker
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.xmult }})
            }
        end
        if context.debuffed_card_drawn or context.forcetrigger then
            card.ability.xmult = card.ability.xmult + card.ability.xmult_card
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.xmult }})
            }
        end
        if context.setting_blind or context.forcetrigger then
            local cards = {}
            for i, v in pairs(G.jokers.cards) do if v ~= card then cards[#cards+1] = v end end
            if #cards > 0 then
                pseudorandom_element(cards, pseudoseed("crimson_flask_card")):set_debuff(true)
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"missingnumber"}
    }
}

local card_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    self.dissolved = true
    return card_dissolveref(self, ...)
end

local card_sellref = Card.sell_card
function Card:sell_card(...)
    self.dissolved = true
    return card_sellref(self, ...)
end

local card_debuffref = Card.set_debuff
function Card:set_debuff(debuff)
    if self.area == G.jokers and (debuff or (self.ability.perishable and (self.ability.perish_tally or 0) <= 0)) and self.config.center.set == "Joker" and not self.debuff and not self.dissolved then
        SMODS.calculate_context{joker_debuffed = true, card = self}
    end
    return card_debuffref(self, debuff)
end

local cardarea_emplaceref = CardArea.emplace
function CardArea:emplace(card, ...)
    if self == G.hand and G.hand and self.debuff then
        SMODS.calculate_context{debuffed_card_drawn = true, card = self}
    end
    return cardarea_emplaceref(self, card, ...)
end

local use_cardref = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave, amt)
    local ret = use_cardref(e, mute, nosave, amt)
    local card = e.config.ref_table
    if card.ability.set == 'Enhanced' or card.ability.set == 'Default' then
        SMODS.calculate_context{enhancement_added = card.config.center.key, card=card}
    end
    return ret
end
local grotesque_joker = {
    order = 27,
    object_type = "Joker",
    key = "grotesque_joker",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "m_entr_flesh"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    atlas = "placeholder",
    demicoloncompat = true,
    config = {
        xmult = 1,
        xmult_mod = 0.1,
        xchips = 1,
        xchips_mod = 0.1
    },
    loc_vars = function(self, q, card) return {vars = {
        number_format(card.ability.xmult_mod), 
        number_format(card.ability.xchips_mod), 
        number_format(card.ability.xmult),
        number_format(card.ability.xchips)
    }} 
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i, v in pairs(context.removed) do
                if v.config.center.key == "m_entr_flesh" then
                    card.ability.xchips = card.ability.xchips + card.ability.xchips_mod
                    card_eval_status_text(
                        card,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.xchips }}), colour = G.C.FILTER }
                    )
                end
            end
        end
        if context.forcetrigger then
            card.ability.xchips = card.ability.xchips + card.ability.xchips_mod
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.xchips }}), colour = G.C.FILTER }
            )
        end
        if context.enhancement_added == "m_entr_flesh" or context.forcetrigger then
            card.ability.xmult = card.ability.xmult + card.ability.xmult_mod
            return {
                message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.xmult }})
            }
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult,
                xchips = card.ability.xchips
            }
        end
    end,
    entr_credits = {
        idea = {"crabus"}
    }
}

local dog_chocolate = {
    order = 28,
    object_type = "Joker",
    key = "dog_chocolate",
    rarity = SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load and "cry_candy" or 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "tag_entr_dog"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {Food = true},
    calculate = function(self, card, context)
        if (context.tags_merged and (context.first_tag.key == "tag_entr_dog" or context.first_tag.key == "tag_entr_ascendant_dog")) or context.forcetrigger then
            if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
                local card = SMODS.add_card{
                    set="Joker",
                    rarity="cry_candy",
                    area=G.jokers
                }
            else    
                local card = SMODS.add_card{
                    set="Food",
                    area=G.jokers
                }
            end
            if context.first_tag.key == "tag_entr_ascendant_dog" then
                card:set_edition("e_negative")
            end
            return true
        end
    end,
}

local nucleotide = {
    order = 29,
    object_type = "Joker",
    key = "nucleotide",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    atlas = "placeholder",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.GAME.current_round.discarded_cards = 0
            local eval = function() return G.GAME.current_round.discarded_cards == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and (G.GAME.current_round.discarded_cards or 0) <= 0 then
            local card 
            for i, v in pairs(G.hand.cards) do
                if v.highlighted then card = v; break end
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_card = SMODS.create_card{
                        key = card.config.center.key,
                        set = card.config.center.set
                    }
                    SMODS.change_base(new_card, Entropy.GetInverseSuit(card.base.suit), Entropy.GetInverseRank(card.base.id))
                    local jkr = card
                    local found_index = 1
                    if jkr.edition then
                        for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
                            if v.key == jkr.edition.key then
                                found_index = i
                                break
                            end
                        end
                    end
                    found_index = found_index + 1
                    if found_index > #G.P_CENTER_POOLS.Edition then
                        found_index = found_index - #G.P_CENTER_POOLS.Edition
                    end
                    new_card:set_edition(G.P_CENTER_POOLS.Edition[found_index].key)
                    G.hand:emplace(new_card)
                    table.insert(G.playing_cards, new_card)
                    card:start_dissolve()
                    return true
                end
            }))
            G.GAME.current_round.discarded_cards = (G.GAME.current_round.discarded_cards or 0) + #G.hand.highlighted
        end
    end,
}

local afterimage = {
    order = 30,
    object_type = "Joker",
    key = "afterimage",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other", key="perishable", vars={5, 5}}
        q[#q+1] = {set="Other", key="banana", vars={1, 10}}
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
				card.ability.extra.odds,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in pairs(scoring_hand) do
                local old_card = v
                if pseudorandom("afterimage")
                < cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged)
                    / card.ability.extra.odds then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = copy_card(old_card)
                            new_card.ability.banana = true
                            new_card.ability.perishable = true
                            new_card.ability.perish_tally = 5
                            G.hand:emplace(new_card)
                            table.insert(G.playing_cards, new_card)
                            return true
                        end
                    }))
                end
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local qu = {
    order = 31,
    object_type = "Joker",
    key = "qu",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.first_hand_drawn or context.forcetrigger then
            local card = pseudorandom_element(G.hand.cards, pseudoseed("qu_card"))
            Entropy.FlipThen({card}, function(card)
                local elem = pseudorandom_element(Entropy.FlipsidePureInversions, pseudoseed("qu_twisted"))
                card:set_ability(G.P_CENTERS[elem])
            end)
            G.E_MANAGER:add_event(Event({
                blocking = false,
                trigger = "after",
                func = function()
                    save_run()
                    return true
                end
            }))
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end,
}

return {
    items = {
        surreal,
        solarflare,
        strawberry_pie,
        recursive_joker,
        dr_sunshine,
        sunny_joker,
        antidagger,
        solar_dagger,
        insatiable_dagger,
        rusty_shredder,
        chocolate_egg,
        lotteryticket,
        devilled_suns,
        eden,
        seventyseven,
        tesseract,
        skullcry,
        dating_simbo,
        bossfight,
        sweet_tooth,
        phantom_shopper,
        sunny_side_up,
        code_m,
        sunflower_seeds,
        tenner,
        sticker_sheet,
        fourbit,
        scenic_route,
        crimson_flask,
        grotesque_joker,
        dog_chocolate,
        nucleotide,
        afterimage,
        qu
    }
}
