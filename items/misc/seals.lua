local crimson = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3001,
    key="entr_crimson",
    atlas = "seals",
    pos = {x=0,y=0},
    badge_colour = HEX("8a0050"),
    calculate = function(self, card, context)
        if (context.cardarea == G.play or context.cardarea == G.hand) and not context.crimson_trigger then
            for i, v in ipairs(G.play.cards) do
                if G.play.cards[i+1] == card or G.play.cards[i-1] == card then
                    context.crimson_trigger = true
                    local eval, post = eval_card(v, context)
                    local effects = {eval}
                    if context.main_scoring then 
                        eval.chips = v.base.nominal + v.ability.bonus or 0
                        SMODS.calculate_context({individual = true, other_card=v, cardarea = v.area})
                    end
                    for _,v in ipairs(post or {}) do effects[#effects+1] = v end
                    if eval.retriggers then
                        for rt = 1, #eval.retriggers do
                            local rt_eval, rt_post = eval_card(v, context)
                            table.insert(effects, {eval.retriggers[rt]})
                            table.insert(effects, rt_eval)
                            for _, v in ipairs(rt_post) do effects[#effects+1] = v end
                            if context.main_scoring then 
                                table.insert(effects, {chips = v.base.nominal + v.ability.bonus or 0}) 
                                SMODS.calculate_context({individual = true, other_card=v, cardarea = v.area})
                            end
                        end
                    end
                    SMODS.trigger_effects(effects, v)
                end
            end
            context.crimson_trigger = nil
        end
    end,
}

local sapphire = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3002,
    key="entr_sapphire",
    atlas = "seals",
    pos = {x=1,y=0},
    badge_colour = HEX("8653ff"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "regulus"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.new_key end
            end
            local key = "c_entr_"..pkey
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                        local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                        c:add_to_deck()
                        G.consumeables:emplace(c)
                    end
                    return true
                end
            }))
        end
        if context.forcetrigger then
            local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local silver = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3003,
    key="entr_silver",
    atlas = "seals",
    pos = {x=2,y=0},
    badge_colour = HEX("84a5b7"),
    calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
            return {
                func = function()
                    for i, v in ipairs(G.hand.cards) do
                        local res = Entropy.GetRepetitions(v)
                        if v.debuff then res.repetitions = nil end
                        for i = 1, (res.repetitions or 0) + 1 do
                            if i > 1 then
                                card_eval_status_text(
                                    v,
                                    "extra",
                                    nil,
                                    nil,
                                    nil,
                                    { message = localize("k_again_ex"), colour = G.C.RED }
                                )
                            end
                            if v.debuff then
                                card_eval_status_text(
                                    v,
                                    "extra",
                                    nil,
                                    nil,
                                    nil,
                                    { message = localize("k_debuffed"), colour = G.C.RED }
                                )
                            else
                                SMODS.calculate_individual_effect({dollars = 1}, v, 'dollars', 1, false)
                            end
                        end
                    end
                end
            }
        end
        if context.forcetrigger then
            return {
                func = function()
                    for i, v in ipairs(G.hand.cards) do
                        local res = Entropy.GetRepetitions(v)
                        if v.debuff then res.repetitions = nil end
                        for i = 1, (res.repetitions or 0) + 1 do
                            if v.debuff then
                                card_eval_status_text(
                                    v,
                                    "extra",
                                    nil,
                                    nil,
                                    nil,
                                    { message = localize("k_debuffed"), colour = G.C.RED }
                                )
                            else
                                SMODS.calculate_individual_effect({dollars = 1}, v, 'dollars', 1, false)
                            end
                            if i > 1 then
                                card_eval_status_text(
                                    v,
                                    "extra",
                                    nil,
                                    nil,
                                    nil,
                                    { message = localize("k_again_ex"), colour = G.C.RED }
                                )
                            end
                        end
                    end
                end
            }
        end
    end,
    draw = function(self, card, layer)
		G.shared_seals["entr_silver"].role.draw_major = card
        G.shared_seals["entr_silver"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["entr_silver"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

local pink = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3004,
    key="entr_pink",
    atlas = "seals",
    pos = {x=3,y=0},
    badge_colour = HEX("cc48be"),
    calculate = function(self, card, context)
        if context.pre_discard and context.cardarea == G.hand and card.highlighted then
            card.ability.temporary2 = true
            card:remove_from_deck()
            card:start_dissolve()
            G.E_MANAGER:add_event(Event({
                func = function()
                    if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                        local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
                        c:add_to_deck()
                        G.consumeables:emplace(c)
                    end
                    return true
                end
            }))
            SMODS.calculate_context({remove_playing_cards = true, removed={card}})
        end
        if context.forcetrigger then
            local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local verdant = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3005,
    key="entr_verdant",
    atlas = "seals",
    pos = {x=4,y=0},
    badge_colour = HEX("75bb62"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if #scoring_hand == 1 then
                G.E_MANAGER:add_event(Event({
					func = function()
                        if G.consumeables.config.card_count < G.consumeables.config.card_limit then
                            local c = create_card("Command", G.consumeables, nil, nil, nil, nil, nil) 
                            c:add_to_deck()
                            G.consumeables:emplace(c)
                        end
                        return true
                    end
                }))
            end
        end
        if context.forcetrigger then
            local key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant"))
            while G.P_CENTERS[key].set ~= "Command" do key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant")) end
            local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
            c:add_to_deck()
            G.consumeables:emplace(c)
        end
    end,
}

local cerulean = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3006,
    key="entr_cerulean",
    atlas = "seals",
    pos = {x=5,y=0},
    badge_colour = HEX("4078e6"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "regulus"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.new_key end
            end
            local key = "c_entr_"..pkey
            for i = 1, 3 do
                    local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                    c:add_to_deck()
                    c:set_edition("e_negative")
                    G.consumeables:emplace(c)
                end
            for i, v in pairs(scoring_hand) do
                v.ability.temporary2 = true
            end
            SMODS.calculate_context({remove_playing_cards = true, removed=scoring_hand})
        end
        if context.forcetrigger then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "pluto"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.key end
            end
            local key = "c_entr_"..pkey
            for i = 1, 3 do
                local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                c:add_to_deck()
                c:set_edition("e_negative")
                G.consumeables:emplace(c)
            end
        end
    end,
}

return {
    items = {
        crimson,
        sapphire,
        silver,
        pink,
        verdant,
        cerulean
    }
}
