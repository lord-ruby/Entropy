local surreal = {
    order = 1,
    object_type = "Joker",
    key = "surreal_joker",
    config = {
        qmult = 4
    },
    rarity = 1,
    cost = 7,
    
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
                Eqmult_mod = card.ability.qmult
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

local ref = update_hand_text

function update_hand_text(config, vals)
    if type(vals.mult) == "number" or type(vals.mult) == "table" and HasJoker("j_entr_tesseract",true) and math.abs(to_big(vals.mult)) > to_big(0.001) then
        local total_angle = 0
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_tesseract" then
                total_angle = total_angle + v.ability.degrees
            end
        end
        total_angle = (total_angle/360)*2*3.141592
        local base = {r=math.cos(total_angle),c=math.sin(total_angle)}
        local str = Entropy.WhatTheFuck(base, vals.mult)
        vals.mult = str
    end
    if type(vals.chips) == "number" or type(vals.chips) == "table" and HasJoker("j_entr_tesseract",true) and math.abs(to_big(vals.chips)) > to_big(0.001) then
        local total_angle = 0
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_tesseract" then
                total_angle = total_angle + v.ability.degrees
            end
        end
        total_angle = -(total_angle/360)*2*3.14159265
        local base = {r=math.cos(total_angle),c=math.sin(total_angle)}
        local str = Entropy.WhatTheFuck(base, vals.chips)
        vals.chips = str
    end
    ref(config, vals)
end

local solarflare = {
    order = 3,
    object_type = "Joker",
    key = "solarflare",
    name="entr-solarflare",
    config = {
        asc=1.6
    },
    rarity = 2,
    cost = 2,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and not center.edition.sol) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_solar
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
			and context.other_joker.edition.sol
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
				asc = lenient_bignum(card.ability.asc),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.sol then
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
			and context.other_card.edition.sol
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
					asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
        if context.forcetrigger then
            return {
                asc = lenient_bignum(card.ability.asc),
                card = card,
            }
        end
	end
}

local create_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if card and card.ability and card.ability.name == "entr-solarflare" then
		card:set_edition("e_entr_solar", true, nil, true)
	end
    if card and card.ability and card.ability.name == "entr-trapezium_cluster" then
		card:set_edition("e_entr_fractured", true, nil, true)
	end
    return card
end

local strawberry_pie = {
    order = 4,
    object_type = "Joker",
    key = "strawberry_pie",
    config = {
        level_amount = 1.25
    },
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
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.level_amount)
            },
        }
    end,
}
local ref = level_up_hand
function level_up_hand(card, hand, instant, amount)
    if HasJoker("j_entr_strawberry_pie",true) and hand ~= "High Card" then
        local mult = 1
        for i, v in pairs(G.jokers.cards) do
            if v.config.center.key == "j_entr_strawberry_pie" and not v.debuff then
                hand = "High Card"
                mult = v.ability.level_amount
            end
        end
        amount = (amount or 1) * mult
    end
    ref(card,hand,instant,amount)
end

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
        if context.selling_card and context.card == card and not card.ability.used_this_round then
            card.ability.used_this_round = true
            local card = copy_card(card)
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
        if context.setting_blind then
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
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i+1] then check = i+1 end
            end
            if check then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sliced_card = G.jokers.cards[check]
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
        idea = {"cassknows"}
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
    pos = { x = 7, y = 0 },
    atlas = "jokers",
    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i-1] then check = i-1 end
            end
            if check then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sliced_card = G.jokers.cards[#G.jokers.cards]
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("a800ff") }, nil, 1.6)
                        G.GAME.banned_keys[sliced_card.config.center.key] = true
                        eval_card(sliced_card, {banishing_card = true, banisher = card, card = sliced_card, cardarea = sliced_card.area})
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        local check2
                        if not Card.no(G.jokers.cards[check], "immutable", true) then
                            Cryptid.with_deck_effects(G.jokers.cards[check], function(card)
                                Cryptid.misprintize(G.jokers.cards[check], { min = sliced_card.sell_cost * 0.05 + 1, max = sliced_card.sell_cost * 0.05 + 1 }, nil, true)
                            end)
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
        idea = {"cassknows"}
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
        idea = {"cassknows"}
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
    pos = { x = 8, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Food"] = true, ["Candy"] = true },
    calculate = function(self, card, context)
        if context.banishing_card and context.area == G.jokers and G.jokers then
            card.ability.no_destroy = true
            local c = create_card("Joker", G.jokers, nil, "cry_epic")
            c:add_to_deck()
            G.jokers:emplace(c)
        end
        if context.selling_self then card.ability.no_destroy = true end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}
local start_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    start_dissolveref(self, ...)
    if self.config.center.key == "j_entr_chocolate_egg" and not self.ability.no_destroy and self.area == G.jokers and G.jokers then
        local c = create_card("Joker", G.jokers, nil, "Rare")
        c:add_to_deck()
        G.jokers:emplace(c)
    end
end
return {
    items = {
        surreal,
        tesseract,
        solarflare,
        strawberry_pie,
        recursive_joker,
        dr_sunshine,
        antidagger,
        solar_dagger,
        insatiable_dagger,
        rusty_shredder,
        sunny_joker,
        chocolate_egg
    }
}