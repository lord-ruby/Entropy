Entropy.RarityChecks = {
    [0]="cry_candy",
    1,
    2,
    3,
    "cry_epic",
    4,
    "cry_exotic",
    "entr_hyper_exotic"
}
Entropy.RarityUppers = {
    ["cry_candy"]=1,
    [1]=2,
    [2]=3,
    [3]="cry_epic",
    ["cry_epic"]=4,
    [4]="cry_exotic",
    ["cry_exotic"]="entr_hyper_exotic"
}
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
    for i, v in pairs(areas or G) do
        if type(v) == "table" and v.cards and v.highlighted then
            if #v.highlighted > 0 then
                for i2, v2 in pairs(v.highlighted) do
                    if not (blacklist or {})[v.highlighted[i2].config.center.key] then total=total+1 end
                end
            end
        end
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
                    card:flip()
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
                    card:flip()
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
        discovered = true,
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
        discovered = true,
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
        discovered = true,
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