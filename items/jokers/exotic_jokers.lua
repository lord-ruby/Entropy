SMODS.Joker({
    key = "stillicidium",
    rarity = "cry_exotic",
    cost = 50,
    atlas = "exotic_jokers",
    soul_pos = { x = 2, y = 0, extra = { x = 1, y = 0 } },
    unlocked = true,

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
})

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
