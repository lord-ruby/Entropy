local epitachyno = {
    object_type = "Joker",
    order = 600,
    key = "epitachyno",
    atlas = "exotic_jokers",
    rarity = "entr_entropic",
	cost = 150,
    pos = {x=0,y=1},
    soul_pos = { x = 2, y = 1, extra = { x = 1, y = 1 } },
    config = {
        left = 1,
        left_mod = 1,
    },
    dependencies = {
        items={"set_entr_entropics", "set_entr_actives"}
    },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.left,
                card.ability.left_mod
            },
        }
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            Entropy.FlipThen({card}, function(c)
                c.ability.epitach_consumeable = Entropy.get_random_rare().key
                local center = G.P_CENTERS[c.ability.epitach_consumeable]
                if c.children.floating_sprite then
                    c.children.floating_sprite:remove()
                end
                if c.children.floating_sprite2 then
                    c.children.floating_sprite2:remove()
                end
                if c.children.center then
                    c.children.center:remove()
                end
                c.children.center = nil
                c.children.floating_sprite = nil
                c.children.floating_sprite2 = nil
                c:set_sprites(G.P_CENTERS[c.ability.epitach_consumeable])
                if c.ability.epitach_consumeable == "c_soul" then
                    --c.children.floating_sprite = G.shared_soul
                end
                if c.children.floating_sprite2 then
                    c.children.floating_sprite2:set_sprite_pos(center.tsoul_pos and center.tsoul_pos.extra or center.soul_pos and center.soul_pos.extra or {x=999,y=999})
                end
                if c.children.floating_sprite then
                    c.children.floating_sprite:set_sprite_pos(center.tsoul_pos or center.soul_pos or {x=999,y=999})
                end
            end)
            delay(0.5)
        end
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            local center = card.config.center
            Entropy.FlipThen({card}, function(c)
                if c.children.floating_sprite then
                    c.children.floating_sprite:remove()
                end
                if c.children.floating_sprite2 then
                    c.children.floating_sprite2:remove()
                end
                if c.children.center then
                    c.children.center:remove()
                end
                c.children.center = nil
                c.children.floating_sprite = nil
                c.children.floating_sprite2 = nil
                c.ability.epitach_consumeable = nil
                c:set_sprites(c.config.center)
                if c.children.floating_sprite2 then
                    c.children.floating_sprite2:set_sprite_pos(center.tsoul_pos and center.tsoul_pos.extra or center.soul_pos and center.soul_pos.extra or {x=999,y=999})
                end
                if c.children.floating_sprite then
                    c.children.floating_sprite:set_sprite_pos(center.tsoul_pos or center.soul_pos or {x=999,y=999})
                end
            end)
            delay(0.5)
        end
        if (context.end_of_round and not context.blueprint and not context.individual and G.GAME.blind_on_deck == "Boss" and not context.repetition) or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", scaling_message = {message = "+"..number_format(card.ability.left_mod)}})
        end
    end,
    set_sprites = function(self, card)
        if card.ability and card.ability.epitach_consumeable then
            G.E_MANAGER:add_event(Event{
                func = function()
                    if card.children.floating_sprite then
                        card.children.floating_sprite:remove()
                    end
                    if card.children.floating_sprite2 then
                        card.children.floating_sprite2:remove()
                    end
                    if card.children.center then
                        card.children.center:remove()
                    end
                    local center = G.P_CENTERS[card.ability.epitach_consumeable]
                    card.children.center = nil
                    card.children.floating_sprite = nil
                    card.children.floating_sprite2 = nil
                    card:set_sprites(center)
                    if card.children.floating_sprite2 then
                        card.children.floating_sprite2:set_sprite_pos(center.tsoul_pos and center.tsoul_pos.extra or center.soul_pos and center.soul_pos.extra or {x=999,y=999})
                    end
                    if card.children.floating_sprite then
                        card.children.floating_sprite:set_sprite_pos(center.tsoul_pos or center.soul_pos or {x=999,y=999})
                    end
                    if card.ability.epitach_consumeable == "c_soul" then
                        --card.children.floating_sprite = G.shared_soul
                    end
                    return true
                end
            })
        end
    end,
    can_use = function(self, card)
        if card.ability.epitach_consumeable then
            local dummy = Entropy.GetDummy(G.P_CENTERS[card.ability.epitach_consumeable], G.consumeables, card)
            return to_big(card.ability.left) > to_big(0) and Card.can_use_consumeable(dummy)
        end
    end,
    use = function(self, card)
        local dummy = Entropy.GetDummy(G.P_CENTERS[card.ability.epitach_consumeable], G.consumeables, card)
        Cryptid.forcetrigger(dummy, {})
        card.ability.left = card.ability.left - 1
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
        extra = 3
    },
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    soul_pos = { x = 2, y = 2, extra = { x = 1, y = 2 } },
    atlas = "exotic_jokers",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = "Other", key = "entr_marked"}
        return {
            vars = {
                card.ability.extra
            },
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            for i, v in pairs(G.hand.cards) do
                if v:get_id() == context.other_card:get_id() and not v.ability.entr_marked then
                    local c = v
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            c:juice_up()
                            c.ability.entr_marked = true
                            return true
                        end
                    })
                    delay(0.25)
                end
            end
        end
        if context.before then
            for i, v in pairs(G.I.CARD) do
                if type(v) == "table" and v.ability and v.ability.entr_marked then
                    if v.area then
                        v.area:remove_card(v)
                    end
                    local h = v
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            h:highlight(true)
                            return true
                        end
                    })
                    G.play:emplace(v)
                end
            end
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        
        local cards = {}
        for i, v in pairs(G.I.CARD) do
            if v.ability and v.ability.entr_marked and not v.ability.entr_marked_bypass then
                local s = v:save()
                local c = Card(0,0, G.CARD_W, G.CARD_H, pseudorandom_element(G.P_CARDS,pseudoseed("")), G.P_CENTERS.c_base)
                c:load(s)
                c.ability = SMODS.shallow_copy(c.ability)
                c.ability.entr_marked_bypass = true
                v.ability.entr_marked_bypass = nil                
                table.insert(cards, c)
            end
        end
        if #cards > 0 then
            Entropy.card_area_preview(G.entrCardsPrev, desc_nodes, {
                cards = cards,
                override = true,
                w = 2.2,
                h = 0.6,
                ml = 0,
                scale = 0.5,
                func_delay = 1.0,
            })
        end
    end,
}

