SMODS.Tag {
    key = "asc_max",
    config = {
        xmult = 2,
        xchips = 2
    },
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 1, y = 0},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                tag.config.xmult,
                tag.config.xchips
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.RED, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'after_hand' then
            mult = mod_mult(mult * tag.config.xmult)
            chips = mod_chips(hand_chips * tag.config.xchips)
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
            tag_area_status_text(tag, "X2", G.C.RED, false, 0)
            tag_area_status_text(tag, "X2", G.C.CHIPS, false, 0)
            G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                play_sound('multhit2')
                tag:juice_up()
                return true
            end}))
            return true
        end
    end,
}

SMODS.Tag {
    key = "asc_recursive",
    config = {
        xchips_mod = 0.1,
    },
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 3, y = 0},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                0.1, (1 + 0.1*#G.GAME.tags)
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.MONEY, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'after_hand' then
            hand_chips = mod_chips(hand_chips + (1 + 0.1*#G.GAME.tags))
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            tag_area_status_text(tag, "X" .. tostring(1 + 0.1*#G.GAME.tags), G.C.BLUE, false, 0)
            G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                play_sound('chips1')
                tag:juice_up()
                return true
            end}))
            return true
        end
    end,
}

SMODS.Tag {
    key = "asc_memory",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 4, y = 0},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate'  then
            tag:yep('+', G.C.bld_keepsake, function()
                return true
            end)
            local card = nil
                if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                    card = SMODS.create_card {
                        set = "Joker",
                        rarity = "bld_keepsake",
                        area = G.jokers,
                        key_append = "memorytag"
                    }
                    card:set_edition(SMODS.poll_edition{guaranteed = true, options = BLINDSIDE.get_blindside_editions(), key = "entr_asc_keepsake"})
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
            tag.triggered = true
            return card
        end
    end,
}

SMODS.Tag {
    key = "asc_wave",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 5, y = 0},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.BLUE, function() 
                    return true end)
                tag.triggered = true
        end
    end,
}

SMODS.Tag {
    key = "asc_additive",
    config = {
        chance = 2,
        trigger = 3,
    },
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 2, y = 1},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                1,
                4,
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.PURPLE, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'before' then
            local converts = {}
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.pseudorandom_probability(tag, pseudoseed("flip"), tag.ability.chance, tag.ability.trigger, 'flip') then 
                    converts[#converts+1] = v
                    local enhancement = pseudorandom_element(SMODS.ObjectTypes.bld_obj_enhancements.enhancements, 'booster')
                    v:set_seal(enhancement, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    }))
                end
            end
            if #converts > 0 then 
                tag_area_status_text(tag, 'Enhance!', G.C.FILTER, false, 0)
            end
        end
    end,
    set_ability = function(self, tag) 
        tag.ability.chance = tag.config.chance
        tag.ability.trigger = tag.config.trigger
    end
}


