SMODS.Atlas { key = 'seals', path = 'seals.png', px = 71, py = 95 }
local crimson = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 1,
    key="entr_crimson",
    atlas = "seals",
    pos = {x=0,y=0},
    badge_colour = HEX("8a0050"),
    calculate = function(self, card, context)
    end,
}

-- function SMODS.calculate_main_scoring(context, scoring_hand)
--     for _, card in ipairs(context.cardarea.cards) do
--         if (card.seal == "entr_crimson" and not G.GAME.crimson_seal) or (card.seal ~= "entr_crimson" and G.GAME.crimson_seal) then return end
--             local in_scoring = scoring_hand and SMODS.in_scoring(card, context.scoring_hand)
--             --add cards played to list
--             if scoring_hand and not SMODS.has_no_rank(card) and in_scoring then
--                 G.GAME.cards_played[card.base.value].total = G.GAME.cards_played[card.base.value].total + 1
--                 if not SMODS.has_no_suit(card) then
--                     G.GAME.cards_played[card.base.value].suits[card.base.suit] = true
--                 end
--             end
--             --if card is debuffed
--             if scoring_hand and card.debuff then
--                 if in_scoring then 
--                     G.GAME.blind.triggered = true
--                     G.E_MANAGER:add_event(Event({
--                         trigger = 'immediate',
--                         func = (function() SMODS.juice_up_blind();return true end)
--                     }))
--                     card_eval_status_text(card, 'debuff')
--                 end
--             else
--                 if scoring_hand then
--                     if in_scoring then context.cardarea = G.play else context.cardarea = 'unscored' end
--                 end
--                 if card.seal == "entr_crimson" then
--                     local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
--                     G.FUNCS.get_poker_hand_info(G.play.cards)
--                     print(SMODS.in_scoring(card, scoring_hand))
--                     if SMODS.in_scoring(card, scoring_hand) then
--                         local delay = 0.6
--                         SMODS.score_card(card, context)
--                         Entropy.Again(card)
--                         SMODS.score_card(card, context)
--                         Entropy.Again(card)
--                         SMODS.score_card(card, context)
--                     end
--                 else
--                     SMODS.score_card(card, context)
--                 end
--             end
--     end
-- end
-- function SMODS.score_card(card, context)
--     local reps = { 1 }
--     local j = 1
--     while j <= #reps do
--         if reps[j] ~= 1 then
--             local _, eff = next(reps[j])
--             SMODS.calculate_effect(eff, eff.card)
--             percent = percent + (percent_delta or 0.08)
--         end

--         context.main_scoring = true
--         local effects = { eval_card(card, context) }
--         SMODS.calculate_quantum_enhancements(card, effects, context)
--         context.main_scoring = nil
--         context.individual = true
--         context.other_card = card

--         if next(effects) then
--             SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
--             SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })
--         end

--         local flags = SMODS.trigger_effects(effects, card)

