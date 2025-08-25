local epitachyno = {
    object_type = "Joker",
    order = 600,
    key = "epitachyno",
    atlas = "exotic_jokers",
    rarity = "entr_entropic",
    pos = {x=0,y=1},
    soul_pos = { x = 2, y = 1, extra = { x = 1, y = 1 } },
    config = {
        extra = 1.1,
        exp_mod = 0.05
    },
    dependencies = {
        items={"set_entr_entropics"}
    },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra,
                card.ability.exp_mod
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.ending_shop and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
            for i, v in pairs(G.jokers.cards) do
                local check = false
                local exp = card.ability.extra
			    --local card = G.jokers.cards[i]
                if not Card.no(G.jokers.cards[i], "immutable", true) and (G.jokers.cards[i].config.center.key ~= "j_entr_epitachyno") then
                    Cryptid.manipulate(G.jokers.cards[i], { value = exp, type = "^" })
                    check = true
                end
			    if check then
				    card_eval_status_text(
					context.blueprint_card or G.jokers.cards[i],
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				    )
                end
            end
            card.ability.extra = card.ability.extra + card.ability.exp_mod
        end
    end,
    entr_credits = {
        art = {"Grahkon"}
    }
}

local helios = {
    order = 601,
    object_type = "Joker",
    key = "helios",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    config = {
        extra = 1.1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                1.75 + ((G.GAME.sunnumber and G.GAME.sunnumber.not_modest or 0)),
                (card.ability.extra or 1.1) + 0.4
            },
        }
    end,
    add_to_deck = function()
        Entropy.ChangeFullCSL(10000, localize("b_infinity"))
        G.GAME.HyperspaceActuallyUsed = G.GAME.used_vouchers.v_cry_hyperspacetether
        G.GAME.used_vouchers.v_cry_hyperspacetether = true
    end,
    remove_from_deck = function()
        Entropy.ChangeFullCSL(-10000)
        G.GAME.used_vouchers.v_cry_hyperspacetether = G.GAME.HyperspaceActuallyUsed
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

Cryptid.big_num_blacklist["j_entr_xekanos"] = true
local xekanos = {
    order = 602,
    object_type = "Joker",
    key = "xekanos",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    config = {
        ante_mod = 1.5,
        ante_mod_mod = 0.1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 1, y = 3, extra = { x = 0, y = 0 } },
    atlas = "xekanos_atlas",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                to_big(card.ability.ante_mod or 0) > to_big(0) and "-"..card.ability.ante_mod or 1,
                to_big(card.ability.ante_mod or 0) > to_big(0) and card.ability.ante_mod_mod or 0
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.selling_card and not context.retrigger_joker) or context.forcetrigger then
            if not context.card then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            elseif context.card.ability.set == "Joker" and Entropy.RarityAbove("3",context.card.config.center.rarity,true) then
                card.ability.ante_mod_mod = card.ability.ante_mod_mod * 0.5
            end
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

