local stillicidium = {
    order = 300,
    object_type = "Joker",
    key = "stillicidium",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    
    dependencies = {
        items = {
            "set_cry_exotic"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    --pos = { x = 0, y = 0 },
    --atlas = "jokers",
    loc_vars = function(self, info_queue, card)

    end,
    calculate = function (self, card, context)
        if context.ending_shop or context.forcetrigger then
                local afterS = false
                for i, v in pairs(G.jokers.cards) do
                    if (v.config.center_key ~= "j_entr_stillicidium" or context.forcetrigger) and i > GetAreaIndex(G.jokers.cards, card) 
                    and not v.ability.cry_absolute then --you cannot run, you cannot hide
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                            --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                            --c:add_to_deck()    
                            --G.jokers:emplace(c)
                            --v:start_dissolve()#
                            local v2 = G.jokers.cards[i]
                            if G.P_CENTER_POOLS["Joker"][ReductionIndex(v2, "Joker")-1] then
                                key = G.P_CENTER_POOLS["Joker"][ReductionIndex(v2, "Joker")-1].key
                                --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                                --c:add_to_deck()    
                                v2:start_dissolve()
                                G.jokers:remove_from_highlighted(v2, true)
                                local edition = v.edition
                                local sticker = v.sticker
                                v2 = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                                v2:set_card_area(G.jokers)
                                v2:set_edition(edition)
                                v2:add_to_deck()
                                v2.sticker = sticker
                                G.jokers.cards[i] = v2
                            end
                            return true
                        end
                        }))
                    end
                end

                for i, v in pairs(G.consumeables.cards) do
                    if v.config.center_key ~= "j_entr_stillicidium" then
                        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() 
                            --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                            --c:add_to_deck()    
                            --G.jokers:emplace(c)
                            --v:start_dissolve()
                            local v2 = G.consumeables.cards[i]
                            v2.highlighted = false
                            if G.P_CENTER_POOLS[v2.config.center.set] and G.P_CENTER_POOLS[v2.config.center.set][ReductionIndex(v2, v2.config.center.set)-1] then
                                key = G.P_CENTER_POOLS[v2.config.center.set][ReductionIndex(v2, v2.config.center.set)-1].key
                                --local c = create_card("Joker", G.jokers, nil, nil, nil, nil, key) 
                                --c:add_to_deck()    
                                v2:start_dissolve()
                                v2 = create_card(v.config.center.set, G.jokers, nil, nil, nil, nil, key) 
                                v2:add_to_deck()
                                v2:set_card_area(G.consumeables)
                                G.consumeables.cards[i] = v2
                            end
                            return true
                        end
                        }))
                    end
                end
        end
        if context.individual and 
            context.cardarea == G.play and context.other_card 
            then
                local card = context.other_card 
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    card:juice_up(0.3, 0.3)
                    SMODS.change_base(card, card.base.suit, LowerCardRank(card))
                return true end }))
        end
        if (context.setting_blind and not context.blueprint and not card.getting_sliced) or context.forcetrigger then
			card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips * 0.6
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
		end
    end
}

function ReductionIndex(card, pool)
    index = 0
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if card.config and v.key == card.config.center_key then
            return i
        end
        i = i + 1
    end
end
function LowerCardRank(card)
	if not card.base then return nil end
	local rank_suffix = math.min(card.base.id, 14)
	if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
	elseif rank_suffix == 10 then rank_suffix = '10'
	elseif rank_suffix == 11 then rank_suffix = 'Jack'
	elseif rank_suffix == 12 then rank_suffix = 'Queen'
	elseif rank_suffix == 13 then rank_suffix = 'King'
	elseif rank_suffix == 14 then rank_suffix = 'Ace'
	end
	return ({
		ruby_13 = "Ace",
		Ace = "King",
		King = "Queen",
		Queen = "Jack",
		Jack = "10",
		["10"] = "9",
		["9"] = "8",
		["8"] = "7",
		["7"] = "6",
		["6"] = "5",
		["5"] = "4",
		["4"] = "3",
		["3"] = "2",
		["2"] = "Ace",
	})[tostring(rank_suffix)]
end
function GetAreaIndex(cards, card)
    for i, v in pairs(cards) do
        if v.config.center_key == card.config.center_key and v.unique_val == card.unique_val then return i end
    end
    return -1
end