--         context.individual = nil
--         if reps[j] == 1 and flags.calculated then
--             context.repetition = true
--             context.card_effects = effects
--             SMODS.calculate_repetitions(card, context, reps)
--             context.repetition = nil
--             context.card_effects = nil
--         end
--         j = j + (flags.calculated and 1 or #reps)
--         context.other_card = nil
--         card.lucky_trigger = nil
--     end
-- end

-- function evaluate_play_final_scoring(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
--     local txt,_,_, scoring_hand2, _ = G.FUNCS.get_poker_hand_info(G.play.cards)
--     G.GAME.crimson_seal = true
--     SMODS.calculate_main_scoring({cardarea = G.play, full_hand = G.play.cards, scoring_hand = scoring_hand2, scoring_name = text, poker_hands = poker_hands}, v == G.play and scoring_hand or nil)
--     G.GAME.crimson_seal = nil
--     for i, v in pairs(G.hand.cards) do
--         if v.seal == "entr_crimson" then
--             SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
--             if Entropy.TriggersInHand(v) then Entropy.Again(v) end
--             SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
--             if Entropy.TriggersInHand(v) and #res.playing_card > 0 then Entropy.Again(v) end
--             SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
--         end
        
--     end
--     G.E_MANAGER:add_event(Event({
--     	trigger = 'after',delay = 0.4,
--         func = (function()  update_hand_text({delay = 0, immediate = true}, {mult = 0, chips = 0, chip_total = G.GAME.blind.cry_cap_score and G.GAME.blind:cry_cap_score(math.floor(hand_chips*mult)) or math.floor(hand_chips*mult), level = '', handname = ''});play_sound('button', 0.9, 0.6);return true end)
--       }))
--           G.E_MANAGER:add_event(Event({
--             trigger = 'immediate',
--             func = (function() G.GAME.current_round.current_hand.cry_asc_num = 0;G.GAME.current_round.current_hand.cry_asc_num_text = '';return true end)
--           }))
--       check_and_set_high_score('hand', hand_chips*mult)

--       check_for_unlock({type = 'chip_score', chips = math.floor(hand_chips*mult)})
   
--     if to_big(hand_chips)*mult > to_big(0) then
--         delay(0.8)
--         G.E_MANAGER:add_event(Event({
--         trigger = 'immediate',
--         func = (function() play_sound('chips2');return true end)
--         }))
--     end
--     G.E_MANAGER:add_event(Event({
--       trigger = 'ease',
--       blocking = false,
--       ref_table = G.GAME,
--       ref_value = 'chips',
--       ease_to = G.GAME.chips + (G.GAME.blind.cry_cap_score and G.GAME.blind:cry_cap_score(math.floor(hand_chips*mult)) or math.floor(hand_chips*mult)),
--       delay =  0.5,
--       func = (function(t) return math.floor(t) end)
--     }))
--     G.E_MANAGER:add_event(Event({
--       trigger = 'ease',
--       blocking = true,
--       ref_table = G.GAME.current_round.current_hand,
--       ref_value = 'chip_total',
--       ease_to = 0,
--       delay =  0.5,
--       func = (function(t) return math.floor(t) end)
--     }))
--     G.E_MANAGER:add_event(Event({
--       trigger = 'immediate',
--       	func = (function()
--              G.GAME.current_round.current_hand.handname = '';
--              G.GAME.asc_power_hand = nil
--         return true end)
--       }))
--       delay(0.3)
--       return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
-- end
local ref = evaluate_play_final_scoring
function evaluate_play_final_scoring(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta = ref(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      	func = (function()
            G.GAME.asc_power_hand = nil
        return true end)
    }))
    return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end
local sapphire = {
    dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	object_type = "Seal",
    order = 2,
    key="entr_sapphire",
    atlas = "seals",
    pos = {x=1,y=0},
    badge_colour = HEX("8653ff"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "pluto"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.key end
            end
            local key = "c_entr_"..pkey
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
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
    order = 3,
    key="entr_silver",
    atlas = "seals",
    pos = {x=2,y=0},
    badge_colour = HEX("84a5b7"),
    calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.main_scoring then
            ease_dollars(4)
        end
        if context.forcetrigger then
            ease_dollars(4)
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
    order = 4,
    key="entr_pink",
    atlas = "seals",
    pos = {x=3,y=0},
    badge_colour = HEX("cc48be"),
    calculate = function(self, card, context)
        if context.pre_discard and context.cardarea == G.hand and card.highlighted then
            card.ability.temporary2 = true
            card:remove_from_deck()
            card:start_dissolve()
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
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
    order = 5,
    key="entr_verdant",
    atlas = "seals",
    pos = {x=4,y=0},
    badge_colour = HEX("75bb62"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            if #scoring_hand == 1 then
                local key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant"))
                while G.P_CENTERS[key].set ~= "RCode" do key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant")) end
                if #G.consumeables.cards < G.consumeables.config.card_limit then
                    local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                    c:add_to_deck()
                    G.consumeables:emplace(c)
                end
            end
        end
        if context.forcetrigger then
            local key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant"))
            while G.P_CENTERS[key].set ~= "RCode" do key = pseudorandom_element(Entropy.FlipsideInversions, pseudoseed("verdant")) end
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
    order = 6,
    key="entr_cerulean",
    atlas = "seals",
    pos = {x=5,y=0},
    badge_colour = HEX("4078e6"),
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            local pkey = "pluto"
            for i, v in pairs(Entropy.ReversePlanets) do
                if v.name == text then pkey = v.key end
            end
            local key = "c_entr_"..pkey
            for i = 1, 3 do
                    local c = create_card("Consumables", G.consumeables, nil, nil, nil, nil, key) 
                    c:set_edition({
                        negative=true,
                        key="e_negative",
                        card_limit=1,
                        type="negative"
                    })
                    card:add_to_deck()
                    G.consumeables:emplace(c)
                end

        end
        if context.destroy_card and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in pairs(scoring_hand) do v.ability.temporary2 = true end
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
                c:set_edition({
                    negative=true,
                    key="e_negative",
                    card_limit=1,
                    type="negative"
                })
                card:add_to_deck()
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