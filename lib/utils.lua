function Entropy.GetHighlightedCards(cardareas, ignorecard, min, max, blacklist)
    if Cryptid.get_highlighted_cards then
        return Cryptid.get_highlighted_cards(cardareas, ignorecard or {}, min or 1, max or 1, blacklist and function(card)
            return not blacklist[card.config.center.key]
        end)
    else    
        local cards = {}
        if ignorecard then ignorecard.checked = true end
        blacklist = blacklist or {}
        for i, area in pairs(cardareas) do
            if area.cards then
                for i2, card in ipairs(area.highlighted) do
                    if card ~= ignorecard and not blacklist[card.config.center.key] and card.highlighted and not card.checked then
                        cards[#cards + 1] = card
                        card.checked = true
                    end
                end
            end
        end
        for i, v in ipairs(cards) do v.checked = nil end
        if ignorecard then ignorecard.checked = false end
        return cards
    end
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
    if not card then return end
    return Entropy.FlipsideInversions[card.key or card.config.center.key]
end

function Entropy.is_inverted(card)
    if not card then return end
    return Entropy.FlipsideInversions[card.key or card.config.center.key] and not Entropy.FlipsidePureInversions[card.key or card.config.center.key]
end

function Entropy.inversion_queue(card, _c, first_pass)
    local info_queue = {}
    if Entropy.Inversion(card) and first_pass and Entropy.show_flipside(card, _c) and Entropy.config.inversion_queues > 1 then 
        if _c.key ~= "c_entr_flipside" then
          local inversion = G.P_CENTERS[Entropy.Inversion(_c)] 
          info_queue[#info_queue+1] = {key = "inversion_allowed", set = "Other", vars = {G.localization.descriptions[inversion.set][inversion.key].name}}
          if Entropy.config.inversion_queues > 2 then
            info_queue[#info_queue+1] = inversion
          end
        elseif Entropy.show_flipside(card, _c) and Entropy.config.inversion_queues > 1 then
          info_queue[#info_queue+1] = {key = "inversion_allowed", set = "Other", vars = {"???"}}
        end
    end
    return info_queue
end

function Entropy.FlipThen(cardlist, func, before, after)
    if not Talisman or not Talisman.config_file.disable_anims then
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
    else
        if before then
            before(card)
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
    if not Talisman or not Talisman.config_file.disable_anims then
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
    else    
        if after then
            after(card)
        end
    end
end

function Entropy.SealSpectral(key, sprite_pos, seal,order, inversion, entr_credits, atlas, q_vars)
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
        set = "Omen",
        
        atlas = atlas or "consumables",
        config = {
            highlighted = 1
        },
        pos = sprite_pos,
        inversion = inversion,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.ModifyHandCardNF({seal=seal}),
        can_use = function(self, card)
            local cards = Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.highlighted)
            return #cards > 0 and #cards <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            q[#q+1] = {key = seal.."_seal", set="Other", vars = q_vars}
            return {
                vars = {
                    card.ability.highlighted,
                    colours = {
                        SMODS.Seal.obj_table[seal].badge_colour or G.C.RED
                    }
                }
            }
        end,
        entr_credits = entr_credits,
        demicoloncompat = true,
        force_use = function(self, card)
            self:use(card)
        end
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

function Entropy.ModifyHandCardNF(modifications, cards)
    return function(self, card)
        for i, mcard in pairs(cards or Entropy.GetHighlightedCards({G.hand}, {}, 1, card.ability.highlighted or 1)) do
            G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
            delay = 0,
            func = function()
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
                mcard:juice_up()
                return true
            end}))
        end

    end
end

function Entropy.FindPreviousInPool(item, pool)
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if G.P_CENTER_POOLS[pool][i].key == item then
            local ind = i - 1
            while G.GAME.banned_keys[G.P_CENTER_POOLS[pool][ind].key] or G.P_CENTER_POOLS[pool][ind].no_doe do
                ind = ind - 1
            end
            return G.P_CENTER_POOLS[pool][ind].key
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
				if Cryptid.demicolonGetTriggerable(v)[1] and (not v.edition or v.edition.key ~= "e_entr_fractured") then
					local results = Cryptid.forcetrigger(v, context)
					if results then
						for i, v2 in pairs(results) do
							for i2, result in pairs(type(v2) == "table" and v2 or {}) do
                                SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
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
						for i, v2 in pairs(results) do
							for i2, result in pairs(type(v2) == "table" and v2 or {}) do
                                SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
							end
						end
					end
					local results = eval_card(v, {cardarea=G.hand,main_scoring=true, forcetrigger=true, individual=true})
					if results then
						for i, v2 in pairs(results) do
							for i2, result in pairs(type(v2) == "table" and v2 or {}) do
                                SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
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
    if Entropy.IsEE() and Entropy.EEWhitelist[blind] then return true end
end

function Entropy.card_eval_status_text_eq(card, eval_type, amt, percent, dir, extra, pref, col, sound, vol, ta)
    if card.area == G.butterfly_jokers and G.deck.cards[1] then 
        Entropy.card_eval_status_text_eq(G.deck.cards[1], eval_type, amt, percent, dir, extra, pref, col, sound, vol, true)
        return
    end
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
    elseif card.area == G.hand or ta then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.area == G.play then
        y_off = -0.05*G.CARD_H
        card_aligned = 'tm'
    elseif card.jimbo then
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

function Entropy.FormatArrowMult(arrows, mult)
    mult = type(mult) ~= "string" and number_format(mult) or mult
    if to_big(arrows) <= to_big(-2.01) then
        return "{"..arrows.."}"..mult
    end
    if to_big(arrows) < to_big(-1.1) then 
        return "="..mult 
    elseif to_big(arrows) < to_big(-0.1) then 
        return "+"..mult 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..mult
        end
        local arr = ""
        for i = 1, to_number(arrows) do
            arr = arr.."^"
        end
        return arr..mult
    else
        return "{"..arrows.."}"..mult
    end
end
function Entropy.RareTag(rarity, key, ascendant, colour, pos, fac, legendary,order)
    return {
        object_type = "Tag",
        order = order,
        dependencies = {
          items = {
            "set_entr_tags",
          }
        },
        shiny_atlas="entr_shiny_asc_tags",
        key = (ascendant and "ascendant_" or "")..key,
        atlas = (ascendant and "ascendant_tags" or "tags"),
        pos = pos,
        config = { type = "store_joker_create" },
        in_pool = ascendant and function() return false end or nil,
        apply = function(self, tag, context)
            if context.type == "store_joker_create" then
                local rares_in_posession = { 0 }
                for k, v in ipairs(G.jokers.cards) do
                    if v.config.center.rarity == rarity and not rares_in_posession[v.config.center.key] then
                        rares_in_posession[1] = rares_in_posession[1] + 1
                        rares_in_posession[v.config.center.key] = true
                    end
                end
                local card
                if #G.P_JOKER_RARITY_POOLS[rarity] > rares_in_posession[1] then
                    card = create_card('Joker', context.area, legendary, rarity, nil, nil, nil, 'uta')
                    create_shop_card_ui(card, "Joker", context.area)
                    card.states.visible = false
                    tag:yep("+", G.C.RARITY[colour], function()
                        card:start_materialize()
                        card.misprint_cost_fac = 0 or fac
                        card:set_cost()
                        return true
                    end)
                else
                    tag:nope()
                end
                tag.triggered = true
                return card
            end
        end,
    }
