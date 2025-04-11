SMODS.ConsumableType({
	object_type = "ConsumableType",
	key = "RSpectral",
	primary_colour = HEX("ff00c4"),
	secondary_colour = HEX("ff00c4"),
	collection_rows = { 4, 5 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_entr_memory_leak"
})

SMODS.Atlas { key = 'seals', path = 'seals.png', px = 71, py = 95 }
SMODS.Seal({
    key="entr_crimson",
    atlas = "seals",
    pos = {x=0,y=0},
    badge_colour = HEX("8a0050"),
    calculate = function(self, card, context)
    end,
})

function SMODS.calculate_main_scoring(context, scoring_hand)
    for _, card in ipairs(context.cardarea.cards) do
        if (card.seal == "entr_crimson" and not context.crimson_seal) or (card.seal ~= "entr_crimson" and context.crimson_seal) then return end
            local in_scoring = scoring_hand and SMODS.in_scoring(card, context.scoring_hand)
            --add cards played to list
            if scoring_hand and not SMODS.has_no_rank(card) and in_scoring then
                G.GAME.cards_played[card.base.value].total = G.GAME.cards_played[card.base.value].total + 1
                if not SMODS.has_no_suit(card) then
                    G.GAME.cards_played[card.base.value].suits[card.base.suit] = true
                end
            end
            --if card is debuffed
            if scoring_hand and card.debuff then
                if in_scoring then 
                    G.GAME.blind.triggered = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = (function() SMODS.juice_up_blind();return true end)
                    }))
                    card_eval_status_text(card, 'debuff')
                end
            else
                if scoring_hand then
                    if in_scoring then context.cardarea = G.play else context.cardarea = 'unscored' end
                end
                if card.seal == "entr_crimson" then
                    local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
                    G.FUNCS.get_poker_hand_info(G.play.cards)
                        if SMODS.in_scoring(card, scoring_hand) then
                        local delay = 0.6
                        SMODS.score_card(card, context)
                        Entropy.Again(card)
                        SMODS.score_card(card, context)
                        Entropy.Again(card)
                        SMODS.score_card(card, context)
                    end
                else
                    SMODS.score_card(card, context)
                end
            end
    end
end
function SMODS.score_card(card, context)
    local reps = { 1 }
    local j = 1
    while j <= #reps do
        if reps[j] ~= 1 then
            local _, eff = next(reps[j])
            SMODS.calculate_effect(eff, eff.card)
            percent = percent + (percent_delta or 0.08)
        end

        context.main_scoring = true
        local effects = { eval_card(card, context) }
        SMODS.calculate_quantum_enhancements(card, effects, context)
        context.main_scoring = nil
        context.individual = true
        context.other_card = card

        if next(effects) then
            SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
            SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })
        end

        local flags = SMODS.trigger_effects(effects, card)

        context.individual = nil
        if reps[j] == 1 and flags.calculated then
            context.repetition = true
            context.card_effects = effects
            SMODS.calculate_repetitions(card, context, reps)
            context.repetition = nil
            context.card_effects = nil
        end
        j = j + (flags.calculated and 1 or #reps)
        context.other_card = nil
        card.lucky_trigger = nil
    end
end

function evaluate_play_final_scoring(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    local _,_,_, scoring_hand2, _ = G.FUNCS.get_poker_hand_info(G.play.cards)
    SMODS.calculate_main_scoring({cardarea = G.play, full_hand = G.play.cards, scoring_hand = scoring_hand2, scoring_name = text, poker_hands = poker_hands,crimson_seal=true}, v == G.play and scoring_hand or nil)
    for i, v in pairs(G.hand.cards) do
        if v.seal == "entr_crimson" then
            SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
            if Entropy.TriggersInHand(v) then Entropy.Again(v) end
            SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
            if Entropy.TriggersInHand(v) and #res.playing_card > 0 then Entropy.Again(v) end
            SMODS.score_card(v, {cardarea=G.hand,main_scoring=true})
        end
        
    end
    G.E_MANAGER:add_event(Event({
    	trigger = 'after',delay = 0.4,
        func = (function()  update_hand_text({delay = 0, immediate = true}, {mult = 0, chips = 0, chip_total = G.GAME.blind.cry_cap_score and G.GAME.blind:cry_cap_score(math.floor(hand_chips*mult)) or math.floor(hand_chips*mult), level = '', handname = ''});play_sound('button', 0.9, 0.6);return true end)
      }))
          G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = (function() G.GAME.current_round.current_hand.cry_asc_num = 0;G.GAME.current_round.current_hand.cry_asc_num_text = '';return true end)
          }))
      check_and_set_high_score('hand', hand_chips*mult)

      check_for_unlock({type = 'chip_score', chips = math.floor(hand_chips*mult)})
   
    if to_big(hand_chips)*mult > to_big(0) then
        delay(0.8)
        G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() play_sound('chips2');return true end)
        }))
    end
    G.E_MANAGER:add_event(Event({
      trigger = 'ease',
      blocking = false,
      ref_table = G.GAME,
      ref_value = 'chips',
      ease_to = G.GAME.chips + (G.GAME.blind.cry_cap_score and G.GAME.blind:cry_cap_score(math.floor(hand_chips*mult)) or math.floor(hand_chips*mult)),
      delay =  0.5,
      func = (function(t) return math.floor(t) end)
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'ease',
      blocking = true,
      ref_table = G.GAME.current_round.current_hand,
      ref_value = 'chip_total',
      ease_to = 0,
      delay =  0.5,
      func = (function(t) return math.floor(t) end)
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      	func = (function() G.GAME.current_round.current_hand.handname = '';return true end)
      }))
      delay(0.3)
      return text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta
