function Entropy.GetHighlightedCards(cardareas, ignorecard, blacklist)
    local cards = {}
    blacklist = blacklist or {}
    for i, area in ipairs(cardareas) do
        if area.highlighted then
            for i2, card in ipairs(area.highlighted) do
                if card ~= ignorecard and not blacklist[card.config.center.key] then
                    cards[#cards + 1] = card
                end
            end
        end
    end
    return cards
end

function Entropy.FilterTable(table, func)
    local temp = {}
    for i, v in ipairs(table) do
        if func(v, i) then
            temp[#temp + 1] = v
        end
    end
    return temp
end

function Entropy.Inversion(card)
    return Entropy.FlipsideInversions[card.config.center.key]
end

function Entropy.FlipThen(cardlist, func, before, after)
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if before then
                                before(card)
                            end
                            if card.flip then
                                card:flip()
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.15,
                        func = function()
                            func(card, cardlist, i)
                            return true
                        end
                    }
                )
            )
        end
    end
    for i, v in ipairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(
                Event(
                    {
                        trigger = "after",
                        delay = 0.1,
                        func = function()
                            if card.flip then
                                card:flip()
                            end
                            if after then
                                after(card)
                            end
                            return true
                        end
                    }
                )
            )
        end
    end
end

function Entropy.SealSpectral(key, sprite_pos, seal,order, inversion)
    return {
        dependencies = {
            items = {
              "set_entr_inversions",
              seal
            }
        },
        object_type = "Consumable",
        order = order,
        key = key,
        set = "RSpectral",
        
        atlas = "consumables",
        config = {
            highlighted = 1
        },
        pos = sprite_pos,
        inversion = inversion,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.ModifyHandCard({seal=seal}),
        can_use = function(self, card)
            local cards = Entropy.GetHighlightedCards({G.hand}, nil, card)
            return #cards > 0 and #cards <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            q[#q+1] = {key = seal.."_seal", set="Other"}
            return {
                vars = {
                    card.ability.highlighted,
                    colours = {
                        SMODS.Seal.obj_table[seal].badge_colour or G.C.RED
                    }
                }
            }
        end,
    }
end

function Entropy.ModifyHandCard(modifications, cards)
    return function()
        Entropy.FlipThen(cards or G.hand.highlighted, function(mcard)
            if modifications.suit or modifications.rank then
                SMODS.change_base(mcard, modifications.suit, modifications.rank)
            end
            if modifications.enhancement then
                mcard:set_ability(G.P_CENTERS[modifications.enhancement])
            end
            if modifications.edition then
                if type(modifications.edition) == "table" then
                    mcard:set_edition(modifications.edition)
                else
                    mcard:set_edition(G.P_CENTERS[modifications.edition])
                end
            end
            if modifications.seal then
                mcard:set_seal(modifications.seal)
            end
            if modifications.sticker then
                Entropy.ApplySticker(mcard, modifications.sticker)
            end
            if modifications.extra then
                for i, v in pairs(modifications.extra) do mcard.ability[i] = v end
            end
        end)
    end
end

function Entropy.FindPreviousInPool(item, pool)
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if G.P_CENTER_POOLS[pool][i].key == item then
            return G.P_CENTER_POOLS[pool][i-1].key
        end
    end
    return nil
end