end

function Entropy.EditionTag(edition, key, ascendant, pos,order, credits)
    return {
        object_type = "Tag",
        dependencies = {
            items = {
                "set_entr_tags",
            }
        },
        order = order,
        shiny_atlas="entr_shiny_asc_tags",
        key = (ascendant and "ascendant_" or "")..key,
        atlas = (ascendant and "ascendant_tags" or "tags"),
        pos = pos,
        config = { type = "store_joker_modify" },
        in_pool = ascendant and function() return false end or nil,
        apply = function(self, tag, context)
            if context.type == "store_joker_modify" then
                tag:yep("+", G.C.RARITY[colour], function()
                    for i, v in pairs(G.shop_jokers.cards) do
                        v:set_edition(edition)
                    end
                    for i, v in pairs(G.shop_booster.cards) do
                        v:set_edition(edition)
                    end
                    for i, v in pairs(G.shop_vouchers.cards) do
                        v:set_edition(edition)
                    end
                    return true
                end)
                tag.triggered = true
            end
        end,
        loc_vars = function(s,q,c)
            q[#q+1] = edition and G.P_CENTERS[edition] or nil
        end,
        entr_credits = credits
    }
end

Entropy.EEWhitelist["bl_final_heart"]=true
Entropy.EEWhitelist["bl_final_leaf"]=true
Entropy.EEWhitelist["bl_final_vessel"]=true
Entropy.EEWhitelist["bl_final_acorn"]=true
Entropy.EEWhitelist["bl_final_bell"]=true
Entropy.EEWhitelist["bl_cry_sapphire_stamp"]=true
Entropy.EEWhitelist["bl_entr_burgundy_baracuda"]=true
Entropy.EEWhitelist["bl_entr_diamond_dawn"]=true
Entropy.EEWhitelist["bl_entr_olive_orchard"]=true
Entropy.EEWhitelist["bl_entr_scarlet_sun"]=true
Entropy.EEWhitelist["bl_entr_citrine_comet"]=true

function Entropy.GetEEBlinds()
    local blinds = {}
    for i, v in pairs(G.P_BLINDS) do
        if Entropy.EEWhitelist[i] then
            blinds[i]=v
        end
    end
    return blinds
end

function Entropy.GetRandomCards(areas, cardns, rpseudoseed, cond)
    local cards = {}
    for i, v in pairs(areas) do
        for i2, v2 in pairs(v.cards) do
            if not cond or cond(v2) then cards[#cards+1]=v2 end
        end
    end
    pseudoshuffle(cards, pseudoseed(rpseudoseed or "fractured"))
    local temp = {}
    for i = 1, cardns do
        temp[i] = cards[i]
    end
    return temp
end

function Entropy.StackEvalReturns(orig, new, etype)
    if etype == "Xmult" or etype == "x_mult" or etype == "Xmult_mod" or etype == "Xchips" or etype == "Xchip_mod" or etype == "asc" or etype == "Emult_mod" or etype == "Echip_mod" then return (orig or 1) * new else
        return (orig or 0) + new
    end
end

function Entropy.DeckOrSleeve(key)
    local num = 0
    if key == "doc" and G.GAME.modifiers.doc_antimatter then num = num + 1 end
    if key == "butterfly" and G.GAME.modifiers.butterfly_antimatter then num = num + 1 end
    if CardSleeves then
        if G.GAME.selected_sleeve == ("sleeve_entr_"..key) then num = num + 1 end
    end
    for i, v in pairs(G.GAME.entr_bought_decks or {}) do
        if v == "b_entr_"..key then num = num + 1 end
    end
    if  G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key == key then num = num + 1 end
    return num > 0 and num or nil
end

Entropy.charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~#$^~#$^~#$^~#$^~#$^"
function Entropy.srandom(length, charset) 
    local total = ""
    for i = 0, length do
        local val = math.random(1,charset and #charset or #Entropy.charset)
        total = total..((charset or Entropy.charset):sub(val, val))
    end
    return total
end

function Entropy.ChangeEnhancements(areas, enh, required, uhl)
    for i, v in pairs(areas) do
        if not v.cards then 
            areas[i] = {
                cards = {v}
            }
        end
    end
    for i, v in pairs(areas) do
        for i2, v2 in pairs(v.cards) do
            if not required or (v2.config and v2.config.center.key == required) then
                if enh == "null" then
                    v2:start_dissolve()
                elseif enh == "ccd" then

                else
                    v2:set_ability(G.P_CENTERS[enh])
                    v2:juice_up()
                end
            end
        end
    end
end

function Entropy.ApplySticker(card, key)
    if not card.ability then card.ability = {} end
    if card.ability then
        if not SMODS.Stickers[key] then return end
        card.ability[key] = true
        if SMODS.Stickers[key].apply then SMODS.Stickers[key].apply(SMODS.Stickers[key], card) end
    end
end

function Entropy.HigherCardRank(card)
	if not card.base then return nil end
	local rank_suffix = math.min(card.base.id, 14)
	if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
	elseif rank_suffix == 10 then rank_suffix = '10'
	elseif rank_suffix == 11 then rank_suffix = 'Jack'
	elseif rank_suffix == 12 then rank_suffix = 'Queen'
	elseif rank_suffix == 13 then rank_suffix = 'King'
	elseif rank_suffix == 14 then raFnk_suffix = 'Ace'
	end
	return ({
		Queen = "King",
		Jack = "Queen",
		["10"] = "Jack",
		["9"] = "10",
		["8"] = "9",
		["7"] = "8",
		["6"] = "7",
		["5"] = "6",
		["4"] = "5",
		["3"] = "4",
		["2"] = "3",
		Ace = "2",
		King = "Ace",
	})[tostring(rank_suffix)]
end

Entropy.ReverseRarityChecks = {

}
for i, v in ipairs(Entropy.RarityChecks) do
    Entropy.ReverseRarityChecks[v]=i
end
function Entropy.RarityAbove(check, threshold, gte)
    if not Entropy.ReverseRarityChecks[check] then Entropy.ReverseRarityChecks[check] = 1 end
    if not Entropy.ReverseRarityChecks[threshold] then Entropy.ReverseRarityChecks[threshold] = 1 end
    if gte then return Entropy.ReverseRarityChecks[check] < Entropy.ReverseRarityChecks[threshold] end
    return Entropy.ReverseRarityChecks[check] <= Entropy.ReverseRarityChecks[threshold]
end
function Entropy.GetRandomRarityCard(rare)
    if rare == 1 then rare = "Common" end
    if rare == 2 then rare = "Uncommon" end
    if rare == 3 then rare = "Rare" end
    local _pool, _pool_key = get_current_pool("Joker", rare, rare == 4, "ieros")
    local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
    local it = 1
    while center == 'UNAVAILABLE' do
        it = it + 1
        center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
    end
    return center
end

function Entropy.randomchar(arr)
    return {
        n = G.UIT.O,
        config = {
            object = DynaText({
                string = arr,
                colours = { HEX("b1b1b1") },
                pop_in_rate = 9999999,
                silent = true,
                random_element = true,
                pop_delay = 0.1,
                scale = 0.3,
                min_cycle_time = 0,
            }),
        },
    }
end

function Entropy.GetJokerSumRarity(loc)
    if not G.jokers or #G.jokers.cards <= 0 then return "none" end
    local rarity = 1
    local sum = Entropy.SumJokerPoints()
    local last_sum = 0
    for i, v in pairs(Entropy.RarityPoints) do
        if type(sum) == "table" then
            if v > 12 and sum:gte(v-1) or sum:gte(v) then  
                if v > last_sum  then
                    rarity = i 
                    last_sum = v
                end
            end
        elseif sum >= (v > 12 and v-1 or v-0.01) then                 
            if v > last_sum  then
                rarity = i 
                last_sum = v
            end 
        end
    end
    if not loc then
        return rarity
    else
        return localize(({
            [1] = "k_common",
            [2] = "k_uncommon",
            [3] = "k_rare",
            [4] = "k_legendary"
        })[rarity] or "k_"..rarity)
    end
end
function Entropy.SumJokerPoints()
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        total = total + Entropy.GetJokerPoints(v)
    end
    return total
end
function Entropy.GetJokerPoints(card)
    local total = Entropy.RarityPoints[card.config.center.rarity] or 1
    if card.edition then
        local factor = to_big(Entropy.GetEditionFactor(card.edition)) ^ (1.7/(Entropy.RarityDiminishers[card.config.center.rarity] or 1))
        total = total * factor
    end
    return total
end 
function Entropy.GetEditionFactor(edition)
    return Entropy.EditionFactors[edition.key] or 1
end

function Entropy.CanEeSpawn()
    if MP and MP.LOBBY and MP.LOBBY.code then return false end
    return (SMODS.Mods["Cryptid"] or {}).can_load and Talisman 
    and Cryptid.enabled("bl_entr_endless_entropy_phase_one")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_two")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_three")
    and Cryptid.enabled("bl_entr_endless_entropy_phase_four")
end

function Entropy.stringsplit(s) 
    local tbl = {}
    for i = 1, #s do
        tbl[#tbl+1]=s:sub(i,i)
    end
    return tbl
end

function Entropy.TableAny(table, func)
    for i, v in pairs(table) do if func(v) then return true end end
end

function Card:is_sunny()
    if self.config.center.key == "j_entr_sunny_joker" then return true end
    if self.edition and self.edition.key == "e_entr_sunny" then return true end
    if self.config.center.pools and self.config.center.pools.Sunny == true then return true end
    return nil
end

function Entropy.UpgradeEnhancement(card, bypass, blacklist)
    local enh = card.config.center.key
    if enh == "c_base" then return "m_bonus" end
    local cards = {}
    for i, v in pairs(G.P_CENTER_POOLS.Enhanced) do
        if (not v.no_doe or bypass) and not blacklist[v.key] then cards[#cards+1]=v end
    end
    table.sort(cards, function(a, b)
        return (a.upgrade_order or a.order) < (b.upgrade_order or b.order)
    end)
    for i, v in pairs(cards) do
        if v.key == enh then return cards[i+1] and cards[i+1].key end
    end
    return nil
end
function Entropy.GetAreaName(area) 
    if not area then return nil end
    for i, v in pairs(G) do
        if v == area then return i end
    end
end
function Entropy.GetIdxInArea(card)
    if card and card.area then
        for i, v in pairs(card.area.cards) do
            if v.unique_val == card.unique_val then return i end
        end
    end
end
function Entropy.FormatTesseract(base)
    if math.abs(to_big(base.c)) < to_big(0.001) then base.c = 0;base.minusc=false end
    if math.abs(to_big(base.r)) < to_big(0.001) then base.r = 0;base.minusr=false end
    local minr = base.minusr and "-" or ""
    local minc = base.minusc and "-" or ""
    if to_big(base.c) == to_big(0) then return minr..number_format(base.r) end
    if to_big(base.c) ~= to_big(0) and to_big(base.r) == to_big(0) then
        return minc..number_format(base.c).."i"
    end
    if base.minusc then
        return minr..number_format(base.r) .. "-" ..number_format(base.c).."i"
    end
    if not base.minusc then
        return minr..number_format(base.r) .. "+" ..number_format(base.c).."i"
    end
end


function Entropy.WhatTheFuck(base, val)
    if to_big(base.r) < to_big(0) then 
        base.r = -base.r
        base.minusr = true
    end
    if to_big(base.c) < to_big(0) then 
        base.c = math.abs(base.c)
        base.minusc = true
    end
    if to_big(math.abs(base.c)) < to_big(0.0001) then base.c = 0 end
    if to_big(math.abs(base.r)) < to_big(0.0001) then base.r = 0 end
    base.c = to_big(base.c) * to_big(val)
    base.r = to_big(base.r) * to_big(val)
    return Entropy.FormatTesseract(base)
end

function Entropy.RandomContext(seed)
    return pseudorandom_element({
        "before",
        "pre_joker",
        "joker_main",
        "individual",
        "pre_discard",
        "remove_playing_cards",
        "setting_blind",
        "ending_shop",
        "reroll_shop",
        "selling_card",
        "using_consumeable",
        "playing_card_added"
    }, pseudoseed(seed or "desync"))
end

function Entropy.ContextChecks(self, card, context, currc, edition)
    if not context.retrigger_joker and not context.blueprint and not context.forcetrigger and not context.post_trigger then
        if currc == "before" and context.before then return true end
        if currc == "pre_joker" and ((context.pre_joker) or (edition and context.main_scoring and context.cardarea == G.play)) then return true end
        if currc == "joker_main" and ((context.joker_main) or (edition and context.main_scoring and context.cardarea == G.play)) then return true end
        if currc == "individual" and ((context.individual and context.cardarea == G.play and not context.blueprint) or (edition and context.main_scoring and context.cardarea == G.play)) then return true end
        if currc == "pre_discard" and context.pre_discard and context.cardarea == G.hand and not context.retrigger_joker and not context.blueprint then return true end
        if currc == "remove_playing_cards" and context.remove_playing_cards and not context.blueprint then return true end
        if currc == "setting_blind" and context.setting_blind then return true end
        if currc == "ending_shop" and context.ending_shop then return true end
        if currc == "reroll_shop" and context.reroll_shop then return true end
        if currc == "selling_card" and context.selling_card then return true end
        if currc == "using_consumeable" and context.using_consumeable then return true end
        if currc == "playing_card_added" and context.playing_card_added then return true end
    end
end

function Entropy.IsEE()
    return G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_one"
    or G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_two"
    or G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_three"
    or G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind.key == "bl_entr_endless_entropy_phase_four"
end

function Entropy.WinEE()
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            for k, v in pairs(G.I.CARD) do
                v.sticker_run = nil
            end
            
            play_sound('win')
            G.SETTINGS.paused = true
            G.GAME.TrueEndless = true
            G.FUNCS.overlay_menu{
                definition = create_UIBox_win(),
                config = {no_esc = true}
            }
            local Jimbo = nil

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2.5,
                blocking = false,
                func = (function()
                    if G.OVERLAY_MENU and G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot') then 
                        local quip, extra = SMODS.quip("ee_win")
                        extra.x = 0
                        extra.y = 5
                        Jimbo = Card_Character(extra)
                        local spot = G.OVERLAY_MENU:get_UIE_by_ID('jimbo_spot')
                        spot.config.object:remove()
                        spot.config.object = Jimbo
                        Jimbo.ui_object_updated = true
                        Jimbo:add_speech_bubble(quip, nil, {quip = true})
                        Jimbo:say_stuff(5)
                    end
                    return true
                end)
            }))
            
            return true
        end)
    }))

    if (not G.GAME.seeded and not G.GAME.challenge) or SMODS.config.seeded_unlocks then
        G.PROFILES[G.SETTINGS.profile].stake = math.max(G.PROFILES[G.SETTINGS.profile].stake or 1, (G.GAME.stake or 1)+1)
    end
    G:save_progress()
    G.FILE_HANDLER.force = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            if not G.SETTINGS.paused then
                G.GAME.current_round.round_text = 'Endless Round '
                return true
            end
        end)
    }))
