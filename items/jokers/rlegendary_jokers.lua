local oekrep = {
    order = 200,
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
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 0 },
    soul_pos = { x = 4, y = 1 },
    atlas = "reverse_legendary",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
    end,
    immutable = true,
    demicoloncompat = true,
    calculate = function (self, card, context)
        if context.ending_shop or context.forcetrigger then
            if #G.consumeables.cards > 0 then
                local e = pseudorandom_element(G.consumeables.cards, pseudoseed("roekrep"))
                local set = e.config.center.set
                local tries = 0
                while not Entropy.BoosterSets[set] and tries < 100 do
                    e = pseudorandom_element(G.consumeables.cards, pseudoseed("roekrep"))
                    set = e.config.center.set
                end 
                if Entropy.BoosterSets[set] then
                    e:start_dissolve()
                    local c = create_card("Booster", G.consumeables, nil, nil, nil, nil, key) 
                    c:set_ability(G.P_CENTERS[Entropy.BoosterSets[set] or "p_standard_normal_1"])
                    c:add_to_deck()
                    c.T.w = c.T.w *  2.0/2.6
                    c.T.h = c.T.h *  2.0/2.6
                    table.insert(G.consumeables.cards, c)
                    c.area = G.consumeables
                    c:set_edition("e_negative")
                    c.RPerkeoPack = true
                    G.consumeables:align_cards()
                    G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
                end
            end
        end
    end
}

local tocihc = {
    order = 201,
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
        if (context.setting_blind and not card.getting_sliced) or context.forcetrigger then
            local tag
            local type = G.GAME.blind:get_type()

            if type == "Boss" then
                tag = Tag(get_next_tag_key())
                if context.forcetrigger then
                    G.GAME.blind.chips = G.GAME.blind.chips * 0.2
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    G.HUD_blind:recalculate()
                end
            else
                tag = Tag(G.GAME.round_resets.blind_tags[type])
                if not context.blueprint then
                    G.GAME.blind.chips = G.GAME.blind.chips * 0.2
                end
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
                --card:juice_up()
            end
            for i = 0, 10 do
                if not tag.ability.shiny or tag.ability.shine == false then
                    tag.ability.shiny=Cryptid.is_shiny()
                end
            end
            add_tag(tag)
        end
    end
}

local teluobirt = {
    order = 203,
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
                    message = localize("cry_again_q"),
                    repetitions = order-1,
                    card = card,
                }
            end
        end
    end
}

local oinac = {
    order = 204,
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
    order = 205,
    object_type = "Joker",
    key = "entropy_card",
    config = {
        x_asc_mod = 1,
        num = 464 --sun
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
    order = 202,
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
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + card.ability.csl
        G.hand.config.card_limit = G.hand.config.card_limit + math.min(card.ability.hs, 1000)
    end,
    remove_from_deck = function(self, card)
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - card.ability.csl
        G.hand.config.card_limit = G.hand.config.card_limit - math.min(card.ability.hs, 1000)
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
return {
    items = {
        oekrep,
        tocihc,
        teluobirt,
        oinac,
        entropy_card,
        kciroy
    }
}