end

SMODS.Seal({
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
    end,
})

SMODS.Seal({
    key="entr_silver",
    atlas = "seals",
    pos = {x=2,y=0},
    badge_colour = HEX("84a5b7"),
    calculate = function(self, card, context)
		if context.cardarea == "unscored" and context.main_scoring then
            ease_dollars(4)
        end
    end,
    draw = function(self, card, layer)
		G.shared_seals["entr_silver"].role.draw_major = card
        G.shared_seals["entr_silver"]:draw_shader('dissolve', nil, nil, nil, card.children.center)
		G.shared_seals["entr_silver"]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end,
})

SMODS.Seal({
    key="entr_pink",
    atlas = "seals",
    pos = {x=3,y=0},
    badge_colour = HEX("cc48be"),
    calculate = function(self, card, context)
        if context.pre_discard and context.cardarea == G.hand and card.highlighted then
            card:start_dissolve()
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                local c = create_card("Twisted", G.consumeables, nil, nil, true, true, nil, "twisted") 
                c:add_to_deck()
                G.consumeables:emplace(c)
            end
        end
    end,
})

SMODS.Seal({
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
    end,
})

SMODS.Consumable({
    key = "weld",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        select = 1,
        discard = 1
    },
	pos = {x=11,y=6},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card:flip()
                        return true
                    end
                }))
            end
        end
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card.cry_absolute = true
                        card:set_edition({
                            negative=true,
                            key="e_negative",
                            card_limit=1,
                            type="negative"
                        })
                        return true
                    end
                }))
            end
        end
        for i = 1, card.ability.select do
            local card = G.jokers.highlighted[i]
            if card then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.2,
                    func = function()
                        card:flip()
                        return true
                    end
                }))
            end
        end
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.discard
        ease_discard(-card.ability.discard)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted <= card.ability.select and #G.jokers.highlighted > 0
	end,
    loc_vars = function(self, q, card)
        q[#q+1] = {key = "cry_absolute", set="Other"}
        q[#q+1] = {key = "e_negative", set="Edition", config = {extra = 1}}
        return {
            vars = {
                card.ability.select,
                -card.ability.discard
            }
        }
    end,
})
SMODS.Rank {
    key = 'nilrank',
    card_key = 'nilrank',
    pos = {x = 99},
    nominal = 1,
    face_nominal = 1,
    shorthand = "nilrank",
    in_pool = function(self, args)
        return false
    end
}
SMODS.Suit {
    key = 'nilsuit',
    card_key = 'nilsuit',
    pos = { y = 99 },
    ui_pos = {x=99,y=99},
    in_pool = function(self, args)
        return false
    end
}
local is_suitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    --unified usually never shows up, support for life and other mods
    if self.base.suit == "entr_nilsuit" then
        return false
    else
       return is_suitref(self, suit, bypass_debuff, flush_calc)
    end
