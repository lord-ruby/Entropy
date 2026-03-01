BLINDSIDE.Blind({
    key = 'scarlet_sun',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            asc_power = 0.75,
            asc_powerup = 0.75
        }
    },
    hues = {"Red"},
    hidden = true,
    legendary = true,
    calculate = function(self, card, context)
        if (context.cardarea == G.hand) and context.main_scoring then
            return {
                plus_asc = card.ability.extra.asc_power * #G.play.cards
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.asc_power
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.asc_power = card.ability.extra.asc_power + card.ability.extra.asc_powerup
            card.ability.extra.upgraded = true
        end
    end
})

BLINDSIDE.Blind({
    key = 'burgundy_baracuda',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            mult = 1.5,
            retriggers = 0,
            retriggers_mod = 1,
            multup = 0.5
        }
    },
    hues = {"Red"},
    hidden = true,
    legendary = true,
    calculate = function(self, card, context)
        if (context.cardarea == G.play) and context.main_scoring then
            return {
                xmult = card.ability.extra.mult
            }
        end
        if context.cardarea == G.play and context.other_card == card and context.repetition then
            local repetitions = card.ability.extra.retriggers
            G.E_MANAGER:add_event(Event{
                trigger = "after", func = function()
                    card.ability.extra.retriggers = 0
                    SMODS.calculate_effect{card = card, message = localize("k_reset_ex")}
                    return true
                end
            })
            if card.ability.extra.retriggers > 0 then
                return {
                    repetitions = repetitions
                }
            end
        end
        if context.after and not card.ability.triggered and card.area == G.hand then
            for i, v in pairs(G.play.cards) do
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "retriggers",
                    scalar_value = "retriggers_mod"
                })
            end
            G.E_MANAGER:add_event(Event{
                trigger = "after", func = function()
                    card.ability.triggered = nil
                    return true
                end
            })
            card.ability.triggered = true
        end
        if context.burn_card and context.cardarea == G.play and card.area == G.hand then
            return { remove = true }
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.retriggers,
                card.ability.extra.retriggers_mod
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multup
            card.ability.extra.upgraded = true
        end
    end
})

BLINDSIDE.Blind({
    key = 'diamond_dawn',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            value = 999,
            rescore = 1,
            retrigger = 2,
            rescore_up = 2,
        }
    },
    hues = {"Blue"},
    hidden = true,
    legendary = true,
    calculate = function(self, card, context)
       if context.cardarea == G.play and context.main_scoring and context.scoring_hand then
            return {
                func = function()
                    local self_pos = nil
                    local retrigger_cards = {}
                    for i=1, #context.scoring_hand do
                        if context.scoring_hand[i] == card then
                            self_pos = i
                        end
                    end
                    if context.scoring_hand[self_pos-1] then
                        table.insert(retrigger_cards, context.scoring_hand[self_pos-1])
                    end
                    if context.scoring_hand[self_pos+1] then
                        table.insert(retrigger_cards, context.scoring_hand[self_pos+1])
                    end
                    for streak_index = 1, #retrigger_cards do
                        local streak_card = retrigger_cards[streak_index]
                        for _, play_card in ipairs(G.play.cards) do
                            if play_card == streak_card and streak_card.ability.extra.rescore ~= 1 then
                                card:juice_up()
                                local passed_context = context
                                card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.DARK_EDITION})
                                BLINDSIDE.rescore_card(play_card, passed_context)
                                card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.DARK_EDITION})
                                BLINDSIDE.rescore_card(play_card, passed_context)
                                if card.ability.extra.upgraded then
                                    card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.DARK_EDITION})
                                    BLINDSIDE.rescore_card(play_card, passed_context)
                                    card_eval_status_text(play_card, 'extra', nil, nil, nil, {message = localize('k_again_ex'),colour = G.C.DARK_EDITION})
                                    BLINDSIDE.rescore_card(play_card, passed_context)
                                end
                            end
                        end
                    end
                    SMODS.calculate_context({rescore_cards = retrigger_cards})
                    return true
                end,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retrigger
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            card.ability.extra.retrigger = card.ability.extra.retrigger + card.ability.extra.rescore_up
        end
    end
})

local card_is_colour_ref = Card.is_color
function Card:is_color(colour, debuff, flush_calc)
    if self.config.center.key == "m_entr_diamond_dawn" then
        local self_pos = nil
        local retrigger_cards = {}
        for i=1, #self.area.cards do
            if self.area.cards[i] == self then
                self_pos = i
            end
        end
        if self.area.cards[self_pos-1] then
            for i, v in pairs(self.area.cards[self_pos-1].ability.extra.hues) do
                if v == colour then return true end
            end
        end
        if self.area.cards[self_pos+1] then
            for i, v in pairs(self.area.cards[self_pos+1].ability.extra.hues) do
                if v == colour then return true end
            end
        end
    end
    return card_is_colour_ref(self, colour, debuff, flush_calc)
end

BLINDSIDE.Blind({
    key = 'olive_orchard',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            xmult = 0.1,
            xmultup = 0.1
        }
    },
    hues = {"Green"},
    hidden = true,
    legendary = true,
    calculate = function(self, card, context)
        if context.pre_discard and context.cardarea == G.hand and card.highlighted and not card.triggered then
            for i, v in pairs(G.hand.cards) do
                if v ~= card then
                    SMODS.scale_card(v, {
                        ref_table = v.ability,
                        ref_value = "perma_x_mult",
                        scalar_table = card.ability.extra,
                        scalar_value = "xmult"
                    })
                end
            end
            card.triggered = true
            G.E_MANAGER:add_event(Event{
                func = function()
                    card.triggered = nil
                    return true
                end
            })
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_up
            card.ability.extra.upgraded = true
        end
    end
})


BLINDSIDE.Blind({
    key = 'citrine_comet',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    config = {
        extra = {
            asc = 0,
            asc_mod = 0.5,
            ascup = 0.25
        }
    },
    hues = {"Yellow"},
    hidden = true,
    legendary = true,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                plus_asc = card.ability.extra.asc
            }
        end
        if context.cards_burned then
            for i, v in pairs(context.cards_burned) do
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "asc",
                    scalar_value = "asc_mod"
                })
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.asc,
                card.ability.extra.asc_mod
            }
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.asc_mod = card.ability.extra.asc_mod + card.ability.extra.ascup
            card.ability.extra.upgraded = true
        end
    end
})


BLINDSIDE.Blind({
    key = 'alabaster_anchor',
    atlas = 'blindside_blinds',
    pos = {x = 0, y = 0},
    hues = {"Faded"},
    hidden = true,
    legendary = true,
    calculate = function(self, scard, context)
        if context.before and context.cardarea == G.play then
            local card = G.play.cards[#G.play.cards]
            if card then
                card.ability.extra.upgraded = nil
                upgrade_blinds({card})
                if scard.ability.extra.upgraded then
                    card.ability.extra.upgraded = nil
                    upgrade_blinds({card})
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            key = card.ability.extra.upgraded and "m_entr_alabaster_anchor_two" or nil
        }
    end,
    upgrade = function(card) 
        if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
        end
    end
})