local libra = {
    order = 300 + 1,
    object_type = "Joker",
    key = "libra",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",

    pos = { x = 6, y = 0 },
    soul_pos = { x = 8, y = 0, extra = { x = 7, y = 0 } },
    
    dependencies = {
        items = {
            "set_cry_exotic"
        }
    },

    config = {
        echips = 1
    },

    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {
            vars = {
                card.ability.echips
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and (context.other_card:is_face() or context.other_card.config.center.key == "m_wild") then
            local total = card.ability.echips
            local values = 1
            for i, v in pairs(context.other_card.ability) do
                if type(v) == "number" and v ~= 1 and v~= 0 then
                    total = total + v
                    values = values + 1
                end
                if type(v) == "table" and v.arrow and v ~= to_big(1) and v ~= to_big(0) then
                    total = total + v
                    values = values + 1
                end
            end
            if type(context.other_card.ability.extra) == "table" and not context.other_card.ability.extra.arrow then
                for i, v in pairs(context.other_card.ability.extra or {}) do
                    if type(v) == "number" and v ~= 1 and v~= 0 then
                        total = total + v
                        values = values + 1
                    end
                    if type(v) == "table" and v.arrow and v ~= to_big(1) and v ~= to_big(0) then
                        total = total + v
                        values = values + 1
                    end
                end
            end
            total = total + context.other_card.base.nominal
            values = values + 1
            for i, v in pairs(context.other_card.ability) do
                if type(v) == "number" and v ~= 1 and v~= 0 then
                    context.other_card.ability[i] = total / values
                end
                if type(v) == "table" and v.arrow and v ~= to_big(1) and v ~= to_big(0) then
                    context.other_card.ability[i] = to_big(total / values)
                end
            end
            if type(context.other_card.ability.extra) == "table" and not context.other_card.ability.extra.arrow then
                for i, v in pairs(context.other_card.ability.extra or {}) do
                    if type(v) == "number" and v ~= 1 and v~= 0 then
                        context.other_card.ability.extra[i] = total / values
                    end
                    if type(v) == "table" and v.arrow and v ~= to_big(1) and v ~= to_big(0) then
                        context.other_card.ability.extra[i] = to_big(total / values)
                    end
                end
            end
            context.other_card.base.nominal = total / values
            card.ability.echips = total / values
        end
        if context.joker_main or context.forcetrigger then
            return {
                echips = card.ability.echips
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local scorpio = {
    order = 300 + 2,
    object_type = "Joker",
    key = "scorpio",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",

    pos = { x = 6, y = 1 },
    soul_pos = { x = 8, y = 1, extra = { x = 7, y = 1 } },
    
    dependencies = {
        items = {
            "set_cry_exotic"
        }
    },
    config = {
        all8s = 16,
        immutable = {
            temp_fac = 1
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.all8s
            }
        }
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card and context.other_card:get_id() == 8 then
            if card.ability.immutable_temp_fac < 1e69 then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * 1.16
                card.ability.immutable_temp_fac = (card.ability.immutable_temp_fac or 1) * 1.16
            end
            --just lie whatever idc
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("k_upgrade_ex"), colour = G.C.BLUE }
            )
        end
        if context.joker_main or context.forcetrigger then
            local d8s = {}
            for i = 1, 8 do
                d8s[#d8s+1] = math.floor(pseudorandom("scorpio")*7+1.5)
            end
            local all8s = true
            local sum = 0
            for i, v in ipairs(d8s) do
                if v ~= 8 then all8s = false end
                sum = sum + v/8
            end
            if all8s then
                sum = card.ability.all8s
            end
            return {
                Echip_mod = sum,
                message = "Sum = ^"..sum.." Chips"
            }
        end
        if context.after then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal / (card.ability.immutable_temp_fac or 1)
            card.ability.immutable_temp_fac = 1
        end
    end,
	entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

local ridiculus_absens = {
    order = 300 + 3,
    object_type = "Joker",
    key = "ridiculus_absens",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",
    name = "entr-ridiculus_absens",
    pos = { x = 6, y = 2 },
    soul_pos = { x = 8, y = 2, extra = { x = 7, y = 2 } },
    
    dependencies = {
        items = {
            "set_cry_exotic"
        }
    },
    config = {
        extra = {
            odds = 2
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_cry_glitched
        return {
            vars = {
                cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged),
                card.ability.extra.odds,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local cards = {}
            for i, v in ipairs(G.play.cards) do
                if pseudorandom("tmtrainer")
                < cry_prob(card.ability.cry_prob, card.ability.extra.odds, card.ability.cry_rigged)
                    / card.ability.extra.odds then
                    if not v.edition or v.edition and v.edition.key ~= "e_cry_glitched" then
                        cards[#cards+1]=v
                    end
                end
            end
            card.ability.extra.odds = pseudorandom("tmtrainer_odds") * 2 + 1
            Entropy.FlipThen(cards, function(card)
                card:set_edition("e_cry_glitched")
                Entropy.TMTTrainize(card)
            end)
        end
    end,
	entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    },
}

return {
    items = {
        stillicidium,
        libra,
        scorpio,
        ridiculus_absens
    }
}