local dekatria = {
    order = 604,
    object_type = "Joker",
    key = "dekatria",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 5 },
    config = {
        e_mult_mod = 1,
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 5, extra = { x = 1, y = 5 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, q, card)
        if not card.edition or card.edition.key ~= "e_cry_m" then q[#q+1]=G.P_CENTERS.e_cry_m end
        return {
            vars = {
                card.ability.e_mult_mod,
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            local pairs = 0
            for i = 1, #G.play.cards - 1 do
                for j = i + 1, #G.play.cards do
                    local m, n = G.play.cards[i], G.play.cards[j]
                    if m:get_id() == n:get_id() then
                        pairs = pairs + 1
                    end
                end
            end
            local emult = pairs * card.ability.e_mult_mod
            return {
                Emult_mod=emult,
                message = "^" ..number_format(emult).. ' Mult',
                colour = G.C.RED,
            }
        end
    end,
}

local anaptyxi = {
    order = 605,
    object_type = "Joker",
    key = "anaptyxi",
    rarity = "entr_entropic",
    cost = 150,
    
    name = "entr-Anaptyxi",
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 6 },
    config = {
        extra = {
            scale_base = 2,
            scale=2,
            scale_mod=1
        }
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 6, extra = { x = 1, y = 6 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.extra.scale),
                number_format(card.ability.extra.scale_mod)
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.individual and not context.blueprint and not context.repetition)
            or context.forcetrigger then
            card.ability.extra.scale = card.ability.extra.scale + card.ability.extra.scale_mod
            return {
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION,
			}
        end
        return nil, nil
    end,
    calc_scaling = function(self, card, other, current_scaling, current_scalar, args)
		if not G.GAME.cryptid_base_scales then
			G.GAME.cryptid_base_scales = {}
		end
		if not G.GAME.cryptid_base_scales[other.config.center.key] then
			G.GAME.cryptid_base_scales[other.config.center.key] = {}
		end
		if not G.GAME.cryptid_base_scales[other.config.center.key][args.scalar_value] then
			G.GAME.cryptid_base_scales[other.config.center.key][args.scalar_value] = current_scalar
		end
		local true_base = G.GAME.cryptid_base_scales[other.config.center.key][args.scalar_value]
		local orig_scale_scale = current_scaling
        local new_scale = lenient_bignum(
            to_big(true_base)
                * (
                    (
                        1
                        + (
                            (to_big(orig_scale_scale) / to_big(true_base))
                            ^ (to_big(1) / to_big(card.ability.extra.scale_base))
                        )
                    ) ^ to_big(card.ability.extra.scale_base)
                )
        )
        if not Cryptid.is_card_big(joker) and to_big(new_scale) >= to_big(1e300) then
            new_scale = 1e300
        end
        if number_format(to_big(new_scale)) == "Infinity" then 
            if  not Cryptid.is_card_big(joker) then
                new_scale = 1e300 
            else
                new_scale = to_big(1e300)
            end
        end
        for i, v in pairs(G.jokers.cards) do
            if not Card.no(v, "immutable", true) and v ~= card and v ~= joker then
                Cryptid.manipulate(v, { value = to_big(card.ability.extra.scale)*to_big(new_scale), type="+"})
                card_eval_status_text(
                    v,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = "+ "..number_format(to_big(card.ability.extra.scale)*to_big(new_scale)) }
                )
            end
            if v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.odds and type(v.ability.extra.odds) == "table" then
                v.ability.extra.odds = to_number(v.ability.extra.odds)
            end
        end
        args.scalar_table[args.scalar_value] = new_scale
        return {
			message = localize("k_upgrade_ex"),
		}
	end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

local parakmi = {
    order = 606,
    object_type = "Joker",
    key = "parakmi",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 0 },
    config = {
        shop_slots = 2
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 5, y = 0, extra = { x = 4, y = 0 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, q, card)
        return {
            vars = {
                math.min(card.ability.shop_slots, 10)
            }
        }
    end,
    calculate = function(self, card, context)
    end,
    add_to_deck = function(self, card)
        G.GAME.banned_keys["sleeve_casl_none"] = true
        G.E_MANAGER:add_event(Event({
			func = function() --card slot
				-- why is this in an event?
				change_shop_size(to_number(math.min(card.ability.shop_slots, 10)))
				return true
			end,
		}))
    end,
    remove_from_deck = function(self, card)
        G.E_MANAGER:add_event(Event({
			func = function() --card slot
				-- why is this in an event?
				change_shop_size(-to_number(math.min(card.ability.shop_slots, 10)))
				return true
			end,
		}))
    end
}

local AscendantTags = {
    tag_uncommon="tag_entr_ascendant_rare",
    tag_rare="tag_entr_ascendant_epic",
    tag_negative="tag_entr_ascendant_negative",
    tag_foil="tag_entr_ascendant_foil",
    tag_holo="tag_entr_ascendant_holo",
    tag_polychrome="tag_entr_ascendant_poly",
    tag_investment="tag_entr_ascendant_stock",
    tag_voucher="tag_entr_ascendant_voucher",
    tag_boss="tag_entr_ascendant_blind",
    tag_standard="tag_entr_ascendant_twisted",
    tag_charm="tag_entr_ascendant_twisted",
    tag_meteor="tag_entr_ascendant_twisted",
    tag_buffoon="tag_entr_ascendant_ejoker",
    tag_handy="tag_entr_ascendant_stock",
    tag_garbage="tag_entr_ascendant_stock",
    tag_ethereal="tag_entr_ascendant_twisted",
    tag_coupon="tag_entr_ascendant_credit",
    tag_double="tag_entr_ascendant_copying",
    tag_juggle="tag_entr_ascendant_effarcire",
    tag_d_six="tag_entr_ascendant_credit",
    tag_top_up="tag_entr_ascendant_topup",
    tag_skip="tag_entr_ascendant_stock",
    tag_economy="tag_entr_ascendant_stock",
    tag_orbital="tag_entr_ascendant_universal",
    tag_cry_epic="tag_entr_ascendant_epic",
    tag_cry_glitched="tag_entr_ascendant_glitched",
    tag_cry_mosaic="tag_entr_ascendant_mosaic",
    tag_cry_oversat="tag_entr_ascendant_oversat",
    tag_cry_glass="tag_entr_ascendant_glass",
    tag_cry_gold="tag_entr_ascendant_gold",
    tag_cry_blur="tag_entr_ascendant_blurry",
    tag_cry_astral="tag_entr_ascendant_astral",
    tag_cry_m="tag_entr_ascendant_m",
    tag_cry_double_m="tag_entr_ascendant_m",
    tag_cry_cat="tag_entr_ascendant_cat",
    tag_cry_gambler="tag_entr_ascendant_unbounded",
    tag_cry_empowered="tag_entr_ascendant_unbounded",
    tag_cry_better_voucher="tag_entr_ascendant_better_voucher",
    tag_cry_memory="tag_entr_ascendant_copying",
    tag_cry_better_top_up="tag_entr_ascendant_better_topup",
    tag_cry_bundle="tag_entr_ascendant_ebundle",
    tag_cry_gourmand="tag_entr_ascendant_saint",
    tag_cry_triple="tag_entr_ascendant_copying",
    tag_cry_quadruple="tag_entr_ascendant_copying",
    tag_cry_quintuple="tag_entr_ascendant_copying",
    tag_cry_scope="tag_entr_ascendant_infdiscard",
    tag_cry_schematic="tag_entr_ascendant_canvas",
    tag_cry_loss="tag_entr_ascendant_reference",
    tag_cry_banana="tag_entr_ascendant_cavendish",
    tag_cry_booster="tag_entr_ascendant_booster",
    tag_cry_console="tag_entr_ascendant_twisted",
    tag_entr_dog="tag_entr_ascendant_dog",
    tag_entr_solar="tag_entr_ascendant_solar",
    tag_entr_ascendant_rare="tag_entr_ascendant_epic",
    tag_entr_ascendant_epic="tag_entr_ascendant_legendary",
    --tag_entr_ascendant_legendary="tag_entr_ascendant_exotic",
    --tag_entr_ascendant_exotic="tag_entr_ascendant_entropic",
    tag_entr_sunny = "tag_entr_ascendant_sunny",
    tag_entr_freaky = "tag_entr_ascendant_freaky",
    tag_entr_fractured = "tag_entr_ascendant_fractured"
}
for i, v in pairs(AscendantTags) do Entropy.AscendedTags[i]=v end

local exousia = {
    order = 607,
    object_type = "Joker",
    key = "exousia",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    config = {
        tags=2
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 5, y = 1, extra = { x = 4, y = 1 } },
    atlas = "exotic_jokers",
    add_to_deck = function()
        for i, v in pairs(G.GAME.tags) do
            if Entropy.AscendedTags[v.key] then
                local tag = Tag(Entropy.AscendedTags[v.key])
                if v.ability.shiny then tag.ability.shiny = v.ability.shiny end
                add_tag(tag)
                v:remove()
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.min(card.ability.tags,30)
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and not context.getting_sliced) or context.forcetrigger then
            if to_big(card.ability.tags) > to_big(30) or type(card.ability.tags) == "table" then card.ability.tags = 30 end
            for i = 1, math.min(card.ability.tags or 1,30) or 1 do
                tag = Tag(get_next_tag_key())
                add_tag(tag)
            end
        end
    end
}

local akyros = {
    order = 608,
    object_type = "Joker",
    key = "akyros",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 2 },
    config = {
        buycost = 20,
        sellcost = 20,
        base = 2,
        extra = {
			slots = 4,
		},
        immutable = {
			max_slots = 100,
		},
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 5, y = 2, extra = { x = 4, y = 2 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        if G.jokers then
            return {
                vars = {
                    card.ability.buycost,
                    card.ability.sellcost,
                    number_format(G.jokers.config.card_limit-#G.jokers.cards)
                }
            }
        end
        return {
            vars = {
                card.ability.buycost,
                card.ability.sellcost,
                "+5"
            }
        }
    end,
    calculate_dollar_bonus = function()
        return G.jokers.config.card_limit-#G.jokers.cards
    end,
	entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    remove_from_deck = function()
        if G.jokers.config.card_limit <= 1 then G.jokers.config.card_limit = 1; G.jokers.config.true_card_limit = 1 end
    end
}

Cryptid.big_num_blacklist["j_entr_katarraktis"] = true

local katarraktis = {
    order = 609,
    object_type = "Joker",
    key = "katarraktis",
    rarity = "entr_entropic",
    cost = 150,
    
    eternal_compat = true,
    blueprint_compat = true,
    pos = { x = 3, y = 3 },
    config = {
        basetriggers=1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 5, y = 3, extra = { x = 4, y = 3 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.min(card.ability.basetriggers,32)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not context.retrigger_joker then
            if to_big(card.ability.basetriggers) > to_big(32) then card.ability.basetriggers = 32 end
            local ind = 0
            local this_ind = 0
            for i, v in pairs(G.jokers.cards) do
                if v == context.other_card then ind = i end
                if v == card then this_ind = i end
            end
            local diff = ind - this_ind
            if diff >= 1 then
                if diff > 17 then diff = 17 end
                local triggers = 2 ^ (diff - 1)
                return {
					message = localize("k_again_ex"),
					repetitions = to_number(math.floor(math.min(math.min(card.ability.basetriggers,32) * triggers, 65536))),
					card = card,
				}
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows"}
    }
}

local ieros = {
    order = 603,
    object_type = "Joker",
    key = "ieros",
    rarity = "entr_entropic",
    cost = 150,
    

    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 4 },
    config = {
        e_chips = 1
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    demicoloncompat = true,
    soul_pos = { x = 2, y = 4, extra = { x = 1, y = 4 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.e_chips
            },
        }
    end,
    calculate = function(self, card, context)
        if context.buying_card and not context.retrigger_joker then
			if context.card.ability.set == "Joker" then
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "e_chips",
                    scalar_table = {increase = (Entropy.ReverseRarityChecks[1] or 0)/20.0},
                    scalar_value = "increase"
                })
            end
        end
        if context.forcetrigger then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "e_chips",
                scalar_table = {increase = (Entropy.ReverseRarityChecks[1] or 0)/20.0},
                scalar_value = "increase"
            })
        end
        if context.joker_main or context.forcetrigger then
            return {
				Echip_mod = card.ability.e_chips,
				message =  '^' .. number_format(card.ability.e_chips) .. ' Chips',
				colour = { 0.8, 0.45, 0.85, 1 },
			}
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

local exelixi = {
    order = 610,
    object_type = "Joker",
    key = "exelixi",
    rarity = "entr_entropic",
    cost = 150,
    
    eternal_compat = true,
    blueprint_compat = true,
    pos = { x = 3, y = 5 },
    config = {
        extra = {
            odds = 2
        }
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 5, y = 5, extra = { x = 4, y = 5 } },
    atlas = "exotic_jokers",
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            Entropy.FlipThen({context.other_card}, function(card)
                if Entropy.UpgradeEnhancement(card, true, {m_entr_disavowed=true, m_entr_flesh=true}) then
                    card:set_ability(G.P_CENTERS[Entropy.UpgradeEnhancement(card, true, {m_entr_disavowed=true, m_entr_flesh=true})])
                end
            end)
            return nil, true
        end
        if context.discard then
            if context.other_card.config.center.set == "Enhanced" then
                local index
                for i, v in ipairs(G.hand.cards) do
                    if v == context.other_card then index = i end
                end
                local enh = G.P_CENTERS[G.hand.cards[index].config.center.key]
                Entropy.FlipThen({G.hand.cards[index-1], G.hand.cards[index+1]}, function(card)
                    if card and G.hand.cards[index] then card:set_ability(enh) end
                end)
            end
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}


local atomikos = {
    order = 611,
    object_type = "Joker",
    key = "atomikos",
    rarity = "entr_entropic",
    cost = 150,
    config = {
        times = 2,
        left = 2
    },
    eternal_compat = true,
    blueprint_compat = true,
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    pos = { x = 6, y = 3 },
    soul_pos = { x = 8, y = 3, extra = { x = 7, y = 3 } },
    atlas = "exotic_jokers",
    calculate = function(self, card, context)
        if context.after then
            local handname = G.FUNCS.get_poker_hand_info(G.play.cards)
            if handname and ((handname ~= "High Card" and handname ~= "cry_None")) and G.GAME.hands[handname] then
                if handname ~= "High Card" and handname ~= "cry_None" then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.atomikos_deleted = G.GAME.atomikos_deleted or {}
                            G.GAME.atomikos_deleted[handname] = true
                            return true
                        end
                    }))
                end
                G.GAME.hands["High Card"].chips = G.GAME.hands["High Card"].chips + G.GAME.hands[handname].chips
                G.GAME.hands["High Card"].mult = G.GAME.hands["High Card"].mult + G.GAME.hands[handname].mult
                if G.GAME.hands["High Card"].AscensionPower or G.GAME.hands[handname].AscensionPower then
                    G.GAME.hands["High Card"].AscensionPower = (G.GAME.hands["High Card"].AscensionPower or 0) + (G.GAME.hands[handname].AscensionPower or 0)
                end
                G.GAME.hands["High Card"].l_chips = G.GAME.hands["High Card"].l_chips + G.GAME.hands[handname].l_chips
                G.GAME.hands["High Card"].l_mult = G.GAME.hands["High Card"].l_mult + G.GAME.hands[handname].l_mult
                card:juice_up()
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_atomikos"), colour = G.C.EDITION }
				)
            end
        end
    end,
    add_to_deck = function()
        if not G.GAME.atomikos_deleted then
            G.GAME.hands["High Card"].operator = "exponent"
            G.GAME.atomikos_deleted = {}
        end
    end,
    remove_from_deck = function()
        G.GAME.hands["High Card"].operator = nil
    end
}

