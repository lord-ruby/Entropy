local generator_meltdown = {
    order = 252,
    object_type = "Joker",
    key = "generator_meltdown",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    corruptions = {
        "j_space", 
        "j_burnt", 
        "j_supernova", 
        "j_entr_fused_lens"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end
}

local unstable_rift = {
    order = 255,
    object_type = "Joker",
    key = "unstable_rift",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        extra = {
            mult = 0,
            chips = 0,
            val = 0
        }
    },
    set_ability = function(self, card)
        math.randomseed(os.time())
        card.ability.extra.val = card.ability.extra.val or math.random() --gay ass woke transgender math.random because syncing is for losers
    end,
    --this is seperate from inversions even though they are obtained via inverting so it gets to be different
    corruptions = {
        "j_bones",
        "j_entr_skullcry"
    },
    generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
        if G.jokers then
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"] = G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"] or copy_table(G.ARGS.flame_handler.chips)
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"].id = "flame_"..tostring(card.ability.extra.val).."_chips"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_chips"].arg_tab = "flame_"..tostring(card.ability.extra.val).."_chips"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"] = G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"] or copy_table(G.ARGS.flame_handler.mult)
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"].id = "flame_"..tostring(card.ability.extra.val).."_mult"
            G.ARGS.flame_handler[tostring(card.ability.extra.val).."_mult"].arg_tab = "flame_"..tostring(card.ability.extra.val).."_mult"
        end
        full_UI_table.main = {
            {{ 
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {n=G.UIT.R, config={align = "m", colour = G.C.BLACK, r = 0.05, padding = 0.1}, nodes={
                        {n=G.UIT.C, config={align = "cr", minw = 1, minh = 0.5, r = 0.1, colour = G.C.BLUE, emboss = 0.05}, nodes={
                            {n=G.UIT.O, config={func = 'flame_handler', no_role = true, id = 'flame_'..tostring(card.ability.extra.val).."_chips", object = Moveable(0,0,0,0), w = 0, h = 0, _w = 1 * 1.25, _h = 0.5 * 2.5}},
                            {n=G.UIT.O, config={text = "chips_text", type = type, scale = 0.2*2.3, object = DynaText({
                                string = {{ref_table = card.ability.extra, ref_value = "chips"}},
                                colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = 0.2*2.3
                            })}},
                            {n=G.UIT.B, config={w = 0.1, h = 0.1}},
                        }},
                        {n=G.UIT.C, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config={text = "X", lang = G.LANGUAGES['en-us'], scale = 0.2*2, colour = G.C.UI_MULT, shadow = true}},
                        }},
                        {n=G.UIT.C, config={align = "cl", minw = 1, minh = 0.5, r = 0.1, colour = G.C.RED, emboss = 0.05}, nodes={
                            {n=G.UIT.O, config={func = 'flame_handler', no_role = true, id = 'flame_'..tostring(card.ability.extra.val).."_mult", object = Moveable(0,0,0,0), w = 0, h = 0, _w = 1 * 1.25, _h = 0.5 * 2.5}},
                            {n=G.UIT.B, config={w = 0.1, h = 0.1}},
                            {n=G.UIT.O, config={text = "mult_text", type = type, scale = 0.2*2.3, object = DynaText({
                                string = {{ref_table = card.ability.extra, ref_value = "mult"}},
                                colours = {G.C.UI.TEXT_LIGHT}, font = G.LANGUAGES['en-us'].font, shadow = true, float = true, scale = 0.2*2.3
                            })}},
                        }},
                    }}
                }
            }},
            main_box_flag = true
        }
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end
}

SMODS.Scoring_Parameter:take_ownership("mult", {
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
        if not SMODS.Calculation_Controls.mult then return end
        if (key == 'mult' or key == 'h_mult' or key == 'mult_mod') and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(amount)
            for i, v in pairs(G.jokers.cards) do
                if v.config.center_key == "j_entr_unstable_rift" then
                    v.ability.extra.mult = v.ability.extra.mult + amount * 0.2
                end
            end
            if not effect.remove_default_message then
                if from_edition then
                    card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type = 'variable', key = amount > 0 and 'a_mult' or 'a_mult_minus', vars = {amount}}, mult_mod = amount, colour = G.C.DARK_EDITION, edition = true})
                else
                    if key ~= 'mult_mod' then
                        if effect.mult_message then
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.mult_message)
                        else
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'mult', amount, percent)
                        end
                    end
                end
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center_key == "j_entr_unstable_rift" then
                        SMODS.calculate_effect({card = v, message = localize("k_upgrade_ex"), colour = G.C.RED})
                    end
                end
            end
            return true
        end
        if (key == 'x_mult' or key == 'xmult' or key == 'Xmult' or key == 'x_mult_mod' or key == 'Xmult_mod') and amount ~= 1 then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(mult * (amount - 1))
            for i, v in pairs(G.jokers.cards) do
                if v.config.center_key == "j_entr_unstable_rift" then
                    v.ability.extra.mult = v.ability.extra.mult * (1 + (amount - 1) * 0.2)
                end
            end
            if not effect.remove_default_message then
                if from_edition then
                    card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable',key= amount > 0 and 'a_xmult' or 'a_xmult_minus',vars={amount}}, Xmult_mod =  amount, colour =  G.C.EDITION, edition = true})
                else
                    if key ~= 'Xmult_mod' then
                        if effect.xmult_message then
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.xmult_message)
                        else
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'x_mult', amount, percent)
                        end
                    end
                end
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center_key == "j_entr_unstable_rift" then
                        SMODS.calculate_effect({card = v, message = localize("k_upgrade_ex"), colour = G.C.RED})
                    end
                end
            end
            return true
        end
    end,
})