SMODS.Tag {
    key = "asc_debuff",
    config = {
        debuffed_hand = '['..localize('k_poker_hand')..']',
        debuff_text = localize('k_debuff_tag')
    },
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 3, y = 1},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                (tag.ability and tag.ability.debuffed_hand and localize(tag.ability.debuffed_hand, 'poker_hands')) or ('['..localize('k_poker_hand')..']')
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.DARK_EDITION, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'after_hand' then
            local text = G.FUNCS.get_poker_hand_info(G.play.cards)
            if text == tag.ability.debuffed_hand then
                hand_chips = mod_chips(hand_chips * 0.5)
                mult = mod_mult(mult * 0.5)
                update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
                tag_area_status_text(tag, "X" .. tostring(1 + 0.1*#G.GAME.tags), G.C.BLUE, false, 0)
            end
        end
    end,
    set_ability = function(self, tag) 
        tag.ability.debuffed_hand = G.bolt_played_hand
        tag.ability.debuff_text = (localize('k_debuff_tag') or "") .. (localize(tag.ability.debuffed_hand, 'poker_hands') or "")
    end
}

SMODS.Tag {
    key = "asc_symmetry",
    config = {
        chance = 1,
        trigger = 2,
    },
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 0, y = 2},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, tag)
        local n,d = SMODS.get_probability_vars(tag, 1, 2)
        return {
            vars = {
                n,
                d,
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.GREEN, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'scoring_card' then
            BLINDSIDE.rescore_card(context.card, context.context)
            local numerator, denominator = SMODS.get_probability_vars(tag, 1, 2, 'symmetry', true)
            if pseudorandom('symmetry') < numerator / denominator and context.card.facing ~= 'back' and context.context.cardarea == G.play then
                tag:juice_up()
                tag_area_status_text(tag, localize('k_again_ex'), G.C.FILTER, false, 0)
                BLINDSIDE.rescore_card(context.card, context.context)
            end
        end
    end,
    set_ability = function(self, tag) 
        tag.ability.chance = tag.config.chance
        tag.ability.trigger = tag.config.trigger
    end
}


SMODS.Tag {
    key = "asc_prison_break",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 4, y = 1},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if not G.GAME.imprisonment_buffer and context.type == 'real_round_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) and G.GAME.blind.boss then
            G.GAME.imprisonment_buffer = true
            G.E_MANAGER:add_event(Event({
                func = function ()
                    if G.GAME.blind and not G.GAME.blind.disabled then
                        G.GAME.blind:disable()
                        G.GAME.blindassist:disable()
                    end
                    G.GAME.imprisonment_buffer = false
                    tag:yep('+', G.C.RED, function()
                    return true end)
                    tag.triggered = true
                    return true
                end
            }))
        elseif not G.GAME.imprisonment_buffer and context.type == 'real_round_start' then
            G.GAME.imprisonment_buffer = true
            G.E_MANAGER:add_event(Event({
                func = function ()
                    if G.GAME.blind and not G.GAME.blind.disabled then
                        G.GAME.blind:disable()
                        G.GAME.blindassist:disable()
                    end
                    G.GAME.imprisonment_buffer = false
                    return true
                end
            }))
        end
    end,
}

SMODS.Tag {
    key = "asc_collector",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 0, y = 0},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'symbol_pack_opened'  then
            tag:yep('+', G.C.DARK_EDITION, function()
                return true
            end)
            G.E_MANAGER:add_event(Event({trigger = 'after', func = function()
                    if G.pack_cards and G.pack_cards.cards ~= nil and G.pack_cards.cards[1] and G.pack_cards.VT.y < G.ROOM.T.h then
                        for _, v in ipairs(G.pack_cards.cards) do
                            local edition = poll_edition('asc_collector', nil, true, true, {'e_bld_enameled', 'e_bld_finish', 'e_bld_mint'})
                            v:set_edition(edition, true)
                        end
                        upgrade_blinds(G.pack_cards.cards)
                    return true
                end
            end}))
            tag.triggered = true
        end
    end,
}

SMODS.Tag {
    key = "asc_magic",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 5, y = 1},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'immediate'  then
            tag:yep('+', G.C.ORANGE, function()
                return true
            end)
            local card = nil
                if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                    card = SMODS.create_card {
                        set = "Joker",
                        rarity = "bld_curio",
                        area = G.jokers,
                        key_append = "magictag"
                    }
                    card:set_edition(SMODS.poll_edition{guaranteed = true, options = BLINDSIDE.get_blindside_editions(), key = "entr_asc_trinket"})
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
            tag.triggered = true
            return card
        end
    end,
}


SMODS.Tag {
    key = "asc_joker",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 1, y = 3},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'after_hand' then
            BLINDSIDE.chipsmodify(0.5, 0, 0)
        end

        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.MONEY, function() 
                return true end)
            tag.triggered = true
        end
    end,
}

SMODS.Tag {
    key = "asc_awe",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 3, y = 3},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            for key, value in pairs(G.jokers.cards) do
                value:set_debuff(false)
            end
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'before' then
            for key, value in pairs(G.jokers.cards) do
                value:set_debuff(false)
            end
            local t = pseudorandom("entr_asc_awe") < 0.5 and 1 or #G.jokers.cards
            for i, trinket in ipairs(G.jokers.cards) do
                if i == ts then
                    trinket:set_debuff(true)
                end
            end
        end
    end,
}