end

Entropy.TMTrainerEffects["mult"] = function(key) return { mult = pseudorandom(key) * 400 } end
Entropy.TMTrainerEffects["chips"] = function(key) return { chips = pseudorandom(key) * 4000 } end
Entropy.TMTrainerEffects["xmult"] = function(key) return { xmult = pseudorandom(key) * 40 } end
Entropy.TMTrainerEffects["xchips"] = function(key) return { xchips = pseudorandom(key) * 40 } end
Entropy.TMTrainerEffects["emult"] = function(key) return { emult = pseudorandom(key) * 4 } end
Entropy.TMTrainerEffects["echips"] = function(key) return { echips = pseudorandom(key) * 4 } end
Entropy.TMTrainerEffects["dollars"] = function(key) ease_dollars(pseudorandom(key) * 20) end
Entropy.TMTrainerEffects["joker_random"] = function(key) SMODS.add_card({set = "Joker"}) end
Entropy.TMTrainerEffects["joker_choose_rarity"] = function(key) SMODS.add_card({set = "Joker", rarity = pseudorandom_element({1, 1, 1, 2, 2, 3, 3, "cry_epic"}, pseudoseed(key))}) end
Entropy.TMTrainerEffects["edition"] = function(key) 
    local element = pseudorandom_element(G.jokers.cards, pseudoseed(key))
    Entropy.FlipThen({element}, function(card)
        card:set_edition(Entropy.pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entropy"),function(e)
            return G.GAME.banned_keys[e.key] or e.no_doe
        end).key)
    end)