Entropy.charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~#$^~#$^~#$^~#$^~#$^"
function Entropy.StringRandom(length) 
    local total = ""
    for i = 0, length do
        local val = math.random(1,#Entropy.charset)
        total = total..(Entropy.charset:sub(val, val))
    end
    return total
end

function Entropy.FormatDollarValue(val)
    if to_big(val) >= to_big(0) then
        return localize("$")..val
    else
        return "-"..localize("$")..(-val)
    end
end
function Entropy.Pseudorandom(seed, min, max)
    return math.floor(pseudorandom(seed)*(max-min)+0.5)+min
end

function Entropy.HasJoker(key)
    for i, v in ipairs(G.jokers and G.jokers.cards or {}) do
        if v.config.center.key == key then return true end
    end
end

function Entropy.HasConsumable(key)
    for i, v in pairs(G.consumeables.cards) do if v.config.center.key == key then return true end end
    if G.pack_cards then for i, v in pairs(G.pack_cards.cards) do if v.config.center.key == key then return true end end end
    for i, v in pairs(G.hand.cards) do if v.config.center.key == key then return true end end
end

function Entropy.InTable(table, val)
    for i, v in ipairs(table) do if v == val then return true end end
end

function Entropy.GetNextRarity(rarity)
    if rarity == "entr_reverse_legendary" then return "cry_exotic" end
    for i, v in pairs(Entropy.RarityChecks) do
        if v == rarity then return Entropy.RarityChecks[i+1] or v end
    end
    return rarity
end

function Entropy.GetHigherVoucherTier(voucher_key)
    for i, v in pairs(G.P_CENTER_POOLS.Voucher) do
        if Entropy.InTable(v.requires or {}, voucher_key) then return v.key end
    end
end

local gfcfbs = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	if
		not card or card.ability.infinitesimal or card.ability.set == "Back" or card.ability.set == "Sleeve"
	then
		return true
	end
	return gfcfbs(card)
end

function Entropy.RandomForcetrigger(card, num,context)
    local res = { }
			local cards = Entropy.GetRandomCards({G.jokers, G.hand, G.consumeables, G.play}, num, "fractured", function(card) return not card.edition or card.edition.key ~= "e_entr_fractured" end)
			for i, v in pairs(cards) do
				if Cryptid.demicolonGetTriggerable(v) and (not v.edition or v.edition.key ~= "e_entr_fractured") then
					local results = Cryptid.forcetrigger(v, context)
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					card_eval_status_text(
						v,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("cry_demicolon"), colour = G.C.GREEN }
					)
				elseif v.base.id and (not v.edition or v.edition.key ~= "e_entr_fractured") then
					local results = eval_card(v, {cardarea=G.play,main_scoring=true, forcetrigger=true, individual=true})
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					local results = eval_card(v, {cardarea=G.hand,main_scoring=true, forcetrigger=true, individual=true})
					if results then
						for i, v in pairs(results) do
							for i2, result in pairs(v) do
								if type(result) == "number" or (type(result) == "table" and result.tetrate) then
									res[i2] = Entropy.StackEvalReturns(res[i2], result, i2)
								else
									res[i2] = result
								end
							end
						end
					end
					card_eval_status_text(
						v,
						"extra",
						nil,
						nil,
						nil,
						{ message = localize("cry_demicolon"), colour = G.C.GREEN }
					)
				end
			end
			if res.p_dollars then ease_dollars(res.p_dollars) end
			return res
end

function Entropy.GetRandomSet(has_parakmi)
    local pool = pseudorandom_element(G.P_CENTER_POOLS, pseudoseed(has_parakmi and "parakmi" or "chaos"))
    local set = pool and pool[1] and pool[1].set
    while not set or Entropy.ParakmiBlacklist[set] or (not has_parakmi and Entropy.ChaosBlacklist[set]) do
        pool = pseudorandom_element(G.P_CENTER_POOLS, pseudoseed(has_parakmi and "parakmi" or "chaos"))
        set = pool and pool[1] and pool[1].set
    end
    return set
end

function Entropy.BlindIs(blind)
    if G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == blind then return true end
end

function Entropy.card_eval_status_text_eq(card, eval_type, amt, percent, dir, extra, pref, col, sound, vol)
    percent = percent or (0.9 + 0.2*math.random())
    if dir == 'down' then 
        percent = 1-percent
    end

    if extra and extra.focus then card = extra.focus end

    local text = ''
    local volume = vol or 1
    local card_aligned = 'bm'
    local y_off = 0.15*G.CARD_H
    if card.area == G.jokers or card.area == G.consumeables then
        y_off = 0.05*card.T.h
    elseif card.area == G.hand then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.area == G.play then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.jimbo  then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    end
    local config = {}
    local delay = 0.65
    local colour = config.colour or (extra and extra.colour) or ( G.C.FILTER )
    local extrafunc = nil
    sound = sound or 'multhit1'--'other1'
    amt = amt
    text = (pref) or ("Mult = "..amt)
    colour = col or G.C.MULT
    config.type = 'fade'
    config.scale = 0.7
    delay = delay*1.25
    if to_big(amt) > to_big(0) or to_big(amt) < to_big(0) then
        if extra and extra.instant then
            if extrafunc then extrafunc() end
            attention_text({
                text = text,
                scale = config.scale or 1, 
                hold = delay - 0.2,
                backdrop_colour = colour,
                align = card_aligned,
                major = card,
                offset = {x = 0, y = y_off}
            })
            play_sound(sound, 0.8+percent*0.2, volume)
            if not extra or not extra.no_juice then
                card:juice_up(0.6, 0.1)
                G.ROOM.jiggle = G.ROOM.jiggle + 0.7
            end
        else
            G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
                    trigger = 'before',
                    delay = delay,
                    func = function()
                    if extrafunc then extrafunc() end
                    attention_text({
                        text = text,
                        scale = config.scale or 1, 
                        hold = delay - 0.2,
                        backdrop_colour = colour,
                        align = card_aligned,
                        major = card,
                        offset = {x = 0, y = y_off}
                    })
                    play_sound(sound, 0.8+percent*0.2, volume)
                    if not extra or not extra.no_juice then
                        card:juice_up(0.6, 0.1)
                        G.ROOM.jiggle = G.ROOM.jiggle + 0.7
                    end
                    return true
                    end
            }))
        end
    end
    if extra and extra.playing_cards_created then 
        playing_card_joker_effects(extra.playing_cards_created)
    end
end