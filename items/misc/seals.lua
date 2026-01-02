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
        if (context.cardarea == G.play or context.cardarea == G.hand) and not card.crimson_trigger then
            for i, v in ipairs(card.area.cards) do
                if card.area.cards[i+1] == card or card.area.cards[i-1] == card then
                    local eval, post = SMODS.eval_individual(v, context)
                    eval = eval or {}
                    local effects = {eval}
                    if (eval and next(eval)) or (post and next(post)) or (context.main_scoring and context.cardarea == G.play) then
                        SMODS.calculate_effect({message = localize("k_again_ex"), colour = HEX("8a0050"), card = v})
                        if not card.crimson_trigger then
                            G.E_MANAGER:add_event(Event{
                                trigger = "before",
                                func = function()
                                    card.crimson_trigger = nil
                                    return true
                                end
                            })
                        end
                        card.crimson_trigger = true
                    end
                    if context.main_scoring then 
                        G.message_card = v
                        eval.chips = v.base.nominal + v.ability.bonus or 0
                        SMODS.calculate_context({individual = true, other_card=v, cardarea = v.area, scoring_hand = context.scoring_hand})
                        G.message_card = nil
                    end
                    for _,v in ipairs(post or {}) do effects[#effects+1] = v end
                    SMODS.trigger_effects(effects, v)
                end
            end
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
        if (context.playing_card_end_of_round and context.cardarea == G.hand) or context.forcetrigger then
             return { message = localize('k_level_up_ex'), colour = G.C.PURPLE, func = function()
                SMODS.upgrade_poker_hands({hands = G.GAME.last_hand_played, from = card, ascension_power = 0.25})
             end}
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
            if not SMODS.is_eternal(card) then
                local link = card.ability.link
                if link then
                    local cards = {card}
                    for i, v in pairs(G.hand.cards) do
                        if v.ability.link == link then
                            cards[#cards+1] = v
                            v.ability.temporary2 = true
                        end
                    end
                    for i, v in pairs(G.discard.cards) do
                        if v.ability.link == link then
                            cards[#cards+1] = v
                            v.ability.temporary2 = true
                        end
                    end
                    for i, v in pairs(G.deck.cards) do
                        if v.ability.link == link then
                            cards[#cards+1] = v
                            v.ability.temporary2 = true
                        end
                    end
                    SMODS.destroy_cards(cards, nil)
                else
                    SMODS.destroy_cards(card, nil)
                end
                card.ability.temporary2 = true
            end
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
                    G.consumeables:emplace(c)
                    c:set_edition("e_negative")
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
                G.consumeables:emplace(c)
                c:set_edition("e_negative")
            end
        end
    end,
}

local ornate = {
    dependencies = {
        items = {
          "set_entr_runes"
        }
    },
	object_type = "Seal",
    order = 3007,
    key="entr_ornate",
    atlas = "seals",
    pos = {x=6,y=0},
    badge_colour = HEX("b47bbb"),
    calculate = function(self, card, context)
        if context.card_being_destroyed and context.card == card and not card.delay_dissolve then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer =  G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set="Rune",
                            area = G.consumeables,
                            key_append = "entr_ornate"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
                card.delay_dissolve = true
                return {
                    message = localize("k_plus_rune"),
                    colour = G.C.PURPLE,
                }
            end
        end
        if context.remove_playing_cards and not card.delay_dissolve then
            local check
            for i, v in pairs(context.removed) do
                if v == card then check = true end
            end
            if check and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set="Rune",
                            area = G.consumeables,
                            key_append = "entr_ornate"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
                card.delay_dissolve = true
                return {
                    message = localize("k_plus_rune"),
                    colour = G.C.PURPLE,
                }
            end
        end
        if context.forcetrigger then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set="Rune",
                            area = G.consumeables,
                            key_append = "entr_ornate"
                        }
                        return true
                    end
                })
            end
        end
    end,
    draw = function(self, card, layer)
		G.shared_seals["entr_ornate"].role.draw_major = card
        G.shared_seals["entr_ornate"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["entr_ornate"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

local amber = {
    dependencies = {
        items = {
            "set_entr_runes",
            "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 3009,
    key="entr_amber",
    atlas = "seals",
    pos = {x=7,y=0},
    badge_colour = HEX("db915b"),
    calculate = function(self, card, context)
        if context.copying_card and context.original_card == card then
            if not Entropy.has_rune("rune_entr_rebirth") then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    blocking = false,
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                })
            end
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set="Pact",
                            area = G.consumeables,
                            key_append = "entr_amber"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
                card.delay_dissolve = true
                return {
                    message = localize("k_plus_pact"),
                    colour = G.C.RED,
                }
            end
        end
    end,
    draw = function(self, card, layer)
		G.shared_seals["entr_amber"].role.draw_major = card
        G.shared_seals["entr_amber"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["entr_amber"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
}

return {
    items = {
        crimson,
        sapphire,
        silver,
        pink,
        not (SMODS.Mods["Cryptid"] or {}).can_load and {} or verdant,
        not (SMODS.Mods["Cryptid"] or {}).can_load and {} or cerulean,
        ornate,
        amber
    }
}
