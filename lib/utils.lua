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

function Entropy.stringsplit(s) 
    local tbl = {}
    for i = 1, #s do
        tbl[#tbl+1]=s:sub(i,i)
    end
    return tbl
end

function Entropy.HigherCardRank(card)
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
function Entropy.ApplySticker(card, key)
    if not card.ability then card.ability = {} end
    if card.ability then
        if not SMODS.Stickers[key] then return end
        card.ability[key] = true
        if SMODS.Stickers[key].apply then SMODS.Stickers[key].apply(SMODS.Stickers[key], card) end
    end
end

function Entropy.GetHighlightedCard(areas, blacklist)
    for i, v in pairs(areas or G) do
        if type(v) == "table" and v.cards and v.highlighted then
            if #v.highlighted > 0 then
                if not (blacklist or {})[v.highlighted[1].config.center.key] then return v.highlighted[1] end
            end
        end
    end
end
function Entropy.GetHighlightedCards(areas, blacklist)
    local total = 0
    local cards = {}
    for i, v in pairs(areas or G) do
        if type(v) == "table" and v.cards and v.highlighted then
            if #v.highlighted > 0 then
                for i2, v2 in pairs(v.highlighted) do
                    if not (blacklist or {})[v.highlighted[i2].config.center.key] then total=total+1;cards[#cards+1]=v2 end
                end
            end
        end
    end
    return total,cards
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
function Entropy.ReverseFlipsideInversions()
    for i, v in pairs(Entropy.FlipsideInversions) do if i and Entropy.FlipsideInversions[i] and v then Entropy.FlipsideInversions[v] = i end end
end

function Entropy.SafeGetNodes(ind, card)
    if card and card.config and card.config.h_popup 
    and card.config.h_popup.nodes and card.config.h_popup.nodes[1]
    and card.config.h_popup.nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1]
    and card.config.h_popup.nodes[1].nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1].nodes[1]
    and card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes and card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[ind] then
    return card.config.h_popup.nodes[1].nodes[1].nodes[1].nodes[ind] end
end

function Entropy.MergeLocTables(t1, t2)
    for i, v in pairs(t2) do table.insert(t1, v) end
    return t1
end

function Entropy.Again(card, del)
    local delay = del or 0.6
    G.E_MANAGER:add_event(Event({ --Add bonus chips from this card
    trigger = 'before',
    delay = delay,
    func = function()
        if extrafunc then extrafunc() end
            attention_text({
                text = localize("k_again_ex"),
                scale = 1, 
                major = card,
                background_colour = G.C.FILTER,
                align = "tm",
                hold = delay - 0.2,
            })
            play_sound("generic1", 0.8, 1)
            card:juice_up(0.6, 0.1)
            G.ROOM.jiggle = G.ROOM.jiggle + 0.7
            return true
        end
    }))
end

function Entropy.TriggersInHand(card)
    if Cryptid.safe_get(SMODS.Ranks,Cryptid.safe_get(card,'base','value') or 'm','key') == 'King' and HasJoker("j_baron") then return true
    else
        local res = eval_card(card, {cardarea=G.hand, main_scoring=true})
        return res.playing_card and #res.playing_card > 0
    end
end

function Entropy.FlipThen(cardlist, func, before, after)     
    for i, v in pairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if before then before(card) end
                    if card.flip then card:flip() end
                    return true
                end
            }))
        end
    end
    for i, v in pairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    func(card, cardlist, i)
                    return true
                end
            }))
        end
    end
    for i, v in pairs(cardlist) do
        local card = cardlist[i]
        if card then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.1,
                func = function()
                    if card.flip then card:flip() end
                    if after then after(card) end
                    return true
                end
            }))
        end
    end
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

function Entropy.SealSpectral(key, sprite_pos, seal)
    SMODS.Consumable({
        key = key,
        set = "RSpectral",
        unlocked = true,
        atlas = "miscc",
        config = {
            highlighted = 1
        },
        pos = sprite_pos,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.ModifyHandCard({seal=seal}),
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.highlighted
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
    })