local apeirostemma = {
    order = 612,
    object_type = "Joker",
    key = "apeirostemma",
    rarity = "entr_entropic",
    cost = 150,
    config = {
        immutable = {
            dice_effect = 1,
        },
        extra = {
            --d2
            odds = 2,
            --d3
            ee_chips = 1,
            ee_chips_mod = 0.1,
            --d5
            reroll_minus = 1,
            --d6
            retriggers = 6

        }
    },
    eternal_compat = true,
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    blueprint_compat = true,
    demicoloncompat = true,
    pos = { x = 3, y = 4 },
    soul_pos = { x = 5, y = 4, extra = { x = 4, y = 4 } },
    atlas = "exotic_jokers",
    calculate = function(self, card, context)
        local e = card.ability.immutable.dice_effect
        if e == 1 then
            if context.ending_shop or context.forcetrigger then
                local jokers = {}
                local consumables = {}
                for i, v in pairs(G.jokers.cards) do
                    if v ~= card then jokers[#jokers+1] = v end
                end
                for i, v in pairs(G.consumeables.cards) do
                    if v ~= card then consumables[#consumables+1] = v end
                end
                local joker = pseudorandom_element(jokers, pseudoseed("apeiro_dice_1_joker"))
                local cons = pseudorandom_element(consumables, pseudoseed("apeiro_dice_1_consumable"))
                if joker then
                    local jc = copy_card(joker)
                    jc:add_to_deck()
                    G.jokers:emplace(jc)
                    jc:set_edition("e_negative")
                end
                if cons then
                    local cc = copy_card(cons)
                    cc:add_to_deck()
                    G.consumeables:emplace(cc)
                    cc:set_edition("e_negative")
                end
            end
        end
        if e == 2 then
            if context.joker_main then
                for i, v in pairs(G.jokers.cards) do
                    if SMODS.pseudorandom_probability(card, 'apeiro_dice_2', 1, card.ability.extra.odds) and v ~= card then
                        local results = Cryptid.forcetrigger(v, context)
                        if results then Entropy.EvaluateEffects(results, card) end
                    end
                end
            end
        end
        if e == 3 then
            if context.joker_main or context.forcetrigger then
                if #G.play.cards == 3 or context.forcetrigger then
                    card.ability.extra.ee_chips = card.ability.extra.ee_chips + card.ability.extra.ee_chips_mod
                    local msg = SMODS.scale_card(card, {
                        ref_table = card.ability,
                        ref_value = "ee_chips",
                        scalar_value = "ee_chips_mod"
                    })
                    if not msg or type(msg) == "string" then
                        card_eval_status_text(
                            card,
                            "extra",
                            nil,
                            nil,
                            nil,
                            { message = localize("k_upgrade_ex") }
                        )
                    end
                end
                return {
                    e_chips = card.ability.extra.ee_chips
                }
            end
        end
        if e == 4 then
            if context.setting_blind or context.forcetrigger then
                local c
                for i, v in pairs(G.jokers.cards) do
                    if c then
                        Entropy.RerollJoker(card, v)
                    end
                    if v == card then c = true end
                end
            end
        end
        if e == 5 then
            if context.buying_card or context.forcetrigger then
                Cryptid.manipulate(card, {min = 1, max = 1.1, type="X"})
                card_eval_status_text(
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
            end
        end
        if e == 6 then
            if context.retrigger_joker_check
			and not context.retrigger_joker then
                return {
                    message = localize("k_again_ex"),
                    card = card,
                    repetitions = pseudorandom("apeirostemma_dice_6", 3, 9)
                }
            end
            if context.repetition
			and context.cardarea == G.play then
                return {
                    message = localize("k_again_ex"),
                    card = card,
                    repetitions = pseudorandom("apeirostemma_dice_6", 3, 9)
                }
            end
        end
    end,
    loc_vars = function(self, q, card)
        if G.SETTINGS.paused then
            return {}
        end
        local e = card.ability.immutable.dice_effect
        local vars = nil
        if e == 2 then
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
            vars =  {
                numerator,
                denominator
            }
        end
        if e == 3 then
            vars = {
                number_format(card.ability.extra.ee_chips),
                number_format(card.ability.extra.ee_chips_mod)
            }
        end
        if e == 5 then
            vars = {
                number_format(card.ability.extra.reroll_minus)
            }
        end
        if e == 6 then
            vars = {
                number_format(math.floor(math.min(card.ability.extra.retriggers, 100)))
            }
        end
        return {
            key = "j_entr_apeirostemma_"..(card.ability.immutable.dice_effect or 1),
            vars = vars
        }
    end
}


local prismatikos = {
    order = 613,
    object_type = "Joker",
    key = "prismatikos",
    rarity = "entr_entropic",
    cost = 150,
    eternal_compat = true,
    blueprint_compat = true,
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 5, y = 6, extra = { x = 4, y = 6 } },
    pos = { x = 3, y = 6 },
    atlas = "exotic_jokers",
    calculate = function(self, card, context)
        if context.individual and Entropy.DeckOrSleeve("doc") then
            ease_entropy(2)
        end
        if context.joker_main then
            local result = pseudorandom(pseudoseed("entr_prismatikos"), 1, 7)
            if result == 1 then
                local op = pseudorandom(pseudoseed("prismatikos_op"), -2, 1)
                if op == -2 then return {eq_chips = pseudorandom("prismatikos_value", 100, 5000)} end
                if op == -1 then return {chips = pseudorandom("prismatikos_value", 10, 1000)} end
                if op == 0 then return {xchips = pseudorandom("prismatikos_value", 1, 100)} end
                if op == 1 then return {echips = pseudorandom("prismatikos_value", 1, 10)} end
            elseif result == 2 then
                local op = pseudorandom(pseudoseed("prismatikos_op"), -2, 1)
                if op == -2 then return {eq_mult = pseudorandom("prismatikos_value", 100, 5000)} end
                if op == -1 then return {mult = pseudorandom("prismatikos_value", 10, 1000)} end
                if op == 0 then return {xmult = pseudorandom("prismatikos_value", 1, 100)} end
                if op == 1 then return {emult = pseudorandom("prismatikos_value", 1, 10)} end
            elseif result == 3 then
                local op = pseudorandom(pseudoseed("prismatikos_op"), -2, 0)
                if op == -2 then return ease_dollars(pseudorandom("prismatikos_value", 1, 20)) end
                if op == -1 then return ease_dollars(G.GAME.dollars * pseudorandom("prismatikos_value", 1, 5) - G.GAME.dollars) end
                if op == 0 then return ease_dollars(pseudorandom("prismatikos_value", 10, 200) - G.GAME.dollars) end
            elseif result == 4 then
                local op = pseudorandom(pseudoseed("prismatikos_op"), -1, 1)
                if op == -1 then return {plus_asc = pseudorandom("prismatikos_value", 1, 100)} end
                if op == 0 then return {asc = pseudorandom("prismatikos_value", 1, 10)} end
                if op == 1 then return {exp_asc = pseudorandom("prismatikos_value", 1, 4)} end
            elseif result == 5 then
                local mod = pseudorandom("prismatikos_value", 0, 2)
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + mod
                ease_hands_played(mod)
            elseif result == 6 then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set = "Twisted",
                            area = G.consumeables   
                        }
                        SMODS.add_card{
                            set = "Twisted",
                            area = G.consumeables   
                        }
                        return true
                    end
                })
            elseif result == 7 then
                card.ability.destroy_hand = true
            elseif result == 8 then
                for i, v in pairs(G.play.cards) do
                    v:set_edition(poll_edition("prismatikos_edition", nil, true, true))
                end
            elseif result == 9 then
                G.GAME.blind.chips = G.GAME.blind.chips * 0.9
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.HUD_blind:recalculate()
            end
        end
        if context.after and card.ability.destroy_hand then
            card.ability.destroy_hand = nil
            for i, v in pairs(G.hand.cards) do
                v:start_dissolve()
                v.ability.temporary2 = true
            end
        end
        if context.retrigger_joker_check then
            if pseudorandom(pseudoseed("prismatikos_retrigger")) then
                return {
                    repetitions = pseudorandom("prismatikos_value", 1, 4),
                    message = localize("k_again_ex")
                }
            end
        end
        if context.mod_probability then
            return {
                numerator = context.numerator * (pseudorandom(pseudoseed("prismatikos_value_prob") + 1))
            }
        end
    end,
}

return {
    items = {
        epitachyno,
        helios,
        xekanos,
        dekatria,
        anaptyxi,
        parakmi,
        exousia,
        akyros,
        katarraktis,
        ieros,
        exelixi,
        atomikos,
        apeirostemma,
        prismatikos
    }
}