SMODS.Scoring_Parameter:take_ownership("chips", {
    calc_effect = function(self, effect, scored_card, key, amount, from_edition)
        if not SMODS.Calculation_Controls.chips then return end
        if (key == 'chips' or key == 'h_chips' or key == 'chip_mod') and amount then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(amount)
            for i, v in pairs(G.jokers.cards) do
                if v.config.center_key == "j_entr_unstable_rift" then
                    v.ability.extra.chips = v.ability.extra.chips + amount * 0.2
                end
            end
            if not effect.remove_default_message then
                if from_edition then
                    card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type = 'variable', key = amount > 0 and 'a_chips' or 'a_chips_minus', vars = {amount}}, chip_mod = amount, colour = G.C.EDITION, edition = true})
                else
                    if key ~= 'chip_mod' then
                        if effect.chip_message then
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.chip_message)
                        else
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'chips', amount, percent)
                        end
                    end
                end
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center_key == "j_entr_unstable_rift" then
                        SMODS.calculate_effect({card = v, message = localize("k_upgrade_ex"), colour = G.C.BLUE})
                    end
                end
            end
            return true
        end
        if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') and amount ~= 1 then
            if effect.card and effect.card ~= scored_card then juice_card(effect.card) end
            self:modify(hand_chips * (amount - 1))
            for i, v in pairs(G.jokers.cards) do
                if v.config.center_key == "j_entr_unstable_rift" then
                    v.ability.extra.chips = v.ability.extra.chips * (1 + (amount - 1) * 0.2)
                end
            end
            if not effect.remove_default_message then
                if from_edition then
                    card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = localize{type='variable',key= amount > 0 and 'a_xchips' or 'a_xchips_minus',vars={amount}}, Xchips_mod =  amount, colour =  G.C.EDITION, edition = true})
                else
                    if key ~= 'Xchip_mod' then
                        if effect.xchip_message then
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.xchip_message)
                        else
                            card_eval_status_text(effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, 'x_chips', amount, percent)
                        end
                    end
                end
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center_key == "j_entr_unstable_rift" then
                        SMODS.calculate_effect({card = v, message = localize("k_upgrade_ex"), colour = G.C.BLUE})
                    end
                end
            end
            return true
        end
    end,
})

local calc_score = SMODS.calculate_round_score
SMODS.calculate_round_score = function(flames, ...)
    if G.GAME.current_round.hands_left == 0 and next(SMODS.find_card("j_entr_unstable_rift")) then
        local c = SMODS.find_card("j_entr_unstable_rift")[1]
        return c.ability.extra.mult * c.ability.extra.chips
    end
    return calc_score(flames, ...)
end

SMODS.Sticker({
    badge_colour = Entropy.void_gradient,
    prefix_config = { key = false },
    key = "entr_death_mark",
    atlas = "marked",
    pos = { x = 1, y = 0 },
    should_apply = false,
    draw = function(self, card) --don't draw shine
        local notilt = nil
        if card.area and card.area.config.type == "deck" then
            notilt = true
        end
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader("dissolve", nil, nil, notilt, card.children.center)
    end,
    loc_vars = function(self, q, card)
        if card.ability.consumeable then
            return {
                key = "entr_death_mark_consumeable"
            }
        end
    end
})