end

function Entropy.ModificationSpectral(key, sprite_pos, modifications, highlighted, loc_vars)
    SMODS.Consumable({
        key = key,
        set = "RSpectral",
        unlocked = true,
        atlas = "miscc",
        config = {
            highlighted = highlighted or 1
        },
        pos = sprite_pos,
        --soul_pos = { x = 5, y = 0},
        use = Entropy.ModifyHandCard({seal=seal}),
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            for i, v in pairs(modifications) do
                if i ~= "suit" and i ~= "rank" and i ~= "extra" then
                    q[#q+1] = Entropy.GetModificationQueue(i, v)
                end
            end
            return {
                vars = loc_vars or {
                    card.ability.highlighted,
                }
            }
        end,
    })
end

function Entropy.AllAreaCards(selector)
    local cards = {}
    for i, v in pairs(G) do
        if type(v) == "table" and v.cards then
            for i2, card in pairs(v.cards)do
                if not selector or selector(card) then
                    cards[#cards+1]=card
                end
            end
        end
    end 
    return cards
end

function Entropy.RandomModificationSpectral(key, sprite_pos, modifications, highlighted, loc_vars)
    SMODS.Consumable({
        key = key,
        set = "RSpectral",
        unlocked = true,
        atlas = "miscc",
        config = {
            highlighted = highlighted or 1
        },
        pos = sprite_pos,
        --soul_pos = { x = 5, y = 0},
        use = function(self, card, area) 
            local cards = {}
            for i = 1, highlighted do
                local ind = -1
                local tries = 100
                while (ind == -1 or cards[ind]) and tries > 0 do
                    ind = Entropy.Pseudorandom(key, 1, #G.hand)
                    tries = tries - 1
                end
                cards[ind] = true
            end
            for i, v in pairs(cards) do cards[i] = G.hand.cards[i] end
            Entropy.ModifyHandCard(modifications, cards)
        end,
        can_use = function(self, card)
            return G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.highlighted
        end,
        loc_vars = function(self, q, card)
            for i, v in pairs(modifications) do
                if i ~= "suit" and i ~= "rank" and i ~= "extra" then
                    q[#q+1] = Entropy.GetModificationQueue(i, v)
                end
            end
            return {
                vars = loc_vars or {
                    card.ability.highlighted,
                }
            }
        end,
    })
end


function Entropy.GetModificationQueue(mtype, key)
    if mtype == "seal" or mtype == "sticker" then return {key = key..(mtype == "seal" and "_seal" or ""), set="Other"} end
    if mtype == "edition" then return {key = key, set="Edition"} end
    if mtype == "enhancement" then return {key = key, set="Enhanced"} end
end

function Entropy.Pseudorandom(seed, min, max)
    return math.floor(pseudorandom(seed)*(max-min)+0.5)+min
end

function Entropy.FilterArea(area, func)
    local cards = {}
    for i, v in pairs(area) do
        if func(v) then cards[#cards+1] = v end
    end
    return cards
end

function Entropy.FindPreviousInPool(item, pool)
    for i, v in pairs(G.P_CENTER_POOLS[pool]) do
        if G.P_CENTER_POOLS[pool][i].key == item then
            return G.P_CENTER_POOLS[pool][i-1].key
        end
    end
    return nil
end

math.randomseed(os.time())
Entropy.charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890~#$^~#$^~#$^~#$^~#$^"
function srandom(length) 
    local total = ""
    for i = 0, length do
        local val = math.random(1,#Entropy.charset)
        total = total..(Entropy.charset:sub(val, val))
    end
    return total
end

function Entropy.GetHigherVoucherTier(voucher_key)
    for i, v in pairs(G.P_CENTER_POOLS.Voucher) do
        if Entropy.InTable(v.requires or {}, voucher_key) then return v.key end
    end
end

function Entropy.InTable(table,val)
    for i, v in pairs(table) do if v == val then return i end end
end

function Entropy.FormatDollarValue(dollars)
    if to_big(dollars) < to_big(0) then return "-$"..(-dollars) end
    return "$"..dollars
end

function Entropy.FormatArrowMult(arrows, mult)
    mult = number_format(mult)
    if to_big(arrows) < to_big(-1) then 
        return "="..mult 
    elseif to_big(arrows) < to_big(0) then 
        return "+"..mult 
    elseif to_big(arrows) < to_big(6) then 
        if to_big(arrows) < to_big(1) then
            return "X"..mult
        end
        local arr = ""
        for i = 1, to_big(arrows):to_number() do
            arr = arr.."^"
        end
        return arr..mult
    else
        return "{"..arrows.."}"..mult
    end
end

function Entropy.DeckOrSleeve(key)
    if key == "doc" and G.GAME.modifiers.doc_antimatter then return true end
    if key == "twisted" and G.GAME.modifiers.twisted_antimatter then return true end
    if CardSleeves then
        if G.GAME.selected_sleeve == ("sleeve_entr_"..key) then return true end
    end
    for i, v in pairs(G.GAME.entr_bought_decks or {}) do
        if v == "b_entr_"..key then return true end
    end
    return G.GAME.selected_back and G.GAME.selected_back.effect.center.original_key == key
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

C = SMODS.load_file("lib/combine.lua")()

function Entropy.GetRecipeResult(val,jokerrares,seed)
    local rare = 1
    local cost=0
    for i, v in pairs({
        [1]=0,
        [2]=6,
        [3]=12,
        cry_epic=20,
        [4]=30,
        cry_exotic=45
    }) do
        if v > cost and val >= v then
            rare = i;cost=v
        end
    end
    return pseudorandom_element(jokerrares[rare], pseudoseed(seed))
end
function Entropy.ConcatStrings(tbl)
    local result = ""
    for i, v in pairs(tbl) do result = result..v end
    return result
end



function Entropy.GetRecipe(cards)
    local enhancements = {
        c_base=1,
        m_bonus=3.1,
        m_mult=3.2,
        m_wild=4.1,
        m_glass=7.1,
        m_steel=6.1,
        m_stone=5.1,
        m_gold=6.2,
        m_lucky=4.2,
        m_cry_echo=6.2,
        m_cry_light=7.2,
        m_entr_flesh=5.2,
        m_entr_disavowed=0,
        m_cry_abstract=9.1
    }
    local rares = {}
    for i, v in pairs(G.P_CENTER_POOLS.Joker) do
        if not rares[v.rarity] then rares[v.rarity] = {} end
        rares[v.rarity][#rares[v.rarity]+1] = v.key
    end
    local enh = {}
    for i = 1, 5 do
        local card = cards[i]
        enh[#enh+1]=card.config.center.key
    end
    local sum = 0
    for i, v in pairs(enh) do
        if not enhancements[v] then
            enhancements[v] = 4.5 + math.random()*0.1-0.05
        end
        sum = sum + (enhancements[v] or 4.5) 
    end
    table.sort(enh, function(a,b)return (enhancements[a])>(enhancements[b]) end)
    G.GAME.JokerRecipes = G.GAME.JokerRecipes or {}
    if not G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)] then
        G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)]=Entropy.GetRecipeResult(sum, rares,Entropy.ConcatStrings(enh))
    end
    return Entropy.FixedRecipes[Entropy.ConcatStrings(enh)] or G.GAME.JokerRecipes[Entropy.ConcatStrings(enh)]
end

Entropy.DiscardSpecific = function(cards)
    for i, v in pairs(cards) do
        draw_card(G.hand, G.discard, i*100/#cards, 'down', false, v)
    end
end

function Entropy.OddsTriggers(card, seed, odds, numerator)
    numerator = (numerator or 1) * G.GAME.probabilities.normal * (card.ability.cry_prob or 1)
    if card.ability.cry_rigged then numerator = odds end
    return pseudorandom(seed)*numerator < 1.0/odds
end
function Entropy.GetOddsLocs(card, odds, numerator)
    if card.ability.cry_rigged then return odds end
    return (numerator or 1) * G.GAME.probabilities.normal * (card.ability.cry_prob or 1)
end

function Entropy.BlindIs(orig, newkey)
    if orig.config.blind.key  == newkey then return true end
    if G.P_BLINDS[orig.config.blind.key] and G.P_BLINDS[orig.config.blind.key].counts_as and G.P_BLINDS[orig.config.blind.key].counts_as[newkey] then return true end
    if orig.counts_as and orig.counts_as[newkey] then return true end
    return false
end

function Entropy.RareTag(rarity, key, ascendant, colour, pos, fac, legendary)
    SMODS.Tag {
        shiny_atlas="entr_shiny_ascendant_tags",
        key = (ascendant and "ascendant_" or "")..key.."_tag",
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

function Entropy.EditionTag(edition, key, ascendant, pos)
    SMODS.Tag {
        shiny_atlas="entr_shiny_ascendant_tags",
        key = (ascendant and "ascendant_" or "")..key.."_tag",
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
        end
    }
end
function create_UIBox_blind_select()
    if G.GAME.USING_BREAK then
        G.E_MANAGER:add_event(Event({
			trigger = "after",
            blocking = false,
            delay = 3,
			func = function()
                G.STATE = 7
                --G.blind_select:remove()
                --G.blind_prompt_box:remove()
                G.FUNCS.draw_from_hand_to_deck()
				return true
			end,
		}))
        G.GAME.USING_BREAK = nil
    end
    local reroll = (G.GAME.used_vouchers["v_retcon"] or G.GAME.used_vouchers["v_directors_cut"]) and
    UIBox_button({label = {localize('b_reroll_boss'), localize('$')..Cryptid.cheapest_boss_reroll()}, button = "reroll_boss", func = 'reroll_boss_button'}) or nil
    if reroll and (G.GAME.round_resets.ante_disp == "32" or G.GAME.EEBuildup) then
        reroll = UIBox_button({label = {localize('b_cant_reroll'), localize('$').."Infinity"}, button = "reroll_boss", func = 'reroll_boss_button'})
    end
  G.blind_prompt_box = UIBox{
    definition =
      {n=G.UIT.ROOT, config = {align = 'cm', colour = G.C.CLEAR, padding = 0.2}, nodes={
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_1'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.6, pop_in = 0.5, maxw = 5}), id = 'prompt_dynatext1'}}
        }},
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = localize('ph_choose_blind_2'), colours = {G.C.WHITE}, shadow = true, bump = true, scale = 0.7, pop_in = 0.5, maxw = 5, silent = true}), id = 'prompt_dynatext2'}}
        }},
        reroll
      }},
    config = {align="cm", offset = {x=0,y=-15},major = G.HUD:get_UIE_by_ID('row_blind'), bond = 'Weak'}
  }
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    func = (function()
        G.blind_prompt_box.alignment.offset.y = 0
        return true
    end)
  }))

  local width = G.hand.T.w
  G.GAME.blind_on_deck = 
    not (G.GAME.round_resets.blind_states.Small == 'Defeated' or G.GAME.round_resets.blind_states.Small == 'Skipped' or G.GAME.round_resets.blind_states.Small == 'Hide') and 'Small' or
    not (G.GAME.round_resets.blind_states.Big == 'Defeated' or G.GAME.round_resets.blind_states.Big == 'Skipped'or G.GAME.round_resets.blind_states.Big == 'Hide') and 'Big' or 
    'Boss'
  
  G.blind_select_opts = {}
  if G.GAME.round_resets.red_room then
    G.GAME.blind_on_deck = "Red"
    if not G.GAME.round_resets.blind_choices["Red"] then
        G.GAME.round_resets.blind_choices["Red"] = "bl_entr_red"
    end
    if not G.GAME.round_resets.blind_states['Red'] then
        G.GAME.round_resets.blind_states['Red'] = "Select"
    end
    G.GAME.RedBlindStates = {}
    for i, v in pairs(G.GAME.round_resets.blind_states) do G.GAME.RedBlindStates[i] = v end
    G.GAME.round_resets.loc_blind_states.Red = "Select"
    G.blind_select_opts.red = G.GAME.round_resets.blind_states['Red'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Red')},false,get_blind_main_colour('Red'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    if G.GAME.modifiers.zenith then
        for i, v in pairs(G.GAME.round_resets.blind_choices) do
            G.GAME.round_resets.blind_choices[i] = "bl_entr_endless_entropy_phase_one"
        end
    end
    local t = {n=G.UIT.ROOT, config = {align = 'tm',minw = width, r = 0.15, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
        G.GAME.round_resets.blind_states['Red'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.red}} or nil,
        }}
    }}
    G.GAME.round_resets.red_room = nil
    return t 
  else
    if G.GAME.modifiers.zenith then
        for i, v in pairs(G.GAME.round_resets.blind_choices) do
            G.GAME.round_resets.blind_choices[i] = "bl_entr_endless_entropy_phase_one"
        end
    end
    if Entropy.AllowNaturalEE() then
        if G.GAME.round_resets.ante_disp == "32" or G.GAME.EEBuildup then    
            G.GAME.round_resets.blind_choices["Boss"] = "bl_entr_endless_entropy_phase_one"
            G.GAME.EEBuildup = true
        end
    end
    G.blind_select_opts.small = G.GAME.round_resets.blind_states['Small'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Small')},false,get_blind_main_colour('Small'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    G.blind_select_opts.big = G.GAME.round_resets.blind_states['Big'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Big')},false,get_blind_main_colour('Big'))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    G.blind_select_opts.boss = G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and UIBox{definition = {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))}}, config = {align="bmi", offset = {x=0,y=0}}} or nil
    
    local t = {n=G.UIT.ROOT, config = {align = 'tm',minw = width, r = 0.15, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.R, config={align = "cm", padding = 0.5}, nodes={
        G.GAME.round_resets.blind_states['Small'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.small}} or nil,
        G.GAME.round_resets.blind_states['Big'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.big}} or nil,
        G.GAME.round_resets.blind_states['Boss'] ~= 'Hide' and {n=G.UIT.O, config={align = "cm", object = G.blind_select_opts.boss}} or nil,
        }}
    }}
    return t 
  end