end
Entropy.TMTrainerEffects["ante"] = function(key) ease_ante(-pseudorandom(key)*0.1) end
Entropy.TMTrainerEffects["consumable"] = function(key) SMODS.add_card({key = Cryptid.random_consumable("entr_segfault", nil, "c_entr_segfault").key, area = G.consumeables}) end
Entropy.TMTrainerEffects["enhancement_play"] = function(key) 
    local enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("entropy")).key
    while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
        enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("entropy")).key
    end
    local element = pseudorandom_element(G.play.cards, pseudoseed(key))
    Entropy.FlipThen({element}, function(card)
        card:set_ability(G.P_CENTERS[enhancement])
    end)
end
Entropy.TMTrainerEffects["enhancement_hand"] = function(key) 
    local enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("entropy")).key
    while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
        enhancement = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed("entropy")).key
    end
    local element = pseudorandom_element(G.hand.cards, pseudoseed(key))
    Entropy.FlipThen({element}, function(card)
        card:set_ability(G.P_CENTERS[enhancement])
    end)
end
Entropy.TMTrainerEffects["random"] = function(key, context )
    local res = {}
    for i = 1, 3 do
        local results = Entropy.TMTrainerEffects[Entropy.RandomEffect()]("tmtrainer_actual_effect", context) or nil
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
    end
    return res
end

Entropy.TMTrainerScoring["mult"]=true
Entropy.TMTrainerScoring["xmult"]=true
Entropy.TMTrainerScoring["emult"]=true
Entropy.TMTrainerScoring["chips"]=true
Entropy.TMTrainerScoring["xchips"]=true
Entropy.TMTrainerScoring["echips"]=true
Entropy.TMTrainerScoring["enhancement_play"]=true