if Cryptid.big_num_blacklist then Cryptid.big_num_blacklist["j_entr_xekanos"] = true end
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
    calculate = function(self, card, context)
        if context.post_trigger and context.other_card.config.center_key ~= "j_entr_dekatria" then
            local star = pseudorandom("entr_dekatria") < 0.25
            local pool = star and G.P_CENTER_POOLS.Star or G.P_CENTER_POOLS.Planet
            local planet
            local hand = context.other_context.scoring_name
            for i, v in pairs(pool) do
                if v.config and hand and (v.config.hand_type == hand or v.config.handname == hand) then
                    planet = v
                end
            end
            return {
                func = function()
                    if planet then
                        G.entr_add_to_stats = true
                        Card.use_consumeable(Entropy.GetDummy(G.P_CENTERS[planet.key], G.consumeables, context.other_card))
                        G.entr_add_to_stats = nil
                        update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
                    end
                end
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
            scale=0.5,
            scale_mod=0.25
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
		-- store original scaling rate
		if not other.ability.cry_scaling_info then
			other.ability.cry_scaling_info = {
				[args.scalar_value] = current_scalar
			}
		elseif not other.ability.cry_scaling_info[args.scalar_value] then
			other.ability.cry_scaling_info[args.scalar_value] = current_scalar
		end

        -- joker scaling stuff
		local original_scalar = other.ability.cry_scaling_info[args.scalar_value]
        local new_scale = current_scalar
        for i, v in pairs(G.jokers.cards) do
            if not Card.no(v, "immutable", true) and v ~= card and v ~= other then
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
            if to_big(card.ability.tags) > to_big(30) or type(card.ability.tags) ~= "number" then card.ability.tags = 30 end
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

if Cryptid.big_num_blacklist then Cryptid.big_num_blacklist["j_entr_katarraktis"] = true end

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
        left = 1,
        left_mod = 1
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
        if context.end_of_round then
            card.ability.extra = nil
        end
        if context.repetition or context.retrigger_joker_check then
            if card.ability.extra then
                for i, v in pairs(card.ability.extra) do
                    if i == context.other_card.unique_val then
                        return {
                            repetitions = v
                        }
                    end
                end
            end
        end
        if context.after then
            for i, v in pairs(card.ability.extra or {}) do
                if G.P_CENTERS[i] then
                    for _ = 1, v do
                        G.E_MANAGER:add_event(Event{
                            func = function()
                                Cryptid.forcetrigger(Entropy.GetDummy(G.P_CENTERS[i], G.consumeables, card))
                                return true
                            end
                        })
                    end
                end
            end
        end
        if (context.end_of_round and not context.blueprint and not context.individual and not context.repetition) or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", scaling_message = {message = "+"..number_format(card.ability.left_mod)}})
        end
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, 9999)
        return to_big(card.ability.left) > to_big(0) and num > 0
    end,
    use = function(self, card)
        local cards = Entropy.GetHighlightedCards({G.hand, G.jokers, G.consumeables}, card, 1, 9999)
        card.ability.extra = {}
        for i, v in pairs(cards) do
            if v.ability.consumeable then 
                card.ability.extra[v.config.center_key] = (card.ability.extra[v.config.center_key] or 0) + 1
            else
                card.ability.extra[v.unique_val] = (card.ability.extra[v.unique_val] or 0) + 1
            end
            local c = v
            G.E_MANAGER:add_event(Event{
                func = function()
                    c.area:remove_from_highlighted(v)
                    c:highlight(false)
                    c:juice_up()
                    return true
                end
            })
            delay(0.5)
        end
        card.ability.left = card.ability.left - 1
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.left,
                card.ability.left_mod
            }
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

local heimartai = {
    order = 614,
    object_type = "Joker",
    key = "heimartai",
    rarity = "entr_entropic",
    cost = 150,
    eternal_compat = true,
    blueprint_compat = true,
    dependencies = {
        items = {
            "set_entr_entropics"
        }
    },
    pos = { x = 6, y = 4 },
    soul_pos = { x = 8, y = 4, extra = { x = 7, y = 4 } },
    atlas = "exotic_jokers",
    config = {
        echips = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.echips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                echips = card.ability.echips
            }
        end
    end,
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
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
        prismatikos,
        heimartai
    }
}