end

function Entropy.AllowNaturalEE()
    if MP and MP.LOBBY then return false end
    return true
end

function HasJoker(key,debuff)
    if not G.jokers then return nil end
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        if (not v.debuff or not debuff) and v.config.center.key == key then total = total + 1 end
    end
    return total > 0 and total or nil
end
function HasConsumable(key)
    for i, v in pairs(G.consumeables.cards) do
        if v.config.center.key == key then return true end
    end
    return false
end
function GetJokerSumRarity(loc)
    if not G.jokers or #G.jokers.cards <= 0 then return "none" end
    local rarity = 1
    local sum = SumJokerPoints()
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
function SumJokerPoints()
    local total = 0
    for i, v in pairs(G.jokers.cards) do
        total = total + GetJokerPoints(v)
    end
    return total
end
function GetJokerPoints(card)
    local total = Entropy.RarityPoints[card.config.center.rarity] or 1
    if card.edition then
        local factor = to_big(GetEditionFactor(card.edition)) ^ (1.7/(Entropy.RarityDiminishers[card.config.center.rarity] or 1))
        total = total * factor
    end
    return total
end 
function GetEditionFactor(edition)
    return Entropy.EditionFactors[edition.key] or 1
end

function Entropy.GetEEBlinds()
    local blinds = {}
    for i, v in pairs(G.P_BLINDS) do
        if v.boss and v.boss.showdown and not v.no_ee and not Entropy.EEBlacklist[i] then
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

function Entropy.RandomForcetrigger(card, num)
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