local yaldabaoth = {
    order = 263,
    object_type = "Joker",
    key = "yaldabaoth",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        extra = {
            asc_pow = 0,
            asc_pow_mod = 0.3
        }
    },
    corruptions = {
        "j_ceremonial_dagger", 
        "j_entr_solar_dagger", 
        "j_entr_insatiable_dagger", 
        "j_entr_antidagger"
    },
    calculate = function(self, card, context)
        if context.post_open_booster then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                delay = 0.25,
                func = function()
                    local card = pseudorandom_element(G.pack_cards.cards, pseudoseed("j_entr_chocolates"))
                    card.ability.entr_death_mark = true
                    card:juice_up()
                    return true
                end
            })
            return nil, true
        end
        if (context.post_trigger or context.individual) and context.other_card.ability and context.other_card.ability.entr_death_mark and not context.other_card.getting_sliced then
            local c = context.other_card
            c.getting_sliced = true
            return {
                func = function()
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            SMODS.scale_card(card, {
                                ref_table = card.ability.extra,
                                ref_value = "asc_pow",
                                scalar_value = "asc_pow_mod",
                                message_colour = Entropy.void_gradient
                            })
                            SMODS.destroy_cards(c)
                            return true
                        end
                    })
                end
            }
        end
        if context.using_consumeable and context.consumeable.ability.entr_death_mark then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "asc_pow",
                scalar_value = "asc_pow_mod",
                message_colour = Entropy.void_gradient
            })
            return nil, true
        end
        if context.joker_main then
            return {
                plus_asc = card.ability.extra.asc_pow
            }
        end
    end,
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "entr_death_mark"}
        return {
            vars = {
                card.ability.extra.asc_pow_mod,
                card.ability.extra.asc_pow
            }
        }
    end
}

local antimatter_sheath = {
    order = 263,
    object_type = "Joker",
    key = "antimatter_sheath",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }   
    },
    config = {
        extra = {
            cards = 2,
            xchips = 1,
            xmult = 1,
            xchips_mod = 0.05,
            xmult_mod = 0.05
        }
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            for i = 1, math.min(card.ability.extra.cards, 10) do
                local _card = SMODS.create_card { key = "c_entr_dagger", area = G.discard }
                _card.ability.void_temporary = true --third temporary because :3
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then
                            context.blueprint_card:juice_up()
                        else
                            card:juice_up()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                        return true
                    end
                }))
                save_run()
            end
        end
        if context.individual and context.cardarea == G.play and context.other_card.config.center.key == "c_entr_dagger" then
            local cards = {}
            for i, v in pairs(G.hand.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            for i, v in pairs(G.discard.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            for i, v in pairs(G.deck.cards) do
                if not SMODS.is_eternal(v) then
                    cards[#cards+1] = v
                end
            end
            local c = pseudorandom_element(cards, pseudoseed("entr_sheath_destroy"))
            SMODS.destroy_cards(c)
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "xmult_mod",
                message_key = "a_xmult",
                message_colour = G.C.RED
            })
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xchips",
                scalar_value = "xchips_mod",
                message_key = "a_xchips",
                message_colour = G.C.BLUE
            })
            return nil, true
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
                xmult = card.ability.extra.xchips,
            }
        end
    end,
    corruptions = {
        "j_ceremonial_dagger",
        "j_entr_solar_dagger",
        "j_entr_insatiable_dagger",
        "j_entr_antidagger"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.c_entr_dagger
        return {
            vars = {
                card.ability.extra.cards,
                card.ability.extra.xmult_mod,
                card.ability.extra.xchips_mod,
                card.ability.extra.xmult,
                card.ability.extra.xchips,
            }
        }
    end
}

local caledscratch = {
    order = 264,
    object_type = "Joker",
    key = "caledscratch",
    rarity = "entr_void",
    cost = 10,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    soul_pos = {x=0,y=1},
    atlas = "void_jokers",
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        extra = {
            repetitions = 0
        }
    },
    calculate = function(self, card, context)
        if context.entr_repetition_blocked then
            card.ability.extra.repetitions = card.ability.extra.repetitions + 1
        end
        if context.retrigger_joker_check and context.other_card == card.area.cards[1] and card.ability.extra.repetitions > 0 then
            local reps = card.ability.extra.repetitions
            card.ability.extra.repetitions = 0
            return {
                repetitions = reps,
                colour = Entropy.void_gradient
            }
        end
    end,
    corruptions = {
        "j_mime",
        "j_dusk",
        "j_sock_and_buskin", 
        "j_hack",
        "j_selzer", 
        "j_entr_opal",
        "j_entr_fasciation",
        "j_entr_bell_curve", 
        "j_entr_rubber_ball",
        "j_hanging_chad", 
        "j_entr_pineapple", 
        "j_entr_twisted_pair", 
        "j_entr_d7"
    },
    add_to_deck = function(self)
        G.GAME.entr_perma_inversions = G.GAME.entr_perma_inversions or {}
        for i, v in pairs(self.corruptions) do
            G.GAME.entr_perma_inversions[v] = self.key
        end
    end
}

return {
    items = {
        generator_meltdown,
        unstable_rift,
        yaldabaoth,
        antimatter_sheath,
        caledscratch
    }
}