function Entropy.RandomEffect(context)
    local keys = {}
    for i, v in pairs(Entropy.TMTrainerEffects) do
        keys[#keys+1] = i
    end
    local scoring = {
        before=true,
        pre_joker=true,
        joker_main=true,
        individual=true,
    }
    local element = pseudorandom_element(keys, pseudoseed("tmtrainer_effect"))
    while not scoring[context] and Entropy.TMTrainerScoring[element] do
        element = pseudorandom_element(keys, pseudoseed("tmtrainer_effect"))
    end
    return element
end
function Entropy.TMTTrainize(card)
    local context = Entropy.RandomContext()
    local effect = Entropy.RandomEffect(context)
    card.ability.tm_effect = effect
    card.ability.tm_context = context
end

SMODS.Edition:take_ownership("e_cry_glitched", {
    calculate = function(self, card, context)
        if card.ability.tm_effect then
            if Entropy.ContextChecks(self, card, context, card.ability.tm_context, true) then
                return Entropy.TMTrainerEffects[card.ability.tm_effect]("tmtrainer_actual_effect", card.ability.tm_context) or nil
            end
        end
    end,
    loc_vars = function(self, q, card) 
        if card and card.ability and card.ability.tm_effect then
            q[#q+1] = {set = "Other", key = "tmtrainer_dummy", vars = {localize("k_"..card.ability.tm_context), localize("k_tmt"..card.ability.tm_effect)}}
        end
    end
}, true)

function Entropy.ChangePhase()
    G.STATE = 1
    G.STATE_COMPLETE = false
    local remove_temp = {}
    for i, v in pairs({G.jokers, G.hand, G.consumeables, G.discard, G.deck}) do
        for ind, card in pairs(v.cards) do
            if card.ability then
                if card.ability.temporary or card.ability.temporary2 then
                    if card.area ~= G.hand and card.area ~= G.play and card.area ~= G.jokers and card.area ~= G.consumeables then card.states.visible = false end
                    card:remove_from_deck()
                    card:start_dissolve()
                    if card.ability.temporary then remove_temp[#remove_temp+1]=card end
                end
            end
        end
    end
    if #remove_temp > 0 then
        SMODS.calculate_context({remove_playing_cards = true, removed=remove_temp})
    end
    G.deck:shuffle()
    G.E_MANAGER:add_event(Event({func = function()
        G.GAME.ChangingPhase = nil
        return true
    end}))
end

function Entropy.LevelSuit(suit, card, amt, chips_override)
    amt = amt or 1
    local used_consumable = copier or card
    if not G.GAME.SuitBuffs then G.GAME.SuitBuffs = {} end
    if not G.GAME.SuitBuffs[suit] then
        G.GAME.SuitBuffs[suit] = {level = 1, chips = 0}
    end
    if not G.GAME.SuitBuffs[suit].chips then G.GAME.SuitBuffs[suit].chips = 0 end
    if not G.GAME.SuitBuffs[suit].level then G.GAME.SuitBuffs[suit].level = 1 end
    update_hand_text(
    { sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
    { handname = localize(suit,'suits_plural'), chips = number_format(G.GAME.SuitBuffs[suit].chips), mult = "...", level = G.GAME.SuitBuffs[suit].level }
    )
    G.GAME.SuitBuffs[suit].chips = G.GAME.SuitBuffs[suit].chips + (chips_override or 10)*amt
    G.GAME.SuitBuffs[suit].level = G.GAME.SuitBuffs[suit].level + amt
    for i, v in ipairs(G.I.CARD) do
        if v.base and v.base.suit == suit then
            v.ability.bonus = (v.ability.bonus or 0) + (chips_override or 10)*amt
            v.ability.bonus_from_suit = (v.ability.bonus_from_suit or 0) + (chips_override or 10)*amt
        end
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true 
        end 
    }))
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true 
        end 
    }))
    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { chips="+"..number_format((10 or chips_override)*amt), StatusText = true })
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true 
        end 
    }))
    update_hand_text({ sound = "button", volume = 0.7, pitch = 0.9, delay = 0 }, { level = G.GAME.SuitBuffs[suit].level, chips=number_format(G.GAME.SuitBuffs[suit].chips) })
    delay(1.3)
    update_hand_text(
    { sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
    { mult = 0, chips = 0, handname = "", level = "" }
    )
end

function Entropy.GetRepetitions(card)
    local res2 = {}
    for i, v in ipairs(G.jokers.cards) do
        local res = eval_card(v, {repetition=true, other_card=card,cardarea=card.area,card_effects={{},{}}})
        if res.jokers and res.jokers.repetitions then
            res2.repetitions = (res2.repetitions or 0) + res.jokers.repetitions
        end
    end
    return res2
end

function Entropy.CanSwitchAltPath()
    return G.GAME.round_resets.blind_states[G.GAME.modifiers.cry_no_small_blind and "Big" or "Small"] == "Upcoming" and Cryptid.enabled("set_entr_altpath") == true
end

function Entropy.ApproximateLogRecursion(orig, base, iter)
    if to_big(iter) < to_big(1000) then
        if to_big(orig) < to_big(base) then return orig end
        local result = orig
        for i = 1, to_number(iter) do
            result = to_big(result) * to_big(math.log(to_big(result), to_big(base)))
        end
        return result
    else
        local m = iter/math.log(base)
        local l1 = math.log(m)
        local l2 = math.log(l1)
        local E = iter * (l1 + l2 - 1 + ((l2-2)/l1))
        local result = to_big(2.718281846) ^ to_big(E)
        return result
    end
end

function Entropy.change_play_limit_no_bs(mod,stroverride)
    if SMODS.hand_limit_strings then
        G.GAME.starting_params.play_limit = (G.GAME.starting_params.play_limit or 5) + mod
        G.hand.config.highlighted_limit = math.max(G.GAME.starting_params.discard_limit or 5, G.GAME.starting_params.play_limit or 5)
        local str = stroverride or G.GAME.starting_params.play_limit or ""
        SMODS.hand_limit_strings.play = G.GAME.starting_params.play_limit ~= 5 and localize('b_limit') .. str  or ''
    else
        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + mod
    end
end

function Entropy.change_discard_limit_no_bs(mod,stroverride)
    G.GAME.starting_params.discard_limit = (G.GAME.starting_params.discard_limit or 5) + mod
    G.hand.config.highlighted_limit = math.max(G.GAME.starting_params.discard_limit or 5, G.GAME.starting_params.play_limit or 5)
    local str = stroverride or G.GAME.starting_params.discard_limit or ""
    SMODS.hand_limit_strings.discard = G.GAME.starting_params.discard_limit ~= 5 and localize('b_limit') .. str or ''
end

function Entropy.ChangeFullCSL(mod,stroverride)
    if not SMODS.hand_limit_strings then SMODS.hand_limit_strings = {} end
    Entropy.change_play_limit_no_bs(mod,stroverride)
    if SMODS.hand_limit_strings then
        Entropy.change_discard_limit_no_bs(mod,stroverride)
    end
end

function Entropy.GetIota()
    return {[G.GAME.iotablind.key] = G.GAME.iotablind}
end

local function hash(str)
    local h = 5381

    for i = 1, #str do
       h = h*32 + h + str:byte(i)
    end
    return h
end

function Entropy.GetDailyChallenge()
    Entropy.UpdateDailySeed()
    local seed = Entropy.DAILYSEED
    --https://tools.aimylogic.com/api/now?tz=Europa/England&format=dd/MM/yyyy to:do use this
    math.randomseed(hash(seed))
    G.CHALLENGES["daily"] = Entropy.SpecialDailies[seed] or Entropy.SpecialDailies[os.date("%m").."/"..os.date("%d")] or Entropy.GenerateDaily()
end
function Entropy.GenerateDaily()
    Entropy.UpdateDailySeed()
    local seed = Entropy.DAILYSEED
    math.randomseed(hash(seed))
    local allowed_rules = {
        "no_shop_jokers",
        "no_reward",
        "no_interest",
        "no_extra_hand_money",
        "inflation",
        "all_eternal",
    }
    local rules = math.random(0, 1)
    local generate = {}
    local arules = {}
    if rules > 0 then
        for i = 1, rules do
            local rule= allowed_rules[math.random(1, #allowed_rules)]
            while generate[rule] do
                rule = allowed_rules[math.random(1, #allowed_rules)]
            end
            generate[rule] = true
            table.insert(arules, {id=rule})
        end
    end
    local seed = Entropy.DAILYSEED
    math.randomseed(hash(seed))
    table.insert(arules, {id = 'entr_set_seed', value = Entropy.srandom(8, "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890")})
    return {
        consumeables = {
            {id = Entropy.GetInPoolDaily("Consumeables")},
            math.random(1, 100) < 40 and {id = Entropy.GetInPoolDaily("Consumeables")} or nil,
        },
        vouchers = {
            math.random(1, 100) < 50 and {
                id = Entropy.GetInPoolDaily("Voucher")
            } or nil,
            math.random(1, 100) < 10 and {
                id = Entropy.GetInPoolDaily("Voucher")
            } or nil
        },
        jokers = {
            math.random(1, 100) < 75 and {
                id = Entropy.GetInPoolDaily("Joker")
            } or nil,
            math.random(1, 100) < 25 and {
                id = Entropy.GetInPoolDaily("Joker")
            } or nil,
            math.random(1, 100) < 2 and {
                id = Entropy.GetInPoolDaily("Joker")
            } or nil
        },
        rules = {
            custom = arules,
        },
        key = "c_entr_daily",
        id = "c_entr_daily",
        original_key = "daily",
        registered = true,
        deck = {
            type = "Challenge Deck"
        },
        restrictions = Entropy.DailyBanlist()
        -- consumeables = {
        --     {id = G.P_CENTER_POOLS.Consumeables[math.random(1, #G.P_CENTER_POOLS.Consumeables)].key},
        --     {id = G.P_CENTER_POOLS.Consumeables[math.random(1, #G.P_CENTER_POOLS.Consumeables)].key}
        -- }
    }
end

function Entropy.GetInPoolDaily(pool)
    local allowed = {
        entr = true,
        Cryptid = true
    }
    local actual = {}
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if (not v.no_doe and v.set ~= "CBlind" and (not v.original_mod or allowed[v.original_mod.id])) and not Entropy.DailyBanlistContains(v.key) then
            actual[#actual+1] = v 
        end
    end
    return actual[math.random(1,#actual)].key
end

G.FUNCS.start_challenge_run = function(e)
    if G.OVERLAY_MENU then G.FUNCS.exit_overlay_menu() end
    local seed = nil
    for i, v in ipairs(G.CHALLENGES[e.config.id].rules and type(G.CHALLENGES[e.config.id].rules.custom) == "table" and G.CHALLENGES[e.config.id].rules.custom or {}) do
        if v.id == "entr_set_seed" then seed = v.value end
    end
    G.FUNCS.start_run(e, {stake = 1, challenge = G.CHALLENGES[e.config.id], seed =seed})
  end

  function Entropy.DailyBanlist()
    return {
        banned_cards = {
            {id="c_entr_decrement"},
            {id="c_entr_push"},
            {id="c_entr_evocation"},
            {id="c_entr_memory_leak"},
            {id="c_entr_define"},
            {id="c_cry_crash"},
            {id="c_cry_pointer"},
            {id="c_cry_hook"},
            {id="c_entr_desync"},
            {id="c_entr_shatter"},
            {id="c_entr_break"},
            {id="c_cry_revert"},

            {id="v_cry_asteroglyph"},

            {id="j_cry_pity_prize"},
            {id="j_cry_demicolon"},
            {id="j_cry_crustulum"},
            {id="j_entr_ieros"},
            {id="j_entr_dekatria"},
            {id="j_cry_cotton_candy"},
            {id="j_cry_coin"},
            {id="j_cry_copypaste"},
            {id="j_entr_trapezium_cluster"},
            {id="j_entr_antidagger"},
            {id="e_entr_fractured", type="Edition"}
        },
        banned_tags = {
            {id="tag_entr_fractured"},
            {id="tag_entr_ascendant_fractured"},
        },
        banned_other = {
        }
    }
end

function Entropy.DailyBanlistContains(key)
    for i, v in pairs(Entropy.DailyBanlist().banned_cards) do
        if v.id == key then return true end
    end
end

function Card:is_food()
    local food = {
        j_gros_michel=true,
		j_egg=true,
		j_ice_cream=true,
		j_cavendish=true,
		j_turtle_bean=true,
		j_diet_cola=true,
		j_popcorn=true,
		j_ramen=true,
		j_selzer=true,
    }
    if food[self.config.center.key] or Cryptid.safe_get(self.config.center, "pools", "Food") then return true end
end

function Entropy.pseudorandom_element(table, seed, blacklist)
    local elem = pseudorandom_element(table, seed)
    local tries = 0
    while blacklist(elem) and tries < 100 do
        elem = pseudorandom_element(table, seed)
        tries = tries + 1
    end
    return elem
end



function Entropy.no_recurse_scoring(poker_hands)
    local text 
    local scoring_hand
	for _, v in ipairs(G.handlist) do
		if next(poker_hands[v]) then
			text = v
			scoring_hand = poker_hands[v][1]
			break
		end
	end
    return text
end

function Entropy.get_arrow_color(operator)
    local colours = {
        [-1] = HEX("a26161"),
        [0] = G.C.RED,
        [1] = G.C.EDITION,
        [2] = G.C.CRY_ASCENDANT,
        [3] = G.C.CRY_EXOTIC,
        [4] = Entropy.entropic_gradient
    }
    return colours[operator]
end

function Entropy.GetPooledCenter(_type, twisted)
    local area = area or G.jokers
    local center = G.P_CENTERS.b_red
        

    --should pool be skipped with a forced key
    if not forced_key and soulable and (not G.GAME.banned_keys['c_soul']) then
        for _, v in ipairs(SMODS.Consumable.legendaries) do
            if (_type == v.type.key or _type == v.soul_set) and not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman")) and not v.can_repeat_soul) and (not v.in_pool or (type(v.in_pool) ~= "function") or v:in_pool({})) then
                                if pseudorandom('soul_'..v.key.._type..G.GAME.round_resets.ante) > (1 - v.soul_rate) then
                                    if not G.GAME.banned_keys[v.key] then forced_key = v.key end
                                end
            end
        end
        if (_type == 'Tarot' or _type == 'Spectral' or _type == 'Tarot_Planet') and
        not (G.GAME.used_jokers['c_soul'] and not next(find_joker("Showman")))  then
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_soul'
            end
        end
        if (_type == 'Planet' or _type == 'Spectral') and
        not (G.GAME.used_jokers['c_black_hole'] and not next(find_joker("Showman")))  then 
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_black_hole'
            end
        end
    end

    if _type == 'Base' then 
        forced_key = 'c_base'
    end

    if forced_key and not G.GAME.banned_keys[forced_key] then 
        center = G.P_CENTERS[forced_key]
        _type = (center.set ~= 'Default' and center.set or _type)
    else
        local _pool, _pool_key = get_current_pool(_type, _rarity, legendary, key_append)
        center = pseudorandom_element(_pool, pseudoseed(_pool_key))
        local it = 1
        while center == 'UNAVAILABLE' do
            it = it + 1
            center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
        end

        center = G.P_CENTERS[center]
    end
    return center
end

function Entropy.CountStickers()
    local total = 0
    for i, v in pairs(SMODS.Sticker.obj_table) do
        for i2, v2 in pairs(G.I.CARD) do
            if v2.ability and v2.ability[i] then
                total = total + 1
            end
        end
    end
    return total
end

function Entropy.Unhighlight(areas) 
    for i, v in pairs(areas) do
        v:unhighlight_all()
    end
end

function Entropy.Get4bit()
    local key = ""
    local ptype = pseudorandom_element({
        "Booster",
        "Voucher",
        "Joker",
        "Consumeable",
    }, pseudoseed("4bit"))
    if ptype == "Consumeable" then
        return G.P_CENTERS[Cryptid.random_consumable("4bit_c", nil, "c_fool").key]
    end
    return Entropy.GetPooledCenter(ptype)
end

local card_eval_status_text_ref = card_eval_status_text
function card_eval_status_text(card, ...)
    if G.deck and card.area == G.butterfly_jokers and G.deck.cards[1] then
        return card_eval_status_text_ref(G.deck.cards[1], ...)
    else    
        return card_eval_status_text_ref(card, ...)
    end
end

local sell_cardref = Card.sell_card
function Card:sell_card()
    if self.ability.set == "Joker" then
        if Entropy.DeckOrSleeve("butterfly") then
            local bcard = copy_card(self)
            bcard.states.visible = false
            G.jokers:remove_card(bcard)
            bcard:remove_from_deck()
            G.butterfly_jokers:emplace(bcard)
            bcard:add_to_deck()
        end
    end
    sell_cardref(self)
end

local get_next_tagref = Cryptid.get_next_tag
function Cryptid.get_next_tag(override)
    local ref = get_next_tagref and get_next_tagref(override)
    if next(SMODS.find_card('j_entr_dog_chocolate')) then 
        if not G.GAME.dog_tags then G.GAME.dog_tags = {} end
        if G.GAME.dog_tags[(override or G.GAME.blind_on_deck)..G.GAME.round_resets.ante] == nil then
            for i = 1, #SMODS.find_card('j_entr_dog_chocolate') do
                if G.GAME.dog_tags[(override or G.GAME.blind_on_deck)..G.GAME.round_resets.ante] ~= true then
                    G.GAME.dog_tags[(override or G.GAME.blind_on_deck)..G.GAME.round_resets.ante] = pseudorandom_element({true, false, false, false, false}, pseudoseed("dog_chocolate"))
                end
            end
        end
        if G.GAME.dog_tags[(override or G.GAME.blind_on_deck)..G.GAME.round_resets.ante] then return 'tag_entr_dog' end
    end
    if ref then return ref end
end

function Entropy.GetInverseSuit(suit)
    return ({
        Diamonds = "Hearts",
        Hearts = "Diamonds",
        Clubs = "Spades",
        Spades = "Clubs"
    })[suit] or suit
end

function Entropy.GetInverseRank(rank)
    return ({
        ["2"] = "Ace",
        ["3"] = "King",
        ["4"] = "Queen",
        ["5"] = "Jack",
        ["6"] = "10",
        ["7"] = "9",
        ["9"] = "7",
        ["10"] = "6",
        ["11"] = "5",
        ["12"] = "4",
        ["13"] = "3",
        ["14"] = "2"
        --["8"] = 8 duh
    })[tostring(rank)] or rank
end

function Entropy.EvaluateEffects(effects, card)
    for i, v2 in pairs(effects) do
        for i2, result in pairs(v2) do
            SMODS.calculate_individual_effect({[i2] = result}, card, i2, result, false)
        end
    end
end

function Entropy.RerollJoker(card, joker)
    local jokers = {joker}
    local deleted_joker_key = jokers[1].config.center.key
    local rarity = jokers[1].config.center.rarity
    jokers[1].getting_sliced = true
    local legendary = nil
    --please someone add a rarity api to steamodded
    if rarity == 1 then
        rarity = 0
    elseif rarity == 2 then
        rarity = 0.9
    elseif rarity == 3 then
        rarity = 0.99
    elseif rarity == 4 then
        rarity = nil
        legendary = true
    end -- Deleted check for "cry epic" it was giving rare jokers by setting rarity to 1
    local _first_dissolve = nil
    G.E_MANAGER:add_event(Event({
        trigger = "before",
        delay = 0.75,
        func = function()
            jokers[1]:start_dissolve(nil, _first_dissolve)
            _first_dissolve = true
            return true
        end,
    }))
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = 0.4,
        func = function()
            play_sound("timpani")
            local card = create_card("Joker", G.jokers, legendary, rarity, nil, nil, nil, "cry_commit")
            card:add_to_deck()
            G.jokers:emplace(card)
            card:juice_up(0.3, 0.5)
            if card.config.center.key == deleted_joker_key then
                check_for_unlock({ type = "pr_unlock" })
            end
            return true
        end,
    }))
end

function create_UIBox_HUD_blind_doc()
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)
    G.GAME.blind:change_dim(1.5,1.5)
  
    return {n=G.UIT.ROOT, config={align = "cm", minw = 4.5, r = 0.1, colour = G.C.BLACK, emboss = 0.05, padding = 0.05, func = 'HUD_blind_visible', id = 'HUD_blind'}, nodes={
        {n=G.UIT.R, config={align = "cm", minh = 0.7, r = 0.1, emboss = 0.05, colour = G.C.DYN_UI.MAIN}, nodes={
          {n=G.UIT.C, config={align = "cm", minw = 3}, nodes={
            {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.blind, ref_value = 'loc_name'}}, colours = {G.C.UI.TEXT_LIGHT},shadow = true, rotate = true, silent = true, float = true, scale = 1.6*scale, y_offset = -4}),id = 'HUD_blind_name'}},
          }},
        }},
        {n=G.UIT.R, config={align = "cm", minh = 2.74, r = 0.1,colour = G.C.DYN_UI.DARK}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 0.3, maxw = 4.2}, nodes={
              {n=G.UIT.T, config={ref_table = {val = ''}, ref_value = 'val', scale = scale*0.9, colour = G.C.UI.TEXT_LIGHT, func = 'HUD_blind_debuff_prefix'}},
              {n=G.UIT.T, config={ref_table = G.GAME.blind.loc_debuff_lines, ref_value = 1, scale = scale*0.9, colour = G.C.UI.TEXT_LIGHT, id = 'HUD_blind_debuff_1', func = 'HUD_blind_debuff'}}
            }},
            {n=G.UIT.R, config={align = "cm", minh = 0.3, maxw = 4.2}, nodes={
              {n=G.UIT.T, config={ref_table = G.GAME.blind.loc_debuff_lines, ref_value = 2, scale = scale*0.9, colour = G.C.UI.TEXT_LIGHT, id = 'HUD_blind_debuff_2', func = 'HUD_blind_debuff'}}
            }},
          }},
          {n=G.UIT.R, config={align = "cl",padding = 0.15}, nodes={
            {n=G.UIT.O, config={object = G.GAME.blind, draw_layer = 1}},
            {n=G.UIT.C, config={align = "cm",r = 0.1, padding = 0.05, emboss = 0.05, minw = 2.9, colour = G.C.BLACK}, nodes={
              {n=G.UIT.R, config={align = "cm", maxw = 2.8}, nodes={
                {n=G.UIT.T, config={text = localize('ph_blind_score_at_least'), scale = 0.3, colour = G.C.WHITE, shadow = true}}
              }},
              {n=G.UIT.R, config={align = "cm", minh = 0.6}, nodes={
                {n=G.UIT.O, config={w=0.5,h=0.5, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false}},
                {n=G.UIT.B, config={h=0.1,w=0.1}},
                {n=G.UIT.T, config={ref_table = G.GAME.blind, ref_value = 'chip_text', scale = 0.001, colour = G.C.RED, shadow = true, id = 'HUD_blind_count', func = 'blind_chip_UI_scale'}}
              }},
              {n=G.UIT.R, config={align = "cm", minh = 0.45, maxw = 2.8, func = 'HUD_blind_reward'}, nodes={
                {n=G.UIT.T, config={text = localize('ph_blind_reward'), scale = 0.3, colour = G.C.WHITE}},
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.current_round, ref_value = 'dollars_to_be_earned'}}, colours = {G.C.MONEY},shadow = true, rotate = true, bump = true, silent = true, scale = 0.45}),id = 'dollars_to_be_earned'}},
              }},
            }},
          }},
        }},
      }}