end
function Card:get_id()
    if (self.ability.effect == 'Stone Card' and not self.vampired) or self.base.value == "entr_nilrank" then
        return -math.random(100, 1000000)
    end
    return self.base.id
end
SMODS.Consumable({
    key = "cleanse",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        dollarpc = 1
    },
	pos = {x=7,y=7},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card2, area, copier)
        local total = 0
        for i, card in pairs(G.hand.cards) do
            if card.ability and card.ability.effect == 'Stone Card' then
                total = total + (10 + card.ability.perma_bonus) * card2.ability.dollarpc 
                card:set_ability(G.P_CENTERS.c_base, true, nil)
            else
                total = total + (card.base.nominal-1 + card.ability.perma_bonus) * card2.ability.dollarpc 
            end
            card.ability.perma_bonus = 0
        end
        Entropy.FlipThen(G.hand.cards, function(card, area)
            total = total + (card.base.nominal-1) * card2.ability.dollarpc
            SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
        end)
        delay(1)
        ease_dollars(total)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollarpc
            }
        }
    end,
})

SMODS.Seal({
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
                    c:add_to_deck()
                    c:set_edition({
                        negative=true,
                        key="e_negative",
                        card_limit=1,
                        type="negative"
                    })
                    G.consumeables:emplace(c)
                end

        end
        if context.destroy_card and context.cardarea == G.play then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in pairs(scoring_hand) do v:start_dissolve() end
        end
    end,
})

SMODS.Consumable({
    key = "fervour",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {

    },
	name = "entr-Fervour",
    soul_rate = 0, --probably only obtainable from flipsiding a gateway
    hidden = true, 
	pos = {x=4,y=0},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "entr_reverse_legendary", nil, nil, nil, "entr_beyond")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                colours = {
                    {3,3,3,3}
                }
            }
        }
    end,
    entr_credits = {
        custom = {key="card_art", text="gudusername_53951"}
    }
})

SMODS.Consumable({
    key = "quasar",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        level = 3
    },
    soul_rate = 0,
    hidden = true, 
	pos = {x=7,y=3},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        local max=0
        local ind="High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > max then
                max = v.played
                ind = i
            end
        end
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize(ind,'poker_hands'), chips = "...", mult = "...", level = "" }
        )
        G.GAME.hands[ind].AscensionPower = (G.GAME.hands[ind].AscensionPower or 0) + G.GAME.hands[ind].level * amt * card.ability.level
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
            Cryptid.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..G.GAME.hands[ind].level..card.ability.level*amt })
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,
    bulk_use = function(self,card,area,copier,amt)
        self.use(self,card,area,copier,amt)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        local max=0
        local ind="High Card"
        for i, v in pairs(G.GAME.hands) do
            if v.played > max then
                max = v.played
                ind = i
            end
        end
        return {
            vars = {
                G.GAME.hands[ind].level * card.ability.level
            }
        }
    end,
})