SMODS.Tag {
    key = "asc_mantle",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 4, y = 3},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'after_hand' then
            local cards = choose_stuff(G.play.cards, 1, pseudoseed('mantle'))
            G.E_MANAGER:add_event(Event({
                func = function ()
                    destroy_blinds_and_calc(cards, tag)
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                            G.E_MANAGER:add_event(Event({
                                func = function ()
                                    cards[1]:remove()
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return true
                end
            }))
        end

        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.MONEY, function() 
                return true end)
            tag.triggered = true
        end
    end,
}

SMODS.Tag {
    key = "asc_downpour",
    hide_ability = false,
    atlas = 'blindside_tags',
    config = {
        extra = {
            odds = 4,
            odds_gain = 4
        }
    },
    blindside = true,
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue + 1] = {key = 'bld_modifiers', set = 'Other'}
        local n,d = SMODS.get_probability_vars(tag, 1, 4)
        return {
            vars = {
                n,
                d,
            }
        }
    end,
    pos = {x = 5, y = 3},
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'after_hand' then
            for key, value in pairs(G.play.cards) do
                if (value.edition or value.seal) and SMODS.pseudorandom_probability(tag, pseudoseed('bld_downpour'), 1, 4, 'bld_downpour') then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.4,
                        func = function()
                            value:set_edition(nil)
                            value:set_seal(nil)
                            play_sound('cardFan2')
                            value:juice_up()
                            return true
                        end
                    }))
                end
            end
        end
    end,
}

SMODS.Tag {
    key = "asc_burden",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 2, y = 3},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            tag:yep('+', G.C.RED, function() 
                return true end)
            tag.triggered = true
        end
        if context.type == 'after_hand' then
            if not G.GAME.dollar_buffer then
                G.GAME.dollar_buffer = 0
            end
            local amount = math.ceil(-math.max(0, G.GAME.dollars + G.GAME.dollar_buffer)/3)
            if amount < 0 then
                G.GAME.dollar_buffer = G.GAME.dollar_buffer + amount
                ease_dollars(amount)
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        G.GAME.dollar_buffer = 0
                        return true
                    end
                }))
            end
        end
    end,
}

SMODS.Tag {
    key = "asc_voodoo",
    hide_ability = false,
    atlas = 'blindside_tags',
    pos = {x = 0, y = 3},
    blindside = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function (self, info_queue, tag)
        info_queue[#info_queue+1] = G.P_CENTERS['p_bld_voodoo']
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
			local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.BLACK, function() 
				local key = 'p_bld_voodoo'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
    end,
}

Entropy.AscendedTags.tag_bld_maxim = "tag_entr_asc_max"
Entropy.AscendedTags.tag_bld_recursive = "tag_entr_asc_recursive"
Entropy.AscendedTags.tag_bld_battery = "tag_entr_ascendant_effarcire"
Entropy.AscendedTags.tag_bld_reroll = "tag_entr_ascendant_credit"
Entropy.AscendedTags.tag_bld_additive = "tag_entr_asc_additive"
Entropy.AscendedTags.tag_bld_mining = "tag_entr_ascendant_universal"
Entropy.AscendedTags.tag_bld_strike = "tag_entr_ascendant_stock"
Entropy.AscendedTags.tag_bld_dental = "tag_entr_ascendant_stock"
Entropy.AscendedTags.tag_bld_symmetry = "tag_entr_asc_symmetry"
Entropy.AscendedTags.tag_bld_toss = "tag_entr_ascendant_effarcire"
Entropy.AscendedTags.tag_bld_wave = "tag_entr_asc_wave"
Entropy.AscendedTags.tag_bld_imprisonment = "tag_entr_asc_prison_break"
Entropy.AscendedTags.tag_bld_heartbreak = "tag_entr_asc_prison_break"
Entropy.AscendedTags.tag_bld_collector = "tag_entr_asc_collector"
Entropy.AscendedTags.tag_bld_neon = "tag_entr_ascendant_stock"
Entropy.AscendedTags.tag_bld_memory = "tag_entr_asc_memory"
Entropy.AscendedTags.tag_bld_magic = "tag_entr_asc_magic"   
Entropy.AscendedTags.tag_bld_debuff = "tag_entr_asc_debuff"
Entropy.AscendedTags.tag_bld_joker = "tag_entr_asc_joker"
Entropy.AscendedTags.tag_bld_awe = "tag_entr_asc_awe"
Entropy.AscendedTags.tag_bld_mantle = "tag_entr_asc_mantle"
Entropy.AscendedTags.tag_bld_downpour = "tag_entr_asc_downpour"
Entropy.AscendedTags.tag_bld_voodoo = "tag_entr_asc_voodoo"
Entropy.AscendedTags.tag_bld_burden = "tag_entr_asc_burden"