end

function Entropy.collect_files(files)
    local items = {}
    for _, v in pairs(files) do
        local f, err = SMODS.load_file(v..".lua")
        if f then 
            local results = f() 
            if results then
                if results.init then results.init(results) end
                if results.items then
                    for i, result in pairs(results.items) do
                        if type(result) == "table" then
                            items[#items+1]=result
                        end
                    end
                end
            end
        else error("error in file "..v..": "..err) end
    end
    return items
end
Entropy.contents = {}
function Entropy.load_files(files)
    local items = {}
    for _, v in pairs(files) do
        local f, err = SMODS.load_file(v..".lua")
        if f then 
            local results = f() 
            if results then
                if results.init then results.init(results) end
                if results.items then
                    for i, result in pairs(results.items) do
                        if type(result) == "table" and result.object_type then
                            if not Entropy.contents[result.object_type] then Entropy.contents[result.object_type] = {} end
                            result.cry_order = result.order
                            Entropy.contents[result.object_type][#Entropy.contents[result.object_type]+1]=result
                        end
                    end
                end
            end
        else error("error in file "..v..": "..err) end
    end
end

function Entropy.has_rune(key)
    for i, v in pairs(G.GAME.runes or {}) do
        if v.key == key and not v.triggered then return v end
    end
end
function Entropy.find_runes(key)
    local runes = {}
    for i, v in pairs(G.GAME.runes or {}) do
        if v.key == key and not v.triggered then runes[#runes+1]=v end
    end
    return runes
end

function Entropy.show_flipside()
    return next(SMODS.find_card("c_entr_flipside")) or next(SMODS.find_card("c_entr_dagaz")) or Entropy.has_rune("rune_entr_dagaz")
end

function Entropy.randomise_once(card, types, seed)
    local mtype = pseudorandom_element(types or {"Enhancement", "Edition", "Seal", "Base"}, pseudoseed(seed or "ihwaz"))    
    if mtype == "Edition" then
        local edition = Entropy.pseudorandom_element(G.P_CENTER_POOLS.Edition, pseudoseed("entropy"),function(e)
            return G.GAME.banned_keys[e.key] or e.no_doe
        end).key
        card:set_edition(edition)
        card:juice_up()
    end
    if mtype == "Enhancement" then
        local enhancement_type = "Enhanced"
        local enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed(seed or "ihwaz")).key
        while G.P_CENTERS[enhancement].no_doe or G.GAME.banned_keys[enhancement] do
            enhancement = pseudorandom_element(G.P_CENTER_POOLS[enhancement_type], pseudoseed(seed or "ihwaz")).key
        end
        card:flip()
        card:set_ability(G.P_CENTERS[enhancement])
        card:flip()
    end
    if mtype == "Seal" then
        local seal = Entropy.pseudorandom_element(G.P_CENTER_POOLS.Seal, pseudoseed("ihwaz"),function(e)
            return G.GAME.banned_keys[e.key] or e.no_doe
        end).key
        card:set_seal(seal)
        card:juice_up()
    end
    if mtype == "Base" then
        card:flip()
        Entropy.randomize_rank_suit(card, true, true, seed or "ihwaz")
        card:flip()
    end
end

function Entropy.randomize_rank_suit(card, rank, suit, seed)
    local ranks = {}
    local suits = {}
    if rank then
        for i, v in pairs(SMODS.Ranks) do
            if not v.in_pool or v:in_pool({}) then ranks[#ranks+1] = i end
        end
    end
    if suit then
        for i, v in pairs(SMODS.Suits) do
            if not v.in_pool or v:in_pool({}) then suits[#suits+1] = i end
        end
    end
    SMODS.change_base(card, pseudorandom_element(suits, pseudoseed(seed)),pseudorandom_element(ranks, pseudoseed(seed)), nil)
end

function Entropy.is_in_shop(key, consumable)
	local center = G.P_CENTERS[key]
	if center.hidden or center.no_doe or center.no_collection then
		return
	elseif G.GAME.banned_keys[key] or not center.unlocked then
		return
	elseif center.set == "Joker" then
		if type(center.rarity) == "number" and center.rarity <= 3 then
			return center.unlocked or nil
		end
		local rare = ({
			"Common",
			"Uncommon",
			"Rare",
		})[center.rarity] or center.rarity
		if
			SMODS.Rarities[rare]
			and (
				SMODS.Rarities[rare].get_weight
				or (SMODS.Rarities[rare].default_weight and SMODS.Rarities[rare].default_weight > 0)
			)
		then
			return center.unlocked or nil
		end
		return nil
	else
		if consumable then
			if center.set == "Tarot" then
				return G.GAME.tarot_rate * (G.GAME.cry_percrate.tarot / 100) > 0 or nil
			end
			if center.set == "Planet" then
				return G.GAME.planet_rate * (G.GAME.cry_percrate.planet / 100) > 0 or nil
			end
			if center.set == "Spectral" then
				return G.GAME.spectral_rate > 0 or nil
			end
			local num = G.GAME.cry_percrate and G.GAME.cry_percrate[center.set:lower()] or 100
			local val = G.GAME[center.set:lower() .. "_rate"] * ((num or 100) / 100)
			return val > 0
		end
	end
	if center.in_pool then
		return center:in_pool({})
	end
	return center.unlocked or nil
end

function Entropy.misc_calculations(self, context)
    if not context then return end
    if context.repetition and context.cardarea == G.play then 
        local repetitions = 0
        local chains_count = Entropy.has_rune("rune_entr_chains") and Entropy.has_rune("rune_entr_chains").ability.count or 0
        if (SMODS.is_eternal(context.other_card) or context.other_card.ability.eternal) and chains_count > 0 then
            repetitions = repetitions + chains_count
        end
        if repetitions > 0 then
            return {repetitions = repetitions, message = localize("k_again_ex"), card = context.other_card}
        end
    end
end

if not Cryptid.reset_to_none then
    function Cryptid.reset_to_none()
        update_hand_text({ delay = 0 }, {
            mult = 0,
            chips = 0,
            level = "",
            handname = "",
        })
    end
end

local reset_ref = Cryptid.reset_to_none
function Cryptid.reset_to_none()
    reset_ref()
    update_hand_text({ delay = 0.1 }, {
        level = "",
    })
end

function Entropy.true_suitless(card)
    if SMODS.has_no_suit(card) or card.config.center.key == "m_stone" 
    or card.config.center.overrides_base_rank 
    or card.base.suit == "entr_nilsuit" 
    or card.base.value == "entr_nilrank" then return true end
end

function Entropy.played_hands(threshold)
    local total = 0
    for i, v in pairs(G.GAME.hands or {}) do
        if to_big(v.played) > to_big(threshold) then
            total = total + 1
        end
    end
    return total
end

function Entropy.calculate_ratios(incl_vanilla, only_vanilla)
    local total = 0
    local rarities = {}
    for i, v in pairs(G.P_CENTER_POOLS.Joker) do
        if (not only_vanilla and v.original_mod and v.original_mod.id == "entr") or (incl_vanilla and not v.original_mod) then
            total = total + 1
            if not rarities[v.rarity] then rarities[v.rarity] = 0 end
            rarities[v.rarity] = rarities[v.rarity] + 1
        end
    end
    for i, v in pairs(rarities) do
        print(i.." = "..v.. " = "..(v/total * 100).."%")
    end
    print("total: "..total)
end

function Entropy.return_to_deck()
    return Entropy.BlindIs("bl_entr_cassandra") or Entropy.BlindIs("bl_entr_pi")
end

function Entropy.get_bg_colour()
    if TDECKS then
        local ret = TDECKS.get_bg_colour()
        if ret then return ret end
    end
    return G.GAME.entr_alt and G.C.ALTBG or G.C.BLIND['Small']
end

function Entropy.allow_spawning(center)
    for i, v in pairs(G.I.CARD) do
        if v.config and v.config.center and center and v.config.center.key == center.key then return SMODS.showman(center.key) or nil end
    end
    return true
end