SMODS.Consumable({
    key = "pulsar",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {
        level = 4
    },
    soul_rate = 0,
    hidden = true, 
	pos = {x=6,y=3},
    --soul_pos = { x = 5, y = 0},
    use = function(self, card, area, copier,amt)
        local amt = amt or 1
        local used_consumable = copier or card
        delay(0.4)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
          { handname = localize('k_all_hands'), chips = "...", mult = "...", level = "" }
        )
        for i, v in pairs(G.GAME.hands) do
            v.AscensionPower = (v.AscensionPower or 0) + card.ability.level*amt
            v.visible = true
        end
        delay(1.0)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = function()
            play_sound("tarot1")
            ease_colour(G.C.UI_CHIPS, copy_table(G.C.GOLD), 0.1)
            ease_colour(G.C.UI_MULT, copy_table(G.C.GOLD), 0.1)
            Cryptid.pulse_flame(0.01, sunlevel)
            used_consumable:juice_up(0.8, 0.5)
            G.E_MANAGER:add_event(Event({
              trigger = "after",
              blockable = false,
              blocking = false,
              delay = 1.2,
              func = function()
                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                ease_colour(G.C.UI_MULT, G.C.RED, 1)
                return true
              end,
            }))
            return true
          end,
        }))
        update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = "+"..card.ability.level*amt })
        delay(2.6)
        update_hand_text(
          { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
          { mult = 0, chips = 0, handname = "", level = "" }
        )
    end,
    bulk_use = function(self,card,area,copier,amt)
        self.use(self,card,area,copier,amt)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.level
            }
        }
    end,
})

SMODS.Consumable({
    key = "define",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {

    },
    name = "entr-Define",
    hidden = true,
    pos = {x=4,y=4},
    --soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    use = function(self, card, area, copier)
        if not G.GAME.DefineKeys then
            G.GAME.DefineKeys = {}
        end

        G.GAME.USING_CODE = true
		G.GAME.USING_DEFINE = true
		G.ENTERED_CARD = ""
		G.CHOOSE_CARD = UIBox({
			definition = G.FUNCS.create_UIBox_define(card),
			config = {
				align = "cm",
				offset = { x = 0, y = 10 },
				major = G.ROOM_ATTACH,
				bond = "Weak",
				instance_type = "POPUP",
			},
		})
		G.CHOOSE_CARD.alignment.offset.y = 0
		G.ROOM.jiggle = G.ROOM.jiggle + 1
		G.CHOOSE_CARD:align_to_major()
    end,
    can_use = function(self, card)
        return GetSelectedCards() > 1 and GetSelectedCards() < 3 and GetSelectedCard() and GetSelectedCard().config.center.key ~= "j_entr_ruby"
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                "#",
                colours = {
                    HEX("ff00c4")
                }
            }
        }
    end,
})

SMODS.Consumable({
    key = "beyond",
    set = "RSpectral",
    unlocked = true,
    discovered = true,
    atlas = "miscc",
    config = {

    },
    name = "entr-Beyond",
    soul_rate = 0, --probably only obtainable from flipsiding a gateway
    hidden = true, 
    --soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    use = function(self, card, area, copier)
        if not G.GAME.banned_keys then
			G.GAME.banned_keys = {}
		end
        for i, v in pairs(G.jokers.cards) do
            G.GAME.banned_keys[v.config.center.key] = true
            G.E_MANAGER:add_event(Event({
				trigger = "before",
				delay = 0.75,
				func = function()
                    if v.config.center.rarity ~= "entr_hyper_exotic" or G.GAME.selected_back.effect.center.original_key ~= "doc" then
                        if v.config.center.rarity == "cry_exotic" then
                            check_for_unlock({ type = "what_have_you_done" })
                        end
                        v:start_dissolve(nil, _first_dissolve)
                    end
                    return true
				end,
			}))
        end
        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.4,
			func = function()
				play_sound("timpani")
				local card = create_card("Joker", G.jokers, nil, "entr_hyper_exotic", nil, nil, nil, "entr_beyond")
				card:add_to_deck()
				G.jokers:emplace(card)
				card:juice_up(0.3, 0.5)
				return true
			end,
		}))
		delay(0.6)
    end,
    can_use = function(self, card)
        return true
	end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                colours = {
                    {2,2,2,2}
                }
            }
        }
